---
layout: blog
banana: true
category: cpp
title:  "C++的一些基础问题"
date:   2023-09-22 21:08:05
background: green
tags:
- cpp
---

* content
{:toc}




### 数值类型的问题



#### 整型与浮点型

- 在 C++ 中，当一个浮点数和一个整数进行乘法运算时，整数会被隐式地转换成与**浮点数相同**的类型，然后进行乘法运算。

```c++
void test1(){
    float f=3.5; 
    int m =6; 
    long k=21;
    cout<< "k/2="<< k/2<< endl;
    double ss=f *  m + k/2;
    cout<<"ss="<<  ss<<endl;
    cout<< "m * f =" << m* f<< endl;
    
}

// 输出结果如下
// k/2=10
// ss=31
// m * f =21
// sizeof a = 12
```



#### 整型与大整形

在 C++ 中，当一个表达式中同时包含 int 和 long long 类型时，会发生类型转换的情况如下：

1. 若参与运算量的类型不同，则先转换成同一类型，然后进行运算。
2. 转换按数据长度增加的方向进行，以保证精度不降低。如 int 型和 long 型运算时，先把 int 量转成 long 型后再进行运算

```c++
void test1(){
    int m =6; 
    long k=21;

    cout<< "sizeof(int) = "<< sizeof(int)<< endl;
    cout<< "sizeof= int + long= "<< sizeof(m + k)<< endl;
    cout<< "sizeof = long + int= "<< sizeof(k + m)<< endl;
    
}

sizeof(int) = 4
sizeof= int + long= 8
sizeof = long + int= 8
```



#### 整型与参数模板

- 如果在使用模板函数时, 可以设置初值为 `long long`类型 例如 `0LL`

```c++
accumulate(nums.begin(), nums.end(), 0LL);
```





#### 数位补足

```c++
void test2(){
    union{
        char name[10];
        int n;
    }a;
    
    cout<< "sizeof a = "<< sizeof a << endl;   
    cout<< sizeof (int) <<endl;
}
// sizeof a = 12
// sizeof int = 4
```







### string 与 char *

#### `char *`赋值

- 当你尝试将一个字符串字面值（例如："test"）赋值给一个字符数组时，会发生**错误**。这是因为字符串字面值在 C++ 中被视为一个常量字符数组，并且具有固定的大小，无法直接赋值给一个已经定义的字符数组。
- `a = 'c'` 也是错误的, 必须是 `a[0] = 'c';`

```c++
void test_string_char(){
    char a[5]; 
    
    // 错误示例
    a ="test";
    // 正确示例
    strcpy(a, "test");
    
    cout<< a<< endl;
    cout<< "success"<< endl;
}
```







### 作用域



#### 变量的作用域

- 不同作用域内可以重复定义

```c++
#include<iostream>

using namespace std;

int n = 0;

int main(){
    int n = 1;
    cout<< "全局n="<< ::n<< endl;
    int n = 1;
    cout<< "函数内n="<< n<< '\n';
    {
        int n = 2;
        cout<< "括号内n="<< n<< endl;;
    }

}

// 全局n=0
// 函数内 n=1
// 括号内 n=2

```





```c++
class Solution {
public:
    bool isMatch(string s, string p) {
        // s is long , p is short
        return dp(s, 0, p, 0);


    }

    bool dp(string &s, int i, string &p, int j){
        // * 的作用可以复制, 也可以擦除
        int len1 = s.size(), len2= p.size();

        if(i< len1 && j< len2){
            if(s[i] == p[j] || p[j] == '.'){
                // 特赦情况
                if(j< len2-1 && p[j+1] == '*'){
                    // cout<< "s[i] == p[j] || p[j] == '.' && p[j+1] == '*' "<< "i="<< i<< "\tj="<<j << endl;
                    return dp(s, i+1, p, j) || dp(s, i, p, j+2);
                }else{

                    return dp(s, i+1, p, j+1);
                }
            }else{
                if(j< len2 -1 && p[j+1] =='*'){
                    return dp(s, i, p, j+2);
                }else{
                    return 0;
                }
            }
        }else if(i == len1){
            while(j< len2-1 && p[j+1] == '*'){
                j+=2;
            }
            return j == len2;
        }
        return 0;
    }
};
```

