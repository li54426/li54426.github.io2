#!/bin/bash

filename=$(date +"%Y-%m-%d-.md")

cat > "$filename" << EOF
---
layout: blog
category: summary
title:  
date:   $(date +"%Y-%m-%d %H:%M:%S")
tags:
- summary
---

* content
{:toc}
EOF

echo "文件已生成：$filename"
