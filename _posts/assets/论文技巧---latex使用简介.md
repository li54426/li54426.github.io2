## 论文技巧Latex使用简介:

### latex摘要----快速入门

中文使用cjkutf8

- 使用 % 进行注释
- 段与段之间要空一行

### 0 安装

网址  [清华大学开源软件镜像站 | Tsinghua Open Source Mirror](https://mirrors.tuna.tsinghua.edu.cn/)

推荐miktex + texstudio

安装推荐:miktix和texstudio

miktex console  -> 更新 ->选择一个源





###1. 公式

   ####1.1 基本使用

- 使用$$表示行内公式
- 如果需要直接使用不带编号的行间公式，则将公式用命令 \ [ 和 \ ] 包裹
- 使用带编号的公式 使用  \begin{equation}   和   \end{equation}   
    ​       还可以用 \tag 命令手动修改公式的编号，或者用 \notag 命令取消为公式编号
    ​       数学模式有如下特点:

```
1 空格忽略, 
2 不允许有空行, 
3 所有字母当作变量处理
```

   ####1.2 数学符号

| 省略号                 | 代码                                   |
| ---------------------- | -------------------------------------- |
| $\div$                 | \div                                   |
| $\times$               | \times                                 |
|                        |                                        |
| 空格                   | \quad                                  |
| 省略号$\dots$          | \dots                                  |
| 上标                   | ^{}                                    |
| 下标                   | _{}                                    |
|                        |                                        |
| 根号$\sqrt[n]{}$       | \sqrt[n]{}                             |
| 分数     $\frac{}{}$   | \frac{}{}                              |
|                        |                                        |
| 或者    $$             | \parallel                              |
| 无穷大      $\infty  $ | \infty                                 |
|                        |                                        |
| 求和     $\sum $       | \sum                                   |
| 求和有上下             | \sum \limits^{}_{}                     |
|                        |                                        |
| 不等号   $\ne $        | \ne                                    |
| 大于等于     $\ge$     | \ge                                    |
| 小于等于    $\le   $   | \le                                    |
| 约等于      $\approx $ | \approx                                |
| 等价        $\equiv  $ | \equiv                                 |
|                        |                                        |
| 范数(双竖杠)  $\Vert $ | \Vert                                  |
|                        |                                        |
| 罗马数字   $$          | \uppercase\expandafter{\romannumeral2} |

| 希腊字母 | Latex代码 |
| -------- | --------- |
| $\alpha$ | \alpha    |
| $\beta$  | \beta     |
| $\delta$ | \delta    |
|          |           |
| $\Delta$ | \delta    |
| $\Pi$    | \Pi       |



#### 1.3 公式引用

```
\begin{equation}
	\label{key}
\end{equation}

%当引用时, 没有括号 例如 6 
\ref{key}
%当引用时, 需要括号 例如 6 
(\ref{key})
```



#### 1.4 特殊的公式----规划

```
\begin{align}
% 规划的形式
% 最后一行没有 \\ 
    \min  \quad  
        &   目标函数             \\
    \text{s.t.}   \quad   	    	
        &   约束1  \label {cons1}\\
        &   约束2  \label {cons2}\\
        &   约束3  \label {cons3}\\
        &   约束4	\label {cons4}
\end{align} 
```

```
%分段函数
\begin{equation}
f(x)=
    \begin{cases}
    0   & \text{x=0}\\
    1   & \text{x!=0}
    \end{cases}
\end{equation}
```

#### 1.5 多行公式   公式编号在中间

```
%  如果要折行的话，习惯上优先在等号之前折行，其次在加号、减号之前，再次在乘号、除号之前。其它位置应当避免折行。  目前最常用的是 align 环境，它将公式用 & 隔为两部分并对齐。分隔符通常放在等号左边
%   用  \notag 去掉某行的编号

\begin{equation}
\begin{aligned}
    a &= b + c \\
    d &= e + f + g \\
    h + i &= j + k \\
    l + m &= n
\end{aligned}
\end{equation}

%如果因为加的元素太多, 一行放不开 建议, 
\begin{equation}
\begin{aligned}
    a =&  b + c \\
    + & e + f + g \\
    + & j + k \\
    + & n
\end{aligned}
\end{equation}



%如果因为加的元素太多, 一行放不开 建议 
	\begin{equation}
		\begin{aligned}
			\text{min}  \quad &  b + c \\
			\text{s.t.} \quad & e + f + g \\
			& j + k \\
			& n
		\end{aligned}
	\end{equation}
```







###2. 图片

#### 2.1 单个标题

   \includegraphics[⟨options⟩]{⟨fi lename ⟩}，
   文件名可能需要用相对路径或绝对路径表示, 图片文件的扩展名一般可不写

   ```
\include{chapters/file} % 相对路径
\include{/home/Bob/file} % *nix（包含 Linux、macOS）绝对路径
\include{D:/file} % Windows 绝对路径，用正斜线
   ```

    ```
    %导包
    usepackage{graphics}
    
    %导入图片, 当模板为两列, 但是想让图片占据着两列时, 使用\begin{figure*}[t]
    %图片
    \begin{figure}[htbp]
    %居中
    \centering
    %\includegraphics[width=2.5in]{Autoencoder1}
    %占据0.8宽度
    \includegraphics[width=0.40\textwidth]{time.png}
    %图片名称
    \caption{Experimental running time}
    \label{time}
    \end{figure}


- \[htbp\] 为调整图片排版位置选项，说明如下：

    \[h\]当前位置。将图形放置在正文文本中给出该图形环境的地方。如果本页所剩的页面不够，这一参数将不起作用。  
    \[t\]顶部。将图形放置在页面的顶部。  
    \[b\]底部。将图形放置在页面的底部。  
    \[p\]浮动页。将图形放置在一只允许有浮动对象的页面上。

#### 2\. 并排插入多张图片并公用一个caption

有时候我们希望同时插入一组图片，共用一个大标题且为每张子图设小标题，效果如下：  
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200417095821196.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM4NTI2NjIz,size_16,color_FFFFFF,t_70)   
方法：同时引入 \\usepackage{graphicx} 和 \\usepackage{subfigure} 宏包，如下代码实现。

```
\begin{figure}[htbp]
\centering
\subfigure[Fig1]{
\includegraphics[scale=0.25]{Fig1.png} \label{1}
}
\quad
\subfigure[Fig2]{
\includegraphics[scale=0.25]{Fig2.png} \label{2} 
}
\quad
\subfigure[Fig3]{
\includegraphics[scale=0.25]{Fig3.png}\label{3}
}
\quad
\subfigure[Fig4]{
\includegraphics[scale=0.25]{Fig4.png}\label{4}
}
\caption{Experimental results of the authors}
\end{figure}

```

代码说明：  
\\subfigure\[Fig1\] 为子图的标题；  
\\caption{Experimental results of the authors} 为总标题。



### 3.引用 (参考文献)

#### 3.1 IEEE模板

```latex
%  IEEE官网的latex模板，无法调用cite包。与下面第一节调用的biblatex包冲突（模板里自带的，开始没注意到，相当于我调用了两个参考文献的包），然后我改成网上一样的biblatex调用声明还是不行，因为新版必须用bibtex编译，且要在[ ]中声明，很多博客用的是biber，并且默认也是biber！即调用biblatex包必须要声明是用bibtex编译！

%导包, 在文章开始之前也就是 \begin{document}
\usepackage[backend=bibtex,sorting=none]{biblatex}
\addbibresource{ref.bib}

%sorting=none表示按照参考文献在论文中出现的先后顺序排序。
hyperref=true和backref=true表示为各个参考文献的引用处、及定理、定义、例子等的引用处都添加上超链接；

% 显示参考文献, 在\end{document}之前
\printbibliography

%引用格式:
\cite{key}
```



#### 3.2 其他模板

```latex
%引用, FCN是我们在bibtex文件中自定义的名字
以一篇古老的分子动力学文章作为参考\cite{yu2013toward}

%如果不想用方括号, 可以使用
\usepackage[superscript]{cite}

%参考文献, 在 \end{document}之前写
\bibliographystyle{IEEEtran}
\bibliography{ref.bib}
```

####3.2引用网址

```
	%正文前引用
usepackagefurl}

	%bib文件中加入: 
@Misc{cite变量名,
howpublished = {\url{网页地址}},
note = {Accessed进入网页的具体日期},
title = {网页名称},
author = {作者}
}
1911正文中具体使用为
1\cite{cite变量名）


```



### 4.表格

网址 : tablegenerator.com

```
\begin{tabular}{cc}%一个c表示有一列，格式为居中显示(center)

%\begin{tabular}{|c|c|}通过添加 | 来表示是否需要绘制竖线
(1,1)&(1,2)\\%第一行第一列和第二列  中间用&连接
(2,1)&(2,2)\\%第二行第一列和第二列  中间用&连接
\end{tabular}
```

```
   %经典三线表格   table的目的就是把表格给图片化
   \begin{table}[]
       	\centering
    	\caption{Notations in This Paper}
    	\begin{tabular}{|c|c|}
    		\hline
    		标题1    &    标题2   \\
    		\hline
    		
	    	$P$	          & the provider      \\
	    	$M_{it}$      &   the   \\
 		\hline
    	\end{tabular}
    \end{table}
```



### 5 算法

```
%算法宏包
\usepackage[linesnumbered,ruled,vlined]{algorithm2e}
\usepackage{setspace}


\begin{algorithm}[t]
    %设置算法编号
    %\renewcommand{\thealgocf}{3-1}
    \SetAlgoLined %显示end
    \caption{Genetic Algorithm}%算法名字
    \label{}
    	\KwIn{input parameters $T, $}%输入参数
    	\KwOut{$ $}%输出
    %      '\;'   用于换行
    some description\; 
    \For{condition}{
        \If{condition}{
        	1\;
        }
    }

    return 
 \end{algorithm} 
```

### 6 字体大小

```
%学院名称太长, 导致作者变成了两行, 可以把学院名称的字体调小
\tiny Hello Latex.
\scriptsize Hello Latex.
\footnotesize Hello Latex.
\small Hello Latex.
\normalsize Hello Latex.
```











