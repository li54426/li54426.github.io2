---
layout: post
title:  "回溯法"
categories: Algorithm
tags:  Algorithm
author: li54426
---


```
algorithm_DynamicProgram_1_01背包问题
```

题目链接: [2. 01背包问题 - AcWing题库](https://www.acwing.com/problem/content/2/)

> 有 N 件物品和一个容量是 V的背包。每件物品只能使用一次。
>
> 第 i 件物品的重量是 w[i]，价值是 v[i]。
>
> 求解将哪些物品装入背包，可使这些物品的总体积不超过背包容量，且总价值最大。
> 输出最大价值。

#### 动态规划的三个步骤:

- 确立dp数组的意义
- 确立递推公式
- 确定遍历顺序( 多维 )
- 处理边界情况

#### 三个 tips:

- 当递推式包含min时，可以把初值设置的尽可能大，毕竟是求最小。
- 当递推式需要比较很多项时，min(dp[i] , dp[i-j]);也就是两两比较
- 注意**处理边界**条件。





> 有 N 件物品和一个容量是 W的背包。每件物品只能使用一次。
>
> 第 i 件物品的重量是 w[i]，价值是 v[i]。
>
> 求解将哪些物品装入背包，可使这些物品的总体积不超过背包容量，且总价值最大。
> 输出最大价值。
>
> #### 输入格式
>
> 第一行两个整数，N，V用空格隔开，分别表示物品数量和背包容积。
>
> 接下来有 N 行，每行两个整数 vi,wi用空格隔开，分别表示第 i 件物品的体积和价值。
>
> #### 输出格式
>
> 输出一个整数，表示最大价值。
>
> #### 数据范围
>
> 0<N,V≤10000<N,V≤1000
> 0<vi,wi≤1000

```c++
#include<iostream>
#include<vector>
using namespace std;

int main(){
    // the number of things, and the volume of bags
    
    int N,V;
    cin >> N >>V;
    
    vector<int> w(N,0), v(N, 0), dp(V+1, 0);
    
    for(int i =0; i<N; ++i){
        cin>> w[i] >>v[i];
        
    }
    
    //init
    for(int i =w[0];i<= V; ++i){
        dp[i] = v[0];
    }
    
    for(int i =1;i< N; ++i){
        for(int j = V; j>= w[i]; --j){
            dp[j] = max(dp[j- w[i]] + v[i], dp[j]);
            
        }
    }
    
    cout<< dp[V]<< endl;
    return 0;
    
}
```

