




#### [2788. 按分隔符拆分字符串 - 力扣（LeetCode）](https://leetcode.cn/problems/split-strings-by-separator/)

> 给你一个字符串数组 `words` 和一个字符 `separator` ，请你按 `separator` 拆分 `words` 中的每个字符串。
>
> 返回一个由拆分后的新字符串组成的字符串数组，**不包括空字符串** 。
>
> **注意**
>
> - `separator` 用于决定拆分发生的位置，但它不包含在结果字符串中。
> - 拆分可能形成两个以上的字符串。
> - 结果字符串必须保持初始相同的先后顺序。
>
> ```
> 输入：words = ["one.two.three","four.five","six"], separator = "."
> 输出：["one","two","three","four","five","six"]
> 解释：在本示例中，我们进行下述拆分：
> 
> "one.two.three" 拆分为 "one", "two", "three"
> "four.five" 拆分为 "four", "five"
> "six" 拆分为 "six" 
> 
> 因此，结果数组为 ["one","two","three","four","five","six"] 。
> ```

```c++
vector<string> splitWordsBySeparator(vector<string>& words, char c) {
    vector<string> res;

    for(auto & s : words){
        // 字符串左侧包括 l
        int l = 0;
        for(int i = 0; i< s.size(); ++i){
            if(s[i] == c ){
                if(i - l > 0){
                    res.push_back(s.substr(l, i-l));
                }
                l = i+1;
            }
            // 处理最后不为 c 的情况
            if(i == s.size() - 1 && s[i] != c ){
                res.push_back(s.substr(l, i- l+1));
            }
        }
    }
    return res;

}




class Solution {
public:
    vector<string> splitWordsBySeparator(vector<string>& words, char separator) {
        vector<string> res;
        for(int i = 0;i<words.size();i++){
            istringstream iss(words[i]);	// 输入流
	        string token;			// 接收缓冲区
	        while (getline(iss, token, separator)){// 以split为分隔符
            if(token.size()!=0)
                res.push_back(token);
            }
        }
        return res;
    }
};

作者：知忆梦往昔
链接：https://leetcode.cn/problems/split-strings-by-separator/solutions/2361633/jie-he-istringstreamhe-getlinefang-fa-sh-scem/
来源：力扣（LeetCode）
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
```



```c++
#include <sstream>  

// 构造函数
istringstream::istringstream(string str);
```





#### [2790. 长度递增组的最大数目 - 力扣（LeetCode）](https://leetcode.cn/problems/maximum-number-of-groups-with-increasing-length/description/)

> 给你一个下标从 **0** 开始、长度为 `n` 的数组 `usageLimits` 。
>
> 你的任务是使用从 `0` 到 `n - 1` 的数字创建若干组，并确保每个数字 `i` 在 **所有组** 中使用的次数总共不超过 `usageLimits[i]` 次。此外，还必须满足以下条件：
>
> - 每个组必须由 **不同** 的数字组成，也就是说，单个组内不能存在重复的数字。
> - 每个组（除了第一个）的长度必须 **严格大于** 前一个组。
>
> 在满足所有条件的情况下，以整数形式返回可以创建的最大组数。
>
> ```
> 输入：usageLimits = [1,2,5]
> 输出：3
> 解释：在这个示例中，我们可以使用 0 至多一次，使用 1 至多 2 次，使用 2 至多 5 次。
> 一种既能满足所有条件，又能创建最多组的方式是： 
> 组 1 包含数字 [2] 。
> 组 2 包含数字 [1,2] 。
> 组 3 包含数字 [0,1,2] 。 
> 可以证明能够创建的最大组数是 3 。 
> 所以，输出是 3 。 
> ```

```c++
    int maxIncreasingGroups(vector<int>& nums) {
        // 贪心的想, 让次数**更少**的元素在长度**更长**的分组中

        // 本题最关键的一点是，单个组横着看，最优解是每一行的元素都不同，但竖着看就会发现最优解的情况是优先一列全部取一样的数字
        sort(nums.begin(),nums.end());//先递增排序；
        //     *
        //    **
        //   *** 
        long long sum  = 0;
        int res = 0;
        int len = nums.size();

        for(int i = 0; i<len; ++i){
            sum += nums[i];
            if(sum >= 1LL * (res + 1) * (res + 2) / 2){
                res ++;
            }
        }
        return res;
    }
```

