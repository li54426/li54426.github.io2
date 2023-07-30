#!/bin/bash

filename=$(date +"%Y-%m-%d-.md")

cat > "$filename" << EOF
---
layout: blog
banana: true
category: algorithm
title:  
date:   $(date +"%Y-%m-%d %H:%M:%S")
background: pink
tags:
- algorithm
---

* content
{:toc}
EOF

echo "文件已生成：$filename"
