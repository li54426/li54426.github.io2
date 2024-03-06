---
layout: blog
title: "cpp_STL_1_alloctor"
date:   2023-07-25 21:19:24 
categories: cpp
background: green
tags:
- cpp
- STL
---



* content
{:toc}




### 1 allocator( 配置器 )

#### 1.1 代码分布

- <stl_construct.h> 定义了全局函数construct()和destroy()，负责对象的构造和析构。
- <stl_alloc.h> 定义了一二级配置器，配置器统称为alloc而非allocator！
- <stl_uninitialized.h> 定义了一些全局函数，用来填充(fill)或者复制(copy)大块内存数据，也隶属于STL标准规范。

G 2.9 使用的是 alloc, 在G4.9中，分配器变成了new_allocator，旧的分配器alloc改名为_pool_alloc。STL标准告诉我们, 分配器在**<memory>**中, 

考虑到小型区块所可能造成的内存破碎问题,SGI设计了双层级配置器, 

**第一级配置器直接使用malloc()和free()**, SGI第一级配置器的 allocate()和realloc都是在调用malloc和realloc()；不成功后，改调用oom_malloc()和oom_realloc();后两者都有内循环不断调用客户端注册的"__malloc_alloc_oom_handler “，以期望在某次调用之后获得足够的内存而圆满完成任务，但是如果没有注册”__malloc_alloc_oom_handler "，那么oom_malloc()和oom_realloc()便直接丢出bad_alloc异常信息或者exit(1)硬生生终止程序。

第二级配置器则视情况采用不同的策略:当配置区块超过128 bytes时, 视之为"足够大",便调用第一级配置器;**当配置区块小于128 bytes时,视之为"过小",为了降低额外负担, 便采用复杂的memory pool**整理方式,而不再求助于第一级配置器 .

所谓C++ new handler 机制是，你可以要求系统在内存配置需求无法被满足时，调用一个你所指定的函数。换句话说，-旦：：operator new无法完成任务，在丢出std:：bad_alloc异常状态之前，会先调用由客端指定的处理例程，该处理例

	整个 STL 的操作对象 都放在容器之内, 容器一定需要空间以配置资料
	
	STL规则告诉我们配置器定义与<memory>中, 

```c
//----------memory.h----------
#include <stl_alloc.h>
#include <stl_construct.h>
```



#### 1.2 defalloc.h

```c++
// 文件目录 defalloc.h
//仅仅是对 malloc 的包装
template <class T>
class allocator {
public:
    pointer allocate(size_type n) { 
		return ::allocate((difference_type)n, (pointer)0);//函数2
    }
    void deallocate(pointer p) { ::deallocate(p); }
    pointer address(reference x) { return (pointer)&x; }
    const_pointer const_address(const_reference x) { 
		return (const_pointer)&x; 
    }
    size_type init_page_size() { 
		return max(size_type(1), size_type(4096/sizeof(T))); 
    }
    size_type max_size() const { 
		return max(size_type(1), size_type(UINT_MAX/sizeof(T))); 
    }
};

//函数2
template <class T>
inline T* allocate(ptrdiff_t size, T*) {
    set_new_handler(0);
    T* tmp = (T*)(::operator new((size_t)(size * sizeof(T))));
    if (tmp == 0) {
	cerr << "out of memory" << endl; 
	exit(1);
    }
    return tmp;
}

```

#### 1.3  stl_alloc.h   __malloc_alloc_template

```c++
// stl_alloc.h   __malloc_alloc_template

// 第一级配置器
// 该泛型类没有类型参数；
//“__inst”是一个写死的int类型，但无实际意义
template <int __inst>
class __malloc_alloc_template {

private:
  	//以下两个函数是，malloc 申请失败后（内存不足时）的处理方法
	//用来申请空间，参数是申请的大小
  static void* _S_oom_malloc(size_t);  
  //用来扩增一个旧的内存空间
  //参数1，是旧的空间地址；参数2，是重新申请的大小
  static void* _S_oom_realloc(void*, size_t);

#ifndef __STL_STATIC_TEMPLATE_MEMBER_BUG
  //这是一个函数指针（指向函数的指针）
  static void (* __malloc_alloc_oom_handler)();
#endif

public:
  static void* allocate(size_t __n) {
	  // 调用 malloc()
    void* __result = malloc(__n);
    // 如果申请失败，改用 _S_oom_malloc()
    if (0 == __result) __result = _S_oom_malloc(__n);
    return __result;
  }

  //释放空间，参数1，地址指针；参数2，大小
  //（很显然这里的第二参数没有意义）
  // 调用 free()释放空间
  static void deallocate(void* __p, size_t /* __n */)
  {
    free(__p);
	//(为何__n 没有意义，c语言得知，free释放空间，是全部释放，不存在只释放一部分的情况)
  }
  
  //对一段旧空间扩容
  static void* reallocate(void* __p, size_t /* old_sz */, size_t __new_sz)
  {
    void* __result = realloc(__p, __new_sz);
	// 如果申请失败，改用 _S_oom_malloc()
    if (0 == __result) __result = _S_oom_realloc(__p, __new_sz);
    return __result;
  }

  //动态指定，针对内存不足时的处理方法（注意书写格式）
  static void (* __set_malloc_handler(void (*__f)()))()
  {
    void (* __old)() = __malloc_alloc_oom_handler;
    __malloc_alloc_oom_handler = __f;
    return(__old);
  }
};

// malloc_alloc 针对内存不足时的处理方法
#ifndef __STL_STATIC_TEMPLATE_MEMBER_BUG
// 默认为0
template <int __inst>
void (* __malloc_alloc_template<__inst>::__malloc_alloc_oom_handler)() = 0;
#endif

template <int __inst>
void*
__malloc_alloc_template<__inst>::_S_oom_malloc(size_t __n)
{
    void (* __my_malloc_handler)(); //声明一个处理内存不足的函数指针；
    void* __result;  

    // 一直申请直到失败或成功
    for (;;) {
        __my_malloc_handler = __malloc_alloc_oom_handler;
		//当 "内存不足处理方法" 并未被设置，便调用 __THROW_BAD_ALLOC，抛出异常信息
        if (0 == __my_malloc_handler) { __THROW_BAD_ALLOC; }
		// 调用内存不足时的处理函数
        (*__my_malloc_handler)();  
        __result = malloc(__n);   // 再次尝试申请内存
        if (__result) return(__result);
    }
}

//  给一个已经分配了地址的指针重新分配空间
template <int __inst>
void* __malloc_alloc_template<__inst>::_S_oom_realloc(void* __p, size_t __n)
{
    void (* __my_malloc_handler)();
    void* __result;
    for (;;) {
        __my_malloc_handler = __malloc_alloc_oom_handler;
        if (0 == __my_malloc_handler) { __THROW_BAD_ALLOC; }
        (*__my_malloc_handler)();   
        __result = realloc(__p, __n);  
        if (__result) return(__result);
    }
}
```

#### 1.4 stl_alloc.h   __default_alloc_template

> 两级结构, 第一级是  链表( free list )  第二级是内存池  内存池不够的话, 继续 malloc
>
> 其实 free list 可以和内存池相互转换, 
>
> 当 free list 某个大小的结点不足时, 可以调用内存池中的内存
>
> 当内存池空的时候, 可以从free list中 调用 内存

```python
if(链表够):
    从链表中取
else:
    if(内存池够):
        从内存池中取(static refill(size_t __n)函数)
        refill调用 static _chunk_alloc(ize_t __size, int &__nobjs)函数
        
```



```c++
// stl_alloc.h   __default_alloc_template

template <bool threads, int inst>
class __default_alloc_template
{
private:
    static const int _ALIGN = 8; // 调整到 8字节
    static const int _MAX_BYTES = 128; // 最大字节数
    static const int _NFREELISTS = 16; // free lists 数目 _MAX_BYTES/_ALIGN

    static size_t _S_round_up(size_t __bytes){// 调整到 8字节
        return (((__bytes) + (size_t) _ALIGN-1) & ~((size_t) _ALIGN - 1));
    }

    union _Obj{
        union _Obj* _M_free_list_link;
        char _M_client_data[1];   
    };//感觉定义一个结构体, 元素只有一个 指向 自己的 地址也可以
	
    // 静态变量
    static _Obj* volatile _S_free_list[];

    // 确定应在哪个 list
    static size_t _S_freelist_index(size_t __bytes){
        return (((__bytes) + (size_t)_ALIGN-1)/(size_t)_ALIGN - 1);
    }


    static void* _S_refill(size_t __n);
    static char* _S_chunk_alloc(size_t __size, int &__nobjs);

    // Chunk allocation state, chunk_alloc 里使用
    static char* _S_start_free; // 内存池起始地址
    static char* _S_end_free; // 内存池结束地址
    static size_t _S_heap_size; // 内存池大小

public:
    //-------接口----------
    static void *allocate(size_t __n){
        void *__ret = 0;

        if (__n > (size_t) _MAX_BYTES){
            __ret = malloc_alloc::allocate(__n);
        }
        else{
            //volatile 告诉编译器 不进行优化
            _Obj* volatile* __my_free_list = _S_free_list + _S_freelist_index(__n);

            _Obj* __result = *__my_free_list;
            if (__result == 0) 
                __ret = _S_refill(_S_round_up(__n)); //重填链表
            else{
                //和链表一样, 指向下一个结点
                *__my_free_list = __result -> _M_free_list_link;
                __ret = __result;
            }
        }

        return __ret;
    };

    static void deallocate(void* __p, size_t __n){
        //  小于128的存储块, 要将他返回到那个链表中
        if (__n > (size_t) _MAX_BYTES)
            malloc_alloc::deallocate(__p, __n);
        else
        {
            _Obj* volatile* __my_free_list = _S_free_list + _S_freelist_index(__n);
            _Obj* __q = (_Obj*)__p;

            __q -> _M_free_list_link = *__my_free_list;
            *__my_free_list = __q;
        }
    }

    static void* reallocate(void* __p, size_t __old_sz, size_t __new_sz){
        void *__result;
        size_t __copy_sz;

        if (__old_sz > (size_t) _MAX_BYTES && __new_sz > (size_t) _MAX_BYTES){
            //原来的大小比128大
            return(realloc(__p, __new_sz));
        }
        if (_S_round_up(__old_sz) == _S_round_up(__new_sz)) return(__p);
        __result = allocate(__new_sz);
        __copy_sz = __new_sz > __old_sz? __old_sz : __new_sz;
        memcpy(__result, __p, __copy_sz);
        deallocate(__p, __old_sz);
        return(__result);
    }
};


template <bool __threads, int __inst>
char* __default_alloc_template<__threads, __inst>::_S_start_free = 0;

template <bool __threads, int __inst>
char* __default_alloc_template<__threads, __inst>::_S_end_free = 0;

template <bool __threads, int __inst>
size_t __default_alloc_template<__threads, __inst>::_S_heap_size = 0;

template <bool __threads, int __inst>
typename __default_alloc_template<__threads, __inst>::_Obj* volatile
__default_alloc_template<__threads, __inst> ::_S_free_list[
    __default_alloc_template<__threads, __inst>::_NFREELISTS
] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

```

```c++
// 返回一个大小为 n 的对象(假定 n 已经适当上调至 8 的倍数), 
// 因为free list中没有了节点, 所以尝试为对应的 free list 增加节点数目
// 默认取得20个新节点, 但如果内存池空间不足,获得的节点数可能小于20, 其中一个节点返回给调用者, 剩下的节点添入对应 free list

template <bool __threads, int __inst>
void *__default_alloc_template<__threads, __inst>::
_S_refill(size_t __n){
    //重填链表, 默认重新要20个节点
    int __nobjs = 20;
    // 注意参数 nobjs 是引用类型
    char* __chunk = _S_chunk_alloc(__n, __nobjs);
    _Obj* volatile* __my_free_list;
    _Obj* __result;
    _Obj* __current_obj;
    _Obj* __next_obj;

    // 仅获得一个区块, 分配给调用者用, free list 无新节点
    if (1 == __nobjs) return(__chunk);

    // 将多余区块纳入 free list
    __my_free_list = _S_free_list + _S_freelist_index(__n);
    __result = (_Obj*)__chunk;
    *__my_free_list = __next_obj = (_Obj*)(__chunk + __n);
    
    // 因为原始的内存里面的内容都是空的, 或者没有意义的, 需要将各节点串联起来, 第0个区块将返回给调用者
    for (int __i = 1; __i < __nobjs - 1; __i++){
        __current_obj = __next_obj;
        __next_obj = (_Obj*)((char*)__next_obj + __n);
        __current_obj -> _M_free_list_link = __next_obj;
    }
    __next_obj -> _M_free_list_link = 0;
    return(__result);
}


// 被 refill() 调用, 从内存池中取空间给 free list 使用
// 个人感觉没有必要, 毕竟这一个函数也只有 refill 调用(错误)
// 为了递归调用自己(从freelist中找到了能用的 块 )
// 分配 nobjs 个大小为 size 的区块, 
template <bool __threads, int __inst>
char *__default_alloc_template<__threads, __inst>::
_S_chunk_alloc(size_t __size, int &__nobjs){
    char *__result;
    size_t __total_bytes = __size * __nobjs;
    size_t __bytes_left = _S_end_free - _S_start_free; // 内存池剩余空间

    if (__bytes_left >= __total_bytes){
        // 内存池剩余空间完全满足需求量
        __result = _S_start_free;
        _S_start_free += __total_bytes;
        return(__result);
    }
    else if (__bytes_left >= __size){
        // 内存池剩余空间不能完全满足需求量, 但能够供应至少一个区块
        __nobjs = (int)(__bytes_left/__size);
        __total_bytes = __size * __nobjs;
        __result = _S_start_free;
        _S_start_free += __total_bytes;
        return(__result);
    }
    else{
        // 内存池剩余空间连一个区块的大小能不能提供
        // 利用 malloc() 从 heap 中配置内存, 大小为需求量的两倍, 再加上一个随着配置次数增加而越来越大的附加量
        size_t __bytes_to_get = 2 * __total_bytes + _S_round_up(_S_heap_size >> 4);
        // 因为要创建新的内存池了, 所以 将 旧的 内存池中剩余的残余空间分配到适当的 free list 中
        if (__bytes_left > 0){
            _Obj* volatile* __my_free_list = _S_free_list + _S_freelist_index(__bytes_left);

            ((_Obj*)_S_start_free) -> _M_free_list_link = *__my_free_list;
            *__my_free_list = (_Obj*)_S_start_free;
        }

        // 尝试从 heap 中配置内存
        _S_start_free = (char*)malloc(__bytes_to_get);
        if (0 == _S_start_free){
            // heap 空间不足, malloc() 失败, 无法获得内存
            size_t __i;
            _Obj* volatile* __my_free_list;
            _Obj* __p;
            // 从free list 找, 因为可能有些块比你需要的块 大 可以把他切割掉
            for (__i = __size; __i <= (size_t)_MAX_BYTES; __i += (size_t)_ALIGN){
                __my_free_list = _S_free_list + _S_freelist_index(__i);
                __p = *__my_free_list;
                if (0 != __p){
                    *__my_free_list = __p -> _M_free_list_link;
                    _S_start_free = (char*)__p;
                    _S_end_free = _S_start_free + __i;
                    // 现在至少能提供一个区块了, 递归调用自己以修正 nobjs
                    return(_S_chunk_alloc(__size, __nobjs));
                }
            }

            // 连 free list 里也没有可用内存了
            _S_end_free = 0;
            // 调用一级配置器看能不能有点用
            // 一级配置器有 out-of-memory 处理机制, 或许有机会改善现在的情况, 如果无法改善, 抛出bad_alloc异常
            _S_start_free = (char*)malloc_alloc::allocate(__bytes_to_get);
        }
        _S_heap_size += __bytes_to_get;
        _S_end_free = _S_start_free + __bytes_to_get;
        return(_S_chunk_alloc(__size, __nobjs));
    }
}
```