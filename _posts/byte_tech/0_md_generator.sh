#!/bin/bash

filename=$(date +"%Y-%m-%d-.md")

cat > "$filename" << EOF
---
layout: blog
banana: true
category: byte_tech
title:  "Go_"
date:   $(date +"%Y-%m-%d %H:%M:%S")
background: green
tags:
- byte_tech
- go
---

* content
{:toc}
EOF

echo "文件已生成：$filename"
