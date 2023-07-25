```
algorithm_回溯_backtrack_4_去重
```

####  [40_组合总和2(重要, 涉及去重,去重使用了排序)](https://leetcode.cn/problems/combination-sum-ii/)

> 给定一个候选人编号的集合 `candidates` 和一个目标数 `target` ，找出 `candidates` 中所有可以使数字和为 `target` 的组合。
>
> `candidates` 中的每个数字在每个组合中只能使用 **一次** 。
>
> **注意：**解集不能包含重复的组合。 
>
> **示例 1:**
>
> ```
> 输入: candidates = [10,1,2,7,6,1,5], target = 8,
> 输出:  [   [1,1,6],[1,2,5],[1,7],[2,6]  ]
> ```

​	集合(数组candidates)有重复元素,但还不能有重复的组合.

**去重 时, 遇事不决, 直接排序**

![image-20220924111421337](https://i0.hdslb.com/bfs/album/2d073c6fcbc14c6305e99fb5683f758bfcc55461.png)

```c++
//------------------  V-1.0 -------------------------
//  期望输出   [   [1,1,6],[1,2,5],[1,7],[2,6]  ]
//  实际输出   [[1,2,5],[1,7],[1,6,1],[2,6],[2,1,5],[7,1]]

vector<vector<int>> combinationSum2(vector<int>& candidates, int target) {
    vector<vector<int> > res;
    vector<int> track;

    backtrack(res, candidates, target, track, 0, 0);
    return res;

}

void backtrack(vector<vector<int> > &res, vector<int> &can, int target, vector<int> &track, int sum, int start){
    if(sum == target){
        res.push_back(track);
        return;
    }
    if(track.size() >= can.size() || sum> target) return;

    for(int i = start; i< can.size(); ++i){
        
        track.push_back(can[i]);
        backtrack(res, can, target, track, sum+can[i], i+1);
        track.pop_back();
    }
}
    
//----------------------- V-2.0 ----------------------
// 回溯树如下
//                                 []
//     [1] ,,,, [1](重复了),,,,, 
// [1](依旧可以选) 

// 因为 已经搜索过了, 你再搜索, 就会重复 
// 既然需要 每一行 去重, 那么, 先排序, 在for循环里面判断一下前面用没用过不就行了?
// 很遗憾, 实际的结果是 [[1,2,5],[1,7],[2,6]]
// 期望输出      [   [1,1,6],[1,2,5],[1,7],[2,6]  ]
// 虽然 确实去掉了1,7 和7,1的重复, 但是缺少了 1, 1, 6 的组合
// 问题出在了哪里?
// 实际的情况是, 我们平时使用for循环时(比如使用的方法 是 遍历法 ), 总是横向的, 横向的意思是回溯树有同一个父亲
// for(){for(){for(){}}}
// 但是因为 回溯法使用了递归, for循环又会竖向使用, (回溯树中的父子关系)
sort(candidates.begin(), candidates.end());
for(int i = start; i< can.size(); ++i){
    if(i>0 && can[i] == can[i-1]) continue;
    track.push_back(can[i]);
    backtrack(res, can, target, track, sum+can[i], i+1);
    track.pop_back();
}

//----------------------- V1.0 ----------------------
vector<vector<int>> combinationSum2(vector<int>& candidates, int target) {
    vector<vector<int> > res;
    vector<int> track, flag(candidates.size(), 0);

    sort(candidates.begin(), candidates.end());
    backtrack(res, candidates, target, track, 0, 0, flag);
    return res;

}

void backtrack(vector<vector<int> > &res, vector<int> &can, int target, vector<int> &track, int sum, int start, vector<int> &flag){
    if(sum == target){
        res.push_back(track);
        return;
    }
    if(track.size() >= can.size() || sum> target) return;

    for(int i = start; i< can.size(); ++i){
        //  比较反直觉, 没有用过 才表示 是同一层重复
        if(i>0 && can[i] == can[i-1] &&flag[i-1]==0 )
            continue;
        flag[i] =1;
        track.push_back(can[i]);
        backtrack(res, can, target, track, sum+can[i], i+1, flag);
        track.pop_back();
        flag[i] =0;
    }
}
```

