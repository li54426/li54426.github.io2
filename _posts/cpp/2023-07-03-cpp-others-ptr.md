---
layout: blog
banana: true
title:  "c++感想之指针1"
background: green
date:   2023-07-03 23:13:54
category: cpp
tags:
- cpp
- ptr
---

* content
{:toc}




## cpp感想(1)---指针

版本号: V1.2

### 1 第一版本感想

一开始认为只是一个**存储地址**的变量, 但是发现有些片面了

### 2 第二版感想

想了很久发现, 没有一个词能够很好的形容指针, 感觉协议还靠边一点

协议, 协议就是一些特殊的规则集合

指针 是我们自己定义的操纵内存的接口

我现在的理解就是 **指针 = 地址 + 协议**

地址是指在内存中的位置, 协议是指如何管理指向的内存, 

#### 2.1 void指针

>​	void指针不是空指针, 而是可以没有约束( 协议 )的指针, 任何指针指都可以赋值给他, 但是不能用void指针进行操作, 要转换后才能进行操作
>​	因为void*可以接受任何类型指针，就是所谓的上转型（upcasting），将一个更具体的指针转换成一个类型更泛化的指针。编译器知道这种类型转换并不会带来风险。如果进行下转型（downcasting），就告诉编译器，我现在有一个类型更加泛化的指针，我知道此指针具体类型是什么，但是如果涉及引用就想要进行强制转换。

```c
char a[10];
void *b = a;
```



#### 2.2 malloc 函数

> malloc 函数 返回的指针就是void * 类型, 也就是没有协议的类型

#### 2.3 链表---来自数据结构

```c++
typedef struct Listnode{
    datatype data;
    struct Listnode *next;
}listnode;
```

为什么可以做到嵌套定义 : 

- Listnode 类型的变量可以有两个元素, 一个是数据域, 另一个是指针.这两个的大小和组织形式都是固定的, 例如, datatype为int时, 占据8个字节, 指针一般占据8个字节. 这就占据16个字节. 
- Listnode 指针的协议就可以这么来描述: 大小为16个字节, 类内元素排列是 int ( 8 )+ 指针 ( 8 )



#### 2.4 obj---来自SGIGCC2.9

```c++
  union obj {
        union obj * free_list_link;
        char client_data[1];    /* The client sees this.        */
  };
//其实就是告诉指针, 这块内存中存储的是个地址, 并且占用8个字节的内存
```



```c++
struct listnode{
    listnode *next;
};
typedef struct listnode listnode;

int main() {
	// your code goes here
	listnode a,b;
	a.next = &b;
	cout<< "sizeof  listnode = "<< sizeof(listnode)<< endl;
	cout<< "the address of a ="<< &a<< "the address of b ="<< &b<< endl;
	cout<< "the a.next = "<< a.next <<endl;
	return 0;
}
/*
sizeof  listnode = 8
the address of a =0x7ffc8f28fcf8
the address of b =0x7ffc8f28fd00
the a.next = 0x7ffc8f28fd00
*/
```



#### 2.5 short和int---来自编程范式(视频)

```c++
int arr[5];
arr[3]= 128;
((short*)arr)[6]= 2;
//arr被重新解释成2bytes的short型，此时，之前赋值128的地方变为arr[7]

//因为short占用的字节小, 因此你可以通过short指针的方式来进行操控一部分内存
```

