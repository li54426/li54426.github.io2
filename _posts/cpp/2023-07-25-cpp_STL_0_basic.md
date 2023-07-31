---
layout: blog
title: "cpp_STL_O_basic"
date:   2023-07-25 21:19:24 
categories: cpp
background: green
tags:
- cpp
- STL
---

* content
{:toc}


### 类内成员



#### 1.1 类内的静态变量 static

优点:

- static的名字在类的作用域内, 是**类的一部分**, 而不是对象的一部分
- static成员可以是私有成员
- 所有对象**共享**同一份数据
- 类内声明，类外初始化
- 在编译阶段分配内存





#### 1.2 静态成员函数

- 在类中声明函数的前面加static就成了静态成员函数, 可以通过对象来访问, 也可以通过类名来访问
- 所有对象共享同一个函数
- 静态成员函数**只能访问静态成员**变量, 静态成员函数没有this指针，既然它**没有指向某一对象**，就无法对一个对象中的非静态成员进行默认访问

泛整型可以类内直接初始化，包括bool short int long等，其余类型包括float，double及string等都不可以。

```c++
class A{
public:
	static int staint;
};
int A::staint = 0;
```



#### 1.3 操作符 重载

作用 : 对已有的运算符重新进行定义，赋予其另一种功能，以适应不同的数据类型

一般的重载运算符

- 加号运算符重载
- 左移运算符重载    :: 可以输出自定义数据类型
- 递增运算符重载
- 赋值运算符重载
- 关系运算符重载
- 函数调用运算符重载

Note:    ::  .*    .    ?=   不能重载



### 3 模板

#### 3.1 模板简介

​	**泛型编程**就是以独立于任何特定类型的方式编写代码, 使用泛型程序时， 需要提供具体程序实例所操作的类型或值. 
​	泛型程序设计背后有一种隐含的共性：模板机制
​	why: 除了**类型**之外， 其余代码看起来是**相同**的。

包括: 

- 函数模板
- 类模板

#### 3.2  函数模板

函数模板提供了一种函数行为，该函数行为可以用多重不同类型进行调用。也就是说，函数模板代表一个函数家族。

```c++
//尖括号内的是    一个或者多个模板形参
//模板形参定义了特定类型的局部变量但是不初始化， 只有当运行时才初始化. 
template<typename T>
int compare(const T &a, const T &b){
    if(a <b) return -1;
    else if(a >b) return 1;
    else return 0; 
}

//使用函数模板时, 编译器会自己推断哪个或者哪些模板实参绑定到形参
//一旦编译器确定了实际的模板实参， 就是, 实例化了函数模板的一个实例
cout<< compare(1, 0);
```





#### 3.3 类模板

类模板与函数模板区别主要有两点：

- 类模板没有自动类型推导的使用方式

- 类模板在模板参数列表中可以有默认参数

类模板中成员函数和普通类中成员函数创建时机是有区别的：

- 普通类中的成员函数一开始就可以创建
- 类模板中的成员函数在调用时才创建

#### 3.4 类模板的使用

```c++
template<class NameType, class AgeType = int>
class Person{};

void test01(){
    // 错误 类模板使用时候，不可以用自动类型推导
    // Person p("孙悟空", 1000);

    //必须使用显示指定类型的方式，使用类模板
    Person <string ,int>p("孙悟空", 1000);
}

void test02(){
    //类模板中的模板参数列表 可以指定默认参数
    Person <string> p("猪八戒", 999); 
}
```



#### 3.5 类模板  做 函数参数

一共有三种传入方式：

- 指定传入的类型 --- 直接显示对象的数据类型**( 最常用 )**
- 参数模板化 --- 将对象中的参数变为模板进行传递
- 整个类模板化 --- 将这个对象类型 模板化进行传递

```c++
template<class NameType, class AgeType = int>
class Person{};

//1、指定传入的类型
void printPerson1(Person<string, int> &p){
    p.showPerson();
}
void test01(){
	Person <string, int >p("孙悟空", 100);
	printPerson1(p);
}

//2、参数模板化
template <class T1, class T2>
void printPerson2(Person<T1, T2>&p){
    p.showPerson();
    cout << "T1的类型为： " << typeid(T1).name() << endl;
    cout << "T2的类型为： " << typeid(T2).name() << endl;
}

void test02(){
Person <string, int >p("猪八戒", 90);
printPerson2(p);
}

//3、整个类模板化
template<class T>
void printPerson3(T & p){
    cout << "T的类型为： " << typeid(T).name() << endl;
    p.showPerson();
}
void test03(){
    Person <string, int >p("唐僧", 30);
    printPerson3(p);
}
int main() {
    test01();
    test02();
    test03();
    system("pause");
    return 0;
}
```





#### 3.6 类内的 模板对象

```c++
template<class T>
class stack{
private:
    vector <T> elem(n);
public:
    void pop();
    void push(T);
};


//可以有非模板类型参数, 非模板类型参数是有限制的, 可以是长整数, 或者指向外部链接对象的指针
template<class T, int max> stack{};

//在定义函数时, 模板定义了几个形参就要带着几个形参
template<class T, int max> stack :: pop(){
    
}
```





#### 3.7 特化

- 有时候我们可能需要为某些特定类型或特定情况提供特殊的实现方式。这就是模板的特化的作用。
- 偏特化与完全特化类似，但存在一定的区别。完全特化是对模板的所有类型参数都进行具体化，而偏特化则只对其中的部分类型参数进行特化。所以偏特化以后, 依旧是 **模板**

偏特化的定义: 提供另一份 template 的定义式, 本是一就是templatized

```c++
// 泛化, 特化
template <class T, class Allocalloc>
class vector
{
};

// 个数的偏特化  -  原来是两个模板参数, 现在是一个
// 针对某个类型做特别的优化
template<class Alloc>
class vector<bool, Alloc>
{
};

//范围的偏特化  -指针类型
template<class T>
class demo{};

template<class T>
class demo<T*>{
};
```

