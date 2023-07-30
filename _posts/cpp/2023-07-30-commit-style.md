---
layout: blog
banana: true
category: cpp
title:  commit 规范
date:   2023-07-30 19:08:53
background: green
tags:
- cpp
- standard
---

* content
{:toc}




#### 规范

```
<type>(<scope>): <subject>
<BLANK LINE>
<body>
<BLANK LINE>
<footer>
```







- type: `必填` commit 类型，有业内常用的字段，也可以根据需要自己定义
    - feat 增加新功能
    - fix 修复问题 / BUG
    - style 代码风格相关无影响运行结果的
    - perf 优化 / 性能提升
    - refactor 重构
    - revert 撤销修改
    - test 测试相关
    - docs 文档 / 注释
    - chore 依赖更新 / 脚手架配置修改等
    - workflow 工作流改进
    - ci 持续集成
    - types 类型定义文件更改
    - wip 开发中
    - undef 不确定的分类
- scope: commit 影响的范围，比如某某组件、某某页面
- subject: `必填` 简短的概述提交的代码，建议符合 50/72 formatting
- body: commit 具体修改内容，可以分为多行，建议符合 50/72 formatting
- footer: 其他备注，包括 breaking changes 和 issues 两部分

