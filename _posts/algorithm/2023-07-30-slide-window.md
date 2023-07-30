---
layout: blog
banana: true
category: algorithm
title:  滑动窗口算法
date:   2023-07-30 22:05:22
background: purple
tags:
- algorithm
- 滑动窗口
---

* content
{:toc}




#### 滑动窗口

O(n) 时间内解决 **子串, 子数组**问题

- right 表示**待处理**的节点
- 窗口其实就是 [left, right), 窗口大小是 left- right
- right 向右寻找可行解，left 向右寻找最优解
- 等价于枚举**左端点**

```python
#-----------------V1----------------
while right < s.size():
    # 处理s[right]
    ++right;
    
    while( shirink && l<r ):
        # 满足 题目 条件的在这里更新
        updata res
        # 处理left
        ++left

#-----------------V2----------------     
while right < s.size():
    # 处理s[right]
    ++right;
    
    while(!shirink  && l<r ):
        # 处理left
        ++left    
    #不满足条件的在这里更新
    updata res
```



满足不满足条件的意思是:

- 随着 r++, 你所想要的目标(求和, 求积) 是怎么进行变化, 是向着你想要的目标走还是怎样
- 





#### 满足题目条件---循环内更新

[209. 长度最小的子数组](https://leetcode.cn/problems/minimum-size-subarray-sum/)

> 给定一个含有 `n` 个正整数的数组和一个正整数 `target` **。**
>
> 找出该数组中满足其和 `≥ target` 的长度最小的 **连续子数组** `[numsl, numsl+1, ..., numsr-1, numsr]` ，并返回其长度**。**如果不存在符合条件的子数组，返回 `0` 。**
>
> ```
> 输入：target = 7, nums = [2,3,1,2,4,3]
> 输出：2
> 解释：子数组 [4,3] 是该条件下的长度最小的子数组。
> ```

```c++
int minSubArrayLen(int target, vector<int>& nums) {
    int len = nums.size();
    int l =0, r=0;
    int sum = 0;
    int minlen = INT_MAX;
    while(r< len){
        sum+= nums[r++];

        while(sum >= target){
            minlen = min(minlen, r-l); 
            sum -= nums[l++];

        }
    }
    return minlen == INT_MAX ? 0: minlen;

}
```

- 在本题中, 随着 r++, 目标和越来越大, 是向着你想要的目标走, 因此用的是 V1, 在循环内更新 结果



#### 不满足题目条件---循环外更新

[713. 乘积小于 K 的子数组](https://leetcode.cn/problems/subarray-product-less-than-k/)

> 给你一个整数数组 `nums` 和一个整数 `k` ，请你返回子数组内所有元素的乘积严格小于 `k` 的连续子数组的数目。
>
> ```
> 输入：nums = [10,5,2,6], k = 100
> 输出：8
> 解释：8 个乘积小于 100 的子数组分别为：[10]、[5]、[2],、[6]、[10,5]、[5,2]、[2,6]、[5,2,6]。
> 需要注意的是 [10,5,2] 并不是乘积小于 100 的子数组。
> ```

```c++
class Solution {
public:
    int numSubarrayProductLessThanK(vector<int>& nums, int k) {
        // 返回子数组的数目
        int res = 0;
        int l =0, r= 0;
        int sum =1;
        int len = nums.size();

        while(r<len){
            sum *= nums[r];
            ++r;
            while(sum >= k && l<r){
                sum /= nums[l];
                l++;

            }
            // [l, r) 内, 且右边断点为 r 的子数组共 (r-l)个
            res += (r-l);
        }

        return  res;

    }
};
```

- 在本题中, 随着 r++, 目标积 越来越大, 题目要求是要我们 小于 k , 因此用的是 V2, 在循环外更新 结果



[3. 无重复字符的最长子串( DP )](https://leetcode.cn/problems/longest-substring-without-repeating-characters/description/)

> 给定一个字符串 `s` ，请你找出其中**不含**有重复字符的 **最长子串** 的长度。
>
> ```
> 输入: s = "abcabcbb"
> 输出: 3 
> 解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。
> ```

```c++
// -----------------------------V2.0----------------------------------
int lengthOfLongestSubstring(string s) {
    unordered_map<char, int> mp;
    int l =0, r=0;
    int len = s.size();
    int res = 1;

    // 处理特殊情况
    if(!len) {
        return 0;
    }
    while(r<len){
        char c = s[r];
        r++;
        mp[c]++;
        while((r-l) > mp.size()){
            c = s[l++]; 
            mp[c]--;
            if(0==mp[c]){
                mp.erase(c);

            }
        }
        res = max(res, r-l);
    }
    return res;
}


```

