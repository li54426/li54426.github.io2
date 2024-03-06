#!/bin/bash

filename=$(date +"%Y-%m-%d-.md")

cat > "$filename" << EOF
---
layout: blog
banana: true
category: algorithm
title:  第场周赛
date:   $(date +"%Y-%m-%d %H:%M:%S")
background: purple
tags:
- algorithm
- leetcode_week
---

* content
{:toc}
EOF

echo "文件已生成：$filename"
