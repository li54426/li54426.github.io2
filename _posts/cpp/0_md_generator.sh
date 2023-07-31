#!/bin/bash

filename=$(date +"%Y-%m-%d-.md")

cat > "$filename" << EOF
---
layout: blog
banana: true
category: cpp
title:  
date:   $(date +"%Y-%m-%d %H:%M:%S")
background: green
tags:
- cpp
---

* content
{:toc}
EOF

echo "文件已生成：$filename"
