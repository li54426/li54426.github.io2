---
layout: blog
banana: true
category: cpp
title:  函数模板与 auto 关键字
date:   2023-08-23 11:43:45
background: green
tags:
- cpp
---

* content
{:toc}




#### 函数模板不能使用 auto

```c++
bool cmp(pair<int, int>  &a, pair<int, int>  &b){
    if( a.first == b.first){
        a.second = b.second;
        return 1;
    }
    return 0;
}

class Solution {
public:

    vector<int> smallestSubarrays(vector<int>& nums) {
        // 找一个最短的子数组, 使得 | 之后的值最大
        // 按位或的性质?
        // 从x=nums[i]出发,OR的结果至多有多少种?
        // 关键:1不能变成0, 0可以变成1至多能变多少次?变29次,总共30种
        int len = nums.size();
        vector<int> res(len, 0);

        vector<pair<int, int> >  ors;
        for(int i= len-1; i>-1; --i){
            ors.push_back({nums[i], i});
            for(int j = 0; j< ors.size(); ++j){
                ors[j].first |= nums[i];
            }
            auto it = unique(ors.begin(), ors.end(), cmp);
            ors.resize(it - ors.begin());
            res[i] = ors[0].second-i +1;
        }
        return res;


    }
};
```









在 C++ 中，使用 `auto` 关键字可以让编译器自动推导变量的类型。然而，在函数模板中，编译器无法自动推导函数参数的类型，因此必须使用显示的类型。

在给定的代码中，`cmp` 函数被用作 `unique` 函数的比较函数。`unique` 函数是一个函数模板，它接受两个迭代器和一个比较函数作为参数，并在指定范围内移除相邻的重复元素。

因为 `cmp` 函数是作为比较函数传递给 `unique` 函数的，所以编译器无法自动推导参数的类型。因此，参数类型必须显式地指定为 `pair<int, int>&`，以便 `unique` 函数正确调用 `cmp` 函数进行比较。

如果将参数类型改为 `auto`，编译器将无法确定参数类型，从而无法正确调用 `cmp` 函数，导致编译错误。



#### lambda表达式 使用 auto

```c++
vector<int> aaaa (7, 0);
unique (aaaa.begin (), aaaa.end (), [](auto a, auto b){return  a== b;} );
```





对于标准库算法函数（如 `unique`），它们是在 C++98/03 标准中定义的，不支持使用模板参数推导，因此无法直接使用 lambda 表达式作为比较函数。

在 C++11 引入 lambda 表达式之前，为了使用自定义比较函数，我们通常需要使用函数指针或函数对象来传递函数。这要求我们定义一个具体的函数或函数对象，并显式地指定其类型。

然而，在 C++11 之后的版本（包括 C++11、C++14 和 C++17），lambda 表达式提供了更简洁和灵活的方式来定义匿名函数，并可以在标准库算法中直接使用。

所以，你可以使用 lambda 表达式作为比较函数传递给 `unique` 函数，而不需要使用函数指针或函数对象。这种语法糖使代码更简洁、可读性更好，并且能够自动推导参数类型。

总而言之，C++11 以后的标准支持 lambda 表达式作为比较函数的直接传递，而之前的标准则需要使用函数指针或函数对象来传递自定义函数。
