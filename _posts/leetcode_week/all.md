







```c++
// not change(3 4)
// (3 4)
// not change(3 4)(1 3)
// (3 4)(1 3)
// not change(3 4)(3 3)(2 2)
// (3 3)(2 2)
// not change(3 3)(2 2)(0 1)
// (3 3)(2 2)(0 1)
// not change(3 3)(3 2)(1 1)(1 0)
// (3 2)(1 0)



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
            // 原地去重
            auto it = unique(ors.begin(), ors.end(), cmp);
            ors.resize(it - ors.begin());
            res[i] = ors[0].second-i +1;
        }
        return res;


    }
};
```





```c++
class Solution {
public:
    vector<int> smallestSubarrays(vector<int>& nums) {
        // 找一个最短的子数组, 使得 | 之后的值最大
        // 按位或的性质?
        // 从x=nums[i]出发,OR的结果至多有多少种?
        // 关键:1不能变成0, 0可以变成1至多能变多少次?变29次,总共30种
        int n = nums.size();
        vector<int> ans(n);
        vector<pair<int, int>> ors; // 按位或的值 + 对应子数组的右端点的最小值
        for (int i = n - 1; i >= 0; --i) {
            ors.emplace_back(0, i);//小集合总是在后面插入的，因此ors是递减的
            for (int j = 0; j < ors.size(); ++j) 
            {//更新集合，把nums[i]插入集合
                ors[j].first |= nums[i];
            }
            cout<< "not change";
            for(auto & p : ors){
                cout<< "("<< p.first<< " "<< p.second <<')';
            }
            cout<< endl;
            int j=0, k=0;//原地去重的两个指针，j用来遍历，k用来记录已去重的最后一个元素下标，方便比较
            for(;j<ors.size();j++)
            {//原地去重，和421相同，集合更新保证ors的或值是递减的（不一定是严格递减的，可能有重复，所以需要去重）
                if (ors[k].first != ors[j].first)
                {//不重复，先递增k，因为k的定义和421有一点不同，再记录下来
                    ors[++k] = ors[j];
                }
                else //重复了，只记录最小的下标，k不递增
                    ors[k].second = ors[j].second; // 合并相同值，下标取最小的
            }
            ors.resize(k + 1);//k是已去重的最后一个元素下标，因此保留k+1个元素
            for(auto & p : ors){
                cout<<"("<< p.first<< " "<< p.second <<')';
            }
            cout<< endl;
            // 本题只用到了 ors[0]，如果题目改成任意给定数字，可以在 ors 中查找
            ans[i] = ors[0].second - i + 1;
        }
        return ans;


    }
};
```







#### [2447. 最大公因数等于 K 的子数组数目](https://leetcode.cn/problems/number-of-subarrays-with-gcd-equal-to-k/)

> 给你一个整数数组 `nums` 和一个整数 `k` ，请你统计并返回 `nums` 的子数组中元素的最大公因数等于 `k` 的子数组数目。
>
> **子数组** 是数组中一个连续的非空序列。
>
> **数组的最大公因数** 是能整除数组中所有元素的最大整数。
>
> ```
> 输入：nums = [9,3,1,2,6,3], k = 3
> 输出：4
> 解释：nums 的子数组中，以 3 作为最大公因数的子数组如下：
> - [9,3,1,2,6,3]
> - [9,3,1,2,6,3]
> - [9,3,1,2,6,3]
> - [9,3,1,2,6,3]
> ```

```c++
bool cmp(pair<int, int>  &a, pair<int, int>  &b){
    if( a.first == b.first){
        a.second = b.second;
        return 1;
    }
    return 0;
}



class Solution {
    int gcd (int a, int b){
        if(b == 0){
            return a;
        }

        int temp = b;
        b = a %b; 
        a = temp;
        return gcd(a, b);
    }

public:
    int subarrayGCD(vector<int>& nums, int k) {
        // cout<< gcd(3, 6);
        int len = nums.size();
        int res = 0 ;

        vector<pair<int, int> >  ors;
        int i0 = len;
        for(int i= len-1; i>-1; --i){
            if(nums[i] %k ){
                ors.clear();
                i0 = i;
                continue;
            }
            ors.push_back({nums[i], i});
            for(int j = 0; j< ors.size(); ++j){
                ors[j].first = __gcd(ors[j].first, nums[i]) ;
            }
            // cout<< "before";
            // for(auto p: ors){
            //     cout<< "("<< p.first << " "<<p.second<<  ")";
            // }
            // cout<< endl;
            // 原地去重
            auto it = unique(ors.begin(), ors.end(), cmp);
            ors.resize(it - ors.begin());

            // for(auto & p : ors){
            //     cout<<"("<< p.first<< " "<< p.second <<')';
            // }
            // cout<< endl;
            if(ors.size() && ors[0].first == k){
                 res+= i0 -ors[0].second ;
                // res++;
            }
        }
        return res;


    
    }
};
```





#### [907. 子数组的最小值之和](https://leetcode.cn/problems/sum-of-subarray-minimums/)



> 给定一个整数数组 `arr`，找到 `min(b)` 的总和，其中 `b` 的范围为 `arr` 的每个（连续）子数组。
>
> 由于答案可能很大，因此 **返回答案模 `10^9 + 7`** 。
>
> ```
> 输入：arr = [3,1,2,4]
> 输出：17
> 解释：
> 子数组为 [3]，[1]，[2]，[4]，[3,1]，[1,2]，[2,4]，[3,1,2]，[1,2,4]，[3,1,2,4]。 
> 最小值为 3，1，2，4，1，1，2，1，1，1，和为 17。
> ```
>
> ```
> 输入：arr = [11,81,94,43,3]
> 输出：444
> ```

```c++
class Solution {
public:

// 如果 arr\textit{arr}arr 有重复元素，例如 arr=[1,2,4,2,3,1]，其中第一个 222 和第二个 222 对应的边界都是开区间 (0,5)，子数组 [2,4,2,3] 都包含这两个 2，这样在计算答案时就会重复统计同一个子数组，算出错误的结果。

// 为避免重复统计，可以修改边界的定义，把右边界改为「找小于或等于 arr[i] 的数的下标」，那么：

// 第一个 2 对应的边界是 (0,3)，子数组需要在 (0,3) 范围内且包含下标 1；
// 第二个 2 对应的边界是 (0,5)，子数组需要在 (0,5) 范围内且包含下标 3。

    int sumSubarrayMins(vector<int>& nums) {
        // 子数组和的最小值
        // 找左右两边 第一个 小于的元素, 找什么, 什么放到底下
        int len = nums.size();
        vector<int> r(len, len), l(len, -1);

        stack<int> st;
        for(int i = len-1; i>-1; --i){
            while(st.size() && nums[st.top()] > nums[i]){
                st.pop();
            }
            if(st.size() ){
                r[i] = st.top();
            }
            st.push(i);
        }
        


        while(st.size()){
            st.pop();
        }
        for(int i = 0; i<len; ++i ){
            while(st.size() && nums[st.top()] >= nums[i]){
                st.pop();
            }
            if(st.size() ){
                l[i] = st.top();
            }
            st.push(i);
        }

        // for(int n : r){
        //     cout<< n<< endl;
        // }
        // for(int n : l){
        //     cout<< n<< endl;
        // }

        int res = 0;
        int k = 1e9+7;

        for(int i = 0; i< len; ++i){
            res += 1LL * (r[i]-i) * (i-l[i]) * nums[i]  % k;
            res %= k;
        }
        return res;

        return 0;


    }
};
```











#### 316

[2447. 最大公因数等于 K 的子数组数目](https://leetcode.cn/problems/number-of-subarrays-with-gcd-equal-to-k/)

> 给你一个整数数组 `nums` 和一个整数 `k` ，请你统计并返回 `nums` 的子数组中元素的最大公因数等于 `k` 的子数组数目。
>
> **子数组** 是数组中一个连续的非空序列。
>
> **数组的最大公因数** 是能整除数组中所有元素的最大整数。
>
> ```
> 输入：nums = [9,3,1,2,6,3], k = 3
> 输出：4
> 解释：nums 的子数组中，以 3 作为最大公因数的子数组如下：
> - [9,3,1,2,6,3]
> - [9,3,1,2,6,3]
> - [9,3,1,2,6,3]
> - [9,3,1,2,6,3]
> ```

```c++
class Solution {
    int gcd (int a, int b){
        if(b == 0){
            return a;
        }

        int temp = b;
        b = a %b; 
        a = temp;
        return gcd(a, b);
    }
public:
    int subarrayGCD(vector<int>& nums, int k) {
        // cout<< gcd(3, 9);
        int len = nums.size();
        int res = 0;
        for(int i = 0; i<len; ++i){
            int g = 0;
            for(int j = i; j<len; ++j){
                g = gcd(nums[j], g);
                if(g == k){
                    res ++;
                }
                if(g < k){
                    break;
                }
            }
        }


        return res;
    }
};
```





#### [2448. 使数组相等的最小开销](https://leetcode.cn/problems/minimum-cost-to-make-array-equal/)

> 给你两个下标从 **0** 开始的数组 `nums` 和 `cost` ，分别包含 `n` 个 **正** 整数。
>
> 你可以执行下面操作 **任意** 次：
>
> - 将 `nums` 中 **任意** 元素增加或者减小 `1` 。
>
> 对第 `i` 个元素执行一次操作的开销是 `cost[i]` 。
>
> 请你返回使 `nums` 中所有元素 **相等** 的 **最少** 总开销。
>
>  
>
> **示例 1：**
>
> ```
> 输入：nums = [1,3,5,2], cost = [2,3,1,14]
> 输出：8
> 解释：我们可以执行以下操作使所有元素变为 2 ：
> - 增加第 0 个元素 1 次，开销为 2 。
> - 减小第 1 个元素 1 次，开销为 3 。
> - 减小第 2 个元素 3 次，开销为 1 + 1 + 1 = 3 。
> 总开销为 2 + 3 + 3 = 8 。
> 这是最小开销。
> ```
>
> **示例 2：**
>
> ```
> 输入：nums = [2,2,2,2,2], cost = [4,2,8,1,3]
> 输出：0
> 解释：数组中所有元素已经全部相等，不需要执行额外的操作。
> ```

```c++
class Solution {
public:
    long long minCost(vector<int>& nums, vector<int>& cost) {
        // 设变为的元素是k, 当k 是中位数时最小, 因此需要对数组进行排序
        int len = nums.size();
        vector<vector<int> > a(len, vector<int>(2));
        long long all = 0;
        for(int i = 0;i<len; ++i){
            all += (long long)cost[i];
            a[i][0] = nums[i];
            a[i][1] = cost[i];
        }
        long long mid = all/2, k =0;
        sort(a.begin(), a.end(), [](auto &x, auto &y){ return x[0]<y[0]; });

        for(int i =0; i<len; ++i){
            k+= a[i][1];
            if(k>= mid) {
                k = i;
                break;
            }
        }
        k = a[k][0];
        long long res = 0;
        for(int i =0;i<len; ++i){
            res += (long long)abs(nums[i] - k) * (long long)cost[i];
        }
        return res;

        
    }
};
```










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









#### 358

#### [2817. 限制条件下元素之间的最小绝对差 - 力扣（LeetCode）](https://leetcode.cn/problems/minimum-absolute-difference-between-elements-with-constraint/description/)

> 给你一个下标从 **0** 开始的整数数组 `nums` 和一个整数 `x` 。
>
> 请你找到数组中下标距离至少为 `x` 的两个元素的 **差值绝对值** 的 **最小值** 。
>
> 换言之，请你找到两个下标 `i` 和 `j` ，满足 `abs(i - j) >= x` 且 `abs(nums[i] - nums[j])` 的值最小。
>
> 请你返回一个整数，表示下标距离至少为 `x` 的两个元素之间的差值绝对值的 **最小值** 。
>
> ```
> 输入：nums = [4,3,2,4], x = 2
> 输出：0
> 解释：我们选择 nums[0] = 4 和 nums[3] = 4 。
> 它们下标距离满足至少为 2 ，差值绝对值为最小值 0 。
> 0 是最优解。
> ```

```c++
class Solution {
public:
    int minAbsoluteDifference(vector<int>& nums, int x) {
        int res = INT_MAX, len = nums.size();

        // 两个哨兵, 保证一定能找到比  n 大和小的元素
        set<int> s={INT_MIN/2, INT_MAX};

        for(int i = x; i<len; ++i){
            int n = nums[i-x];
            s.insert(n);
            int y = nums[i];
            // 
            auto it = s.lower_bound(y);
            res = min(res, min(*it - y, y- *--it));

        }
        return res;
        
    }
};
```





#### ------359

#### [2830. 销售利润最大化](https://leetcode.cn/problems/maximize-the-profit-as-the-salesman/)

> 给你一个整数 `n` 表示数轴上的房屋数量，编号从 `0` 到 `n - 1` 。
>
> 另给你一个二维整数数组 `offers` ，其中 `offers[i] = [starti, endi, goldi]` 表示第 `i` 个买家想要以 `goldi` 枚金币的价格购买从 `starti` 到 `endi` 的所有房屋。
>
> 作为一名销售，你需要有策略地选择并销售房屋使自己的收入最大化。
>
> 返回你可以赚取的金币的最大数目。
>
> **注意** 同一所房屋不能卖给不同的买家，并且允许保留一些房屋不进行出售。
>
> 
>
> ```
> 输入：n = 5, offers = [[0,0,1],[0,2,2],[1,3,2]]
> 输出：3
> 解释：
> 有 5 所房屋，编号从 0 到 4 ，共有 3 个购买要约。
> 将位于 [0,0] 范围内的房屋以 1 金币的价格出售给第 1 位买家，并将位于 [1,3] 范围内的房屋以 2 金币的价格出售给第 3 位买家。
> 可以证明我们最多只能获得 3 枚金币。
> ```

```c++
class Solution {
public:
    int maximizeTheProfit(int n, vector<vector<int>>& offers) {
        // 这是个区间的问题
        // 为了方便遍历，可以先把所有 end 相同的数据用哈希表归类。

        // group[i] 是 i == end 的 集合, 既然记录了 end 那么 end 就可以不要了
        vector<vector<pair<int, int> > > groups(n);
        for(auto & offer: offers){
            int s = offer[0], e = offer[1], gold = offer[2];
            groups[e].push_back({s, gold}); 
        }

        vector<int> f(n+1, 0);
        for(int i =0; i<n; ++i){
            f[i+1] = f[i];
            for(auto& group: groups[i]){
                int start = group.first, gold = group.second;
                f[i+1] = max(f[i+1], f[start] + gold);
            }
        }
        return f[n];
        
    }
};
```



相似题目
> 2008. 出租车的最大盈利（和本题几乎一样）
> 1235. 规划兼职工作（数据范围更大的情况，我的题解）
> 1751. 最多可以参加的会议数目 II（区间个数限制）
> 2054. 两个最好的不重叠活动
>
> 作者：灵茶山艾府
> 链接：https://leetcode.cn/problems/maximize-the-profit-as-the-salesman/solutions/2396402/xian-xing-dpfu-xiang-si-ti-mu-pythonjava-wmh7/
> 来源：力扣（LeetCode）
> 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。





#### [2831. 找出最长等值子数组](https://leetcode.cn/problems/find-the-longest-equal-subarray/)

> 给你一个下标从 **0** 开始的整数数组 `nums` 和一个整数 `k` 。
>
> 如果子数组中所有元素都相等，则认为子数组是一个 **等值子数组** 。注意，空数组是 **等值子数组** 。
>
> 从 `nums` 中删除最多 `k` 个元素后，返回可能的最长等值子数组的长度。
>
> **子数组** 是数组中一个连续且可能为空的元素序列。
>
>  
>
> **示例 1：**
>
> ```
> 输入：nums = [1,3,2,3,1,3], k = 3
> 输出：3
> 解释：最优的方案是删除下标 2 和下标 4 的元素。
> 删除后，nums 等于 [1, 3, 3, 3] 。
> 最长等值子数组从 i = 1 开始到 j = 3 结束，长度等于 3 。
> 可以证明无法创建更长的等值子数组。
> ```
>
> **示例 2：**
>
> ```
> 输入：nums = [1,1,2,2,1,1], k = 2
> 输出：4
> 解释：最优的方案是删除下标 2 和下标 3 的元素。 
> 删除后，nums 等于 [1, 1, 1, 1] 。 
> 数组自身就是等值子数组，长度等于 4 。 
> 可以证明无法创建更长的等值子数组。
> ```
>
>  

```c++
class Solution {
public:
    int longestEqualSubarray(vector<int>& nums, int k) {
        // 最大值为 出现频率最大的数字, 
        int len = nums.size();


        vector<vector<int> > pos(len+ 1);

        for(int i = 0; i<len; ++i){
            int n = nums[i];
            pos[n].push_back(i);
        }

        int res = 0;

        // 相同数字的id 为[3, 5, 9] 如何算出 删除k 元素, 以后最长的子数组呢
        // 5-3+1 - (2) = 1


        for(int i = 1; i<= len; ++i){
            if(res>= pos[i].size()){
                continue;
            }
            int l = 0, r = 0;
            while(r < pos[i].size()){
                while(pos[i][r] - pos[i][l] + 1 - (r-l+ 1)> k ){
                    l++;
                }
                r++;
                res = max(res, r-l);

            }
        }
        return res;




    }
};
```







```c++
#include<iostream>
#include<vector>
using namespace std;




int main(){
    int n;
    cin >> n;
    vector<int> a(n, 0), b;
    for(int i = 0; i<n; ++i){
        cin>> a[i];
    }
    
    // change
    int flag = 1;
    int res = 0;
    while(flag){
        flag = 0;
        b.push_back(a[0]);
        n = a.size();
        for(int i = 1; i< n; ++i){
            if(a[i] > a[i-1]){
                b.push_back(a[i]);
                flag = 1;
            }
        }
        
        res++;
        
        swap(a, b);
        b.clear();
        
    }
    cout<< res<< '\n';

    
    return 0;
}
```







[2904. 最短且字典序最小的美丽子字符串 - 力扣（LeetCode）](https://leetcode.cn/problems/shortest-and-lexicographically-smallest-beautiful-string/description/)



> 给你一个二进制字符串 `s` 和一个正整数 `k` 。
>
> 如果 `s` 的某个子字符串中 `1` 的个数恰好等于 `k` ，则称这个子字符串是一个 **美丽子字符串** 。
>
> 令 `len` 等于 **最短** 美丽子字符串的长度。
>
> 返回长度等于 `len` 且字典序 **最小** 的美丽子字符串。如果 `s` 中不含美丽子字符串，则返回一个 **空** 字符串。
>
> 对于相同长度的两个字符串 `a` 和 `b` ，如果在 `a` 和 `b` 出现不同的第一个位置上，`a` 中该位置上的字符严格大于 `b` 中的对应字符，则认为字符串 `a` 字典序 **大于** 字符串 `b` 。
>
> - 例如，`"abcd"` 的字典序大于 `"abcc"` ，因为两个字符串出现不同的第一个位置对应第四个字符，而 `d` 大于 `c` 。
>
>  
>
> **示例 1：**
>
> ```
> 输入：s = "100011001", k = 3
> 输出："11001"
> 解释：示例中共有 7 个美丽子字符串：
> 1. 子字符串 "100011001" 。
> 2. 子字符串 "100011001" 。
> 3. 子字符串 "100011001" 。
> 4. 子字符串 "100011001" 。
> 5. 子字符串 "100011001" 。
> 6. 子字符串 "100011001" 。
> 7. 子字符串 "100011001" 。
> 最短美丽子字符串的长度是 5 。
> 长度为 5 且字典序最小的美丽子字符串是子字符串 "11001" 。
> ```

```c++
class Solution {
public:
    string shortestBeautifulSubstring(string s, int k) {
        // 如果 s 的某个子字符串中 1 的个数恰好等于 k ，则称这个子字符串是一个 美丽子字符串 。
        string res;
        
        int len = s.size();
        
        int l = 0, r = 0;
        int cnt = 0;
        while(r< len){
            if(s[r++] == '1'){
                cnt++;
            }
            
            while(cnt == k){
                // cout<<  s.substr(l, r-l)<< endl;
                if(res.empty()){
                    res = s.substr(l, r-l);
                }else if(res.size()  && res.size()> r-l ){
                    // cout<< "short string"<< endl;
                    res = s.substr(l, r-l);
                }else if(res.size() == r-l){
                    res = min(res, s.substr(l, r-l));
                }
                
                if(s[l++] == '1'){
                    cnt--;
                }
            }
            

        }
        
        return res;
        
    }
};
```







#### [2905. 找出满足差值条件的下标 II](https://leetcode.cn/problems/find-indices-with-index-and-value-difference-ii/)

> 给你一个下标从 **0** 开始、长度为 `n` 的整数数组 `nums` ，以及整数 `indexDifference` 和整数 `valueDifference` 。
>
> 你的任务是从范围 `[0, n - 1]` 内找出 **2** 个满足下述所有条件的下标 `i` 和 `j` ：
>
> - `abs(i - j) >= indexDifference` 且
> - `abs(nums[i] - nums[j]) >= valueDifference`
>
> 返回整数数组 `answer`。如果存在满足题目要求的两个下标，则 `answer = [i, j]` ；否则，`answer = [-1, -1]` 。如果存在多组可供选择的下标对，只需要返回其中任意一组即可。
>
> **注意：**`i` 和 `j` 可能 **相等** 。

```c++
class Solution {
public:
    vector<int> findIndices(vector<int>& nums, int idiff, int vdiff) {
        int len = nums.size();

        // 满足 (j-i)>= idiff 时, 左边数组的最大最小值
        int maxid = 0, minid = 0;
        for(int j  = idiff; j< len; ++j){
            int i = j - idiff;
            if(nums[maxid] < nums[i]){
                maxid = i;
            }
            if(nums[minid] > nums[i]){
                minid = i;
            }

            if(abs(nums[maxid] - nums[j]) >= vdiff){
                return {maxid, j};
            }

            if(abs(nums[j] - nums[minid]) >= vdiff){
                return {minid, j};
            }
        }

        return {-1, -1};
    }
};
```

