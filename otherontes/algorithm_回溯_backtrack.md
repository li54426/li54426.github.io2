---
layout: post
title:  "回溯法"
categories: Algorithm
tags:  Algorithm
author: li54426
---



### 2 回溯法------用递归来解决嵌套层数的问题

```
给定一个不含重复数字的数组 nums ，返回其 所有可能的全排列 。你可以 按任意顺序 返回答案。

示例 输入：nums = [1,2,3]
	输出：[[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
```

​	肯定可以用暴力方法来解决, 但是当nums数组数量多了的时候, 例如50, 我们需要写 50 层 for循环, 这是个不可能完成的任务. 

​	回溯法模板, 因为一般来说, 用回溯法解决的问题是一个集合, 所以不能直接返回结果, 因此, backtrack 需要将 结果集合( 一个多维数组 )传入进去来维护他, 还有所有的选择, 以及路径.

```python
result = []
def backtrack(res, 路径, 选择列表):
    if 满⾜结束条件:
        res.add(路径)
        return

    for 选择 in 选择列表:
        判断是否需要剪枝, 也就是将不符合题意的循环删除
        
        #在递归之前做出选择，在递归之后撤销刚才的选择
        做选择
        backtrack(路径, 选择列表)
        撤销选择
```

```python
# 伪代码分析
给定一个不含重复数字的数组 nums ，返回其 所有可能的全排列 。你可以 按任意顺序 返回答案。

示例 输入：nums = [1,2,3]
	输出：[[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
    
def backtrack(res, nums, track):
    if nums.size() == track.size():
        res.add(track)
        return

    for num in nums:
        # 判断是否需要剪枝, 也就是将不符合题意的循环删除
        # 在这个问题中, nums 在 track中重复
        if num in track: continue;
        
        #在递归之前做出选择，在递归之后撤销刚才的选择
        track.push_back(num)
        backtrack(res, nums, track)
        track.pop_back(num)
```



#### [46_全排列](https://leetcode.cn/problems/permutations/)

给定一个不含重复数字的数组 nums ，返回其 所有可能的全排列 。你可以 按任意顺序 返回答案。

示例 

输入：nums = [1,2,3]
输出：[[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]

```c++
    void backtrack(vector<vector<int> > &res, vector<int> &nums, vector<int> &track, vector<int> &flag){
        if(track.size() == nums.size()){
            res.push_back(track);
            return;
        }
        for(int i =0; i<nums.size(); ++i){
            if(flag[i] == 1) continue;
            track.push_back(nums[i]);
            flag[i] =1;
            backtrack(res, nums, track, flag);
            flag[i] =0;
            track.pop_back();
        }
    } 

    vector<vector<int>> permute(vector<int>& nums) {
        int len = nums.size();
        vector<int> track, flag(len, 0);
        //flag is the element is used
        vector<vector<int> > res;


        backtrack(res, nums, track, flag);

        return res;
    }

```

#### 