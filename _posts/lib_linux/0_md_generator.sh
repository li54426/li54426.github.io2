#!/bin/bash

filename=$(date +"%Y-%m-%d-.md")

cat > "$filename" << EOF
---
layout: blog
category: lib_linux
title:  
date:   $(date +"%Y-%m-%d %H:%M:%S")
tags:
- lib_linux
---

* content
{:toc}
EOF

echo "文件已生成：$filename"
