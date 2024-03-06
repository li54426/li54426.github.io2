---
layout: blog
banana: true
category: algorithm
title:  "字符串匹配"
date:   2023-09-23 15:01:50
background: purple
tags:
- algorithm
---

* content
{:toc}










[10. 正则表达式匹配](https://leetcode.cn/problems/regular-expression-matching/)

> 给你一个字符串 `s` 和一个字符规律 `p`，请你来实现一个支持 `'.'` 和 `'*'` 的正则表达式匹配。
>
> - `'.'` 匹配任意单个字符
> - `'*'` 匹配零个或多个前面的那一个元素
>
> 所谓匹配，是要涵盖 **整个** 字符串 `s`的，而不是部分字符串。
>
> ```
> 输入：s = "aa", p = "a"
> 输出：false
> 解释："a" 无法匹配 "aa" 整个字符串。
> ```

- 首先, 我们要明白这两个字符的作用是什么
    - `.`匹配任意一个字符
    - `*`有两个作用, 一个是**擦除**前面的字符(匹配零个前面的那一个元素), 或者是 **多个**前面的字符
- 能匹配 `s[i] == p[j] || p[j] == '.'` 看后面的字符是否为`*`,, 
    - 后面的字符是否为`*` 那么就会有两种情况,一种是擦除前面的字符, 另一种是多个字符
    - 后面的字符不为`*` 那么, 就直接` dp(s, i+1, p, j+1);`
- 不能匹配的话, 
    - 后面的字符为为`*`, `*`发挥擦除的作用
    - 否则返回 `0`
- 当匹配完毕后, 如果 p 有多余的字符, 看看是否能够**擦除**字符

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
                // 特殊情况
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







