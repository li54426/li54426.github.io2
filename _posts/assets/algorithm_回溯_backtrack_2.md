#### [77_组合](https://leetcode.cn/problems/combinations/)

> 给定两个整数 `n` 和 `k`，返回范围 `[1, n]` 中所有可能的 `k` 个数的组合。
> 你可以按 **任何顺序** 返回答案。
> 输入：n = 4, k = 2
> 输出：
> [
>   [2,4],[3,4],[2,3],[1,2],[1,3],[1,4],
> ]
>
> //解题思路:
> 一般我们在进行答案的搜索的时候, 都是从小的开始,   先1, 然后2, 并且只找比他大的数
> [1,2],[1,3],[1,4],[2,3],[2,4], [3,4]



```c++
vector<vector<int>> combine(int n, int k) {
    vector<int> track;
    vector<vector<int> > res;
    backtrack(res, n, k, 1, track);
    return res;

}

//----------------------------错误解法1------------------------------
//输出了   [[1,1],[1,2],[1,3],[1,4],[2,1],[2,2],[2,3],[2,4],[3,1],[3,2],[3,3],[3,4],[4,1],[4,2],[4,3],[4,4]]
void backtrack(vector<vector<int> > &res, int n, int k, int start, vector<int> &track){
    if(track.size() == k) {
        res.push_back(track);
        for_each(track.begin(), track.end(), [&](int x){cout<< x;});
        cout<< endl;
        return;
    }
    
	//for循环 第一句话, 标志着树的 每层 从哪里开始
    for(int i =1; i<=n; ++i){
        track.push_back(i);
        //递归调用标志着 下一层树
        backtrack(res, n, k, start+1, track);
        track.pop_back();
    }
}
//-----------其实就是start没有用上------
//回溯树如下图所示, 以后不对的时候, 就画图看一下
							[]
	[1]  		[2] 		 [3],,,,,,,,,,,,,,,,,,,,,,,,,,
[1][2][3][4]
```



```c++
//----------------------------正确解法1------------------------------
void backtrack(vector<vector<int> > &res, int n, int k, int start, vector<int> &track){
    if(track.size() == k) {
        res.push_back(track);
        for_each(track.begin(), track.end(), [&](int x){cout<< x;});
        cout<< endl;
        return;
    }
    
	//for循环 第一句话, 标志着树的 每层 从哪里开始
    for(int i =start; i<=n; ++i){
        track.push_back(i);
        //递归调用标志着 下一层树
        backtrack(res, n, k, i+1, track);
        track.pop_back();
    }
}
```





#### [216_组合总和3](https://leetcode.cn/problems/combination-sum-iii/)

> 找出所有相加之和为 `n` 的 `k` 个数的组合，且满足下列条件：
>
> - 只使用数字1到9
> - 每个数字 **最多使用一次** 
>
> 返回 *所有可能的有效组合的列表* 。该列表不能包含相同的组合两次，组合可以以任何顺序返回。
>
> **示例 1:**
>
> ```
> 输入: k = 3, n = 7
> 输出: [[1,2,4]]
> 解释:
> 1 + 2 + 4 = 7
> 没有其他符合的组合了。
> ```

```c++
vector<vector<int>> combinationSum3(int k, int n) {
    vector< vector<int> > res;
    vector<int> track;
    //vector<int> flag(10,0);

    backtrack(res, k, n, track, 1, 0);
    return res;

}

void backtrack(vector<vector<int> > &res, int k, int n,vector<int> &track, int start, int sum){
    // sum 是树节点 的总和
    if(track.size() == k && sum == n){
        res.push_back(track);
        return;
    }


    for(int i = start; i<10; ++i){
        track.push_back(i);
        backtrack(res, k, n, track, i+1, sum +i);
        track.pop_back();

    }
}
```

