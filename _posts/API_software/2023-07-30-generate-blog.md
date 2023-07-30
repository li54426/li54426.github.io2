---
layout: blog
banana: true
category: API_software
title:  
date:   2023-07-30 16:28:49
background: blue
tags:
- default
- memcache
---

* content
{:toc}




## 修改

- 从原作者项目地址进行 `clone` [原作者项目地址在这里](https://github.com/Liberxue/liberxue.github.io)
- 进行修改
- 上传





#### 设置说明

- 修改_config.yml 的 links 为您的菜单
- 修改_config.yml 的 paginate 为您的按照多少页分页
- 修改自己的网**图标**`\style\favicons\favicon.ico`
- 修改自己的网**标志**`\style\favicons\logo-liberxue.png`
- 在`_layouts\blog.html`中, 将 `本文由 <a href="/">liberxue</a> 创作` 改为您的`github`名字
- 修改`\about.md`中的内容, 它对应着文章中的`关于`这一页
- 在`_layouts\default.html`中, 将 `本文由 <a href="/">liberxue</a> 创作` 改为您的`github`名字



#### 使用说明

- 打开`\_posts` 文件夹是**博客文章**所在的位置，文件夹中的内容就是你的**博客**, 博客格式为 `markdown`
- 文件名格式为`2015-06-11-xxxx.md`, **不能有中文**, 因为文件名会成为这篇博文的链接
- ~~当天的`blog`不会上传~~

```markdown
layout: blog
book: true
title:  "《美丽新世界》之幸福和自由思考"
background: green
background-image: http://ot1cc1u9t.bkt.clouddn.com/17-7-15/78939382.jpg
date:   2017-07-03 23:13:54
category: 书籍
tags:
- 美丽新世界 





可选项目
// 设置颜色
background: green
background: blue
background: purple

// 设置路径
redirect_from:
  - /about/
```





#### 颜色说明

- 蓝色: 软件/ API/ 提升效率
- 绿色: 语言相关
- 紫色: 算法/ 周赛



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
background: green
tags:
- default
- memcache
---

* content
{:toc}
EOF

echo "文件已生成：$filename"

```

