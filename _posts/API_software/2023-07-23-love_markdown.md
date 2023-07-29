---
layout: blog
banana: true
title:  永远热爱markdown
category: API_software
background-image: https://i0.hdslb.com/bfs/album/2f4f352c599fdd8c59177cd0aabd91db8c7dad15.png
date:   2023-07-23 14:21:18
tags:
- software
- markdown
---

* content
{:toc}










![image-20220906145334336](https://i0.hdslb.com/bfs/album/2f4f352c599fdd8c59177cd0aabd91db8c7dad15.png)

### 一 简介

#### 1 什么是markdown

​	Markdown是一种轻量级标记**语言**，创始人为约翰-格鲁伯（John Gruber）。它允许人们使用易读易写的纯文本格式编写文档，然后转换成有效的XHTML（或者HTML）文档。这种语言吸收了很多在电子邮件中已有的纯文本标记的特性。
​	由于Markdown的轻量化、易读易写特性，并且对于图片，图表、数学式都有支持，许多网站都广泛使用Markdown来撰写帮助文档或是用于论坛上发表消息。如GitHub，Reddit，Diaspora，Stack Exchange，OpenStreetMap，SourceForge、简书等，甚至还能被使用来撰写电子书。

-------来自百度百科

#### 2 为什么我们需要markdown

- 在我们需要进行记笔记时, 我们对于格式( 例如, 字号, 段间距)并没有太大的要求, 反而对结构有要求, 例如标题是什么, 这个标题下有几个小标题, 对于我们的要求来讲, word 显得过于臃肿,  
- markdown 是 latex 和 word 的一个 trade-off
- 因为他的轻量化, 导致他的格式固定, 使用不同的平台不会出现 word 那样不兼容的问题
- 因为是近几年才出现的( 04年 ), 能够更贴近这个时代, 例如md文件本身不保存图片, 这就可以使用网络上的图床, 让专业的人干专业的事

#### 3 markdown 工具( 软件 )

Typora( 强推 )[Typora 官方中文站](https://typoraio.cn/)、MacDown

#### 4 markdown 插件

```
markdown here [Markdown Here](https://markdown-here.com/)
markdownload [markdownload](https://microsoftedge.microsoft.com/addons/detail/hajanaajapkhaabfcofdjgjnlgkdkknm)
```



### 二 markdown 语法

#### 1 标题 '#' 号----生成文章的结构

- 后面需要一个空格
- 一个是一级标题, 两个是二级标题, 依次类推, 越少代表优先级越高,
- 被用来生成文章的结构, 我经常用###代表目录, ####代表子目录

```
### 第一章
#### 第一章第一节
#### 第一章第二节
```

#### 2 无序列表

```
使用- (注意后面有空格)
```

#### 3 网址

```
[显示内容](网址)
例如上文的
[Typora 官方中文站](https://typoraio.cn/)
```

#### 4 图片

```
![图片名称]()
![image-20220906145334336](https://i0.hdslb.com/bfs/album/2f4f352c599fdd8c59177cd0aabd91db8c7dad15.png)
```

#### 5 代码

> 使用```(数字1前面的那个)

#### 6 引用

```
> (小于号)
```

### 三 markdown插件使用说明

#### 1 markdown here------将markdown上传为 html 格式

```
markdown here [Markdown Here](https://markdown-here.com/)
```

**使用方法**    :   点击插件图标或者是, alt + ctrl + M (动画在下面)

![GIF 2022-9-11 20-27-10](https://i0.hdslb.com/bfs/album/fdee3963b6834bfb16fc70114f6202ea19f5827a.gif)

设置格式  : 右键浏览器插件图标 -> 扩展选项-> 基本渲染CSS

![image-20220911203043930](https://i0.hdslb.com/bfs/album/963686deae86fd0d6fb499b10337941859f1b3b9.png)

```

```

还可以使用 latex公式使用$$包裹起来

![image-20220911203928798](https://i0.hdslb.com/bfs/album/eb781ce80e9e1c58933aec422858372f048bbfc2.png)

#### 2 将网页下载为markdown

```
markdownload [markdownload](https://microsoftedge.microsoft.com/addons/detail/hajanaajapkhaabfcofdjgjnlgkdkknm)
```

**使用方法**:   点击图标 -> Download

![GIF 2022-9-11 20-37-20](https://i0.hdslb.com/bfs/album/0d90a870ae85cc1425ad47f66814268cac12b16d.gif)
