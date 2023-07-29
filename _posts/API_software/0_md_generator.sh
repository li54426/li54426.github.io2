#!/bin/bash

filename=$(date +"%Y-%m-%d-.md")

cat > "$filename" << EOF
---
layout: blog
banana: true
category: API_software
title:  
date:   $(date +"%Y-%m-%d %H:%M:%S")
background: blue
tags:
- default
- memcache
---

* content
{:toc}
EOF

echo "文件已生成：$filename"
