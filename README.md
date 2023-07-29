                .::         .::                       .::      .::                 
                .::       .:.::                        .::   .::                    
                .::         .::         .::    .: .:::  .:: .::   .::  .::   .::    
                .::      .::.:: .::   .:   .::  .::       .::     .::  .:: .:   .:: 
                .::      .::.::   .::.::::: .:: .::     .:: .::   .::  .::.::::: .::
                .::      .::.::   .::.:         .::    .::   .::  .::  .::.:        
                .::::::::.::.:: .::    .::::   .:::   .::      .::  .::.::  .::::   
                          Copyright (c) 2016-2018 liberxue
                                 http://www.liberxue.com



#### 设置说明

- 修改_config.yml 的 links 为您的菜单
-  修改_config.yml 的 paginate 为您的按照多少页分页



#### 自动提交脚本

- 只是一个博客, 提交的信息就不重要了, 只提交一个 时间信息就好

```bash
@echo off

setlocal enabledelayedexpansion

REM 获取当前日期和时间
for /f "tokens=1-4 delims=/ " %%i in ("%date%") do (
    set year=%%l
    set month=%%j
    set day=%%k
)

for /f "tokens=1-3 delims=:." %%i in ("%time%") do (
    set hour=%%i
    set minute=%%j
    set second=%%k
)

REM 构建提交信息
set commit_message=%year%-%month%-%day% %hour%:%minute%:%second%

REM 添加文件到暂存区
git add .

REM 提交代码，并包含日期和时间作为提交信息
git commit -m "%commit_message%"

REM 推送到远程仓库
git push

endlocal

```



#### 自动生成 markdown

```markdown
#!/bin/bash

filename=$(date +"%Y-%m-%d-.md")

cat > "$filename" << EOF
---
layout: blog
banana: true
category: default
title:  
date:   $(date +"%Y-%m-%d %H:%M:%S")
background-image: http://ot1cc1u9t.bkt.clouddn.com/17-8-1/24280498.jpg
tags:
- default
- memcache
---

* content
{:toc}
EOF

echo "文件已生成：$filename"

```



原作者邮箱

```bash
liberxue@gmail.com
```







#### liberxue.github.io preview (demo) (http://www.liberxue.com)

#### `Jekyll Themes`
----------
[简体中文版帮助文档README](/ChinaREADME.md)

#### ``Lightweight``  ``Minimalist``  ``Jekyll blog``

#### The first step is to click [fork][https://github.com/liberxue/liberxue.github.io/fork]
#### The second step is to modify the _config.yml in URL for your domain name

#### OK all right, it's that simple

#### I don't want any copyright also don't need you to donate, I only need you with a star 🌟  Thx 😄

- [x] Automatic generation tag
- [x] Automatic generation of JSON search
- [x] Adaptive template
- [x] Automatic generation of feed.xml
- [x] Automatic paging generation
- [x] Modify _config.yml's links for your menu
- [x] Modify the _config.yml of paginate for how many pages you want to page
## Stargazers over time

[![Stargazers over time](https://starchart.cc/Liberxue/liberxue.github.io.svg)](https://starchart.cc/Liberxue/liberxue.github.io)

![uiliberxue](https://raw.githubusercontent.com/Liberxue/liberxue.github.io/master/thumbnails/ui.jpg) 

 ![archives](https://raw.githubusercontent.com/Liberxue/liberxue.github.io/master/thumbnails/archives.png) 

 ![blog](https://raw.githubusercontent.com/Liberxue/liberxue.github.io/master/thumbnails/blog.png) 

 ![tags](https://raw.githubusercontent.com/Liberxue/liberxue.github.io/master/thumbnails/tags.png) 

  ![404](https://raw.githubusercontent.com/Liberxue/liberxue.github.io/master/thumbnails/404.png) 

----------
![blog JSON search](https://raw.githubusercontent.com/Liberxue/liberxue.github.io/master/thumbnails/01.gif) 

#### 1.First step Click[fork](https://github.com/Liberxue/liberxue.github.io#fork-destination-box)

----

![fork](https://raw.githubusercontent.com/Liberxue/liberxue.github.io/master/thumbnails/02.gif)

  


#### 2. modify _config.yml url URL for your domain

![modify _config.yml url URL for your domain](https://raw.githubusercontent.com/Liberxue/liberxue.github.io/master/thumbnails/04.gif)




* [Issues](https://github.com/Liberxue/liberxue.github.io/issues)

* [Email](mailto:liberxue@gmail.com)

* [Twitter](https://twitter.com/liberxue).

