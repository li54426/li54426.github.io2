#!/bin/bash

filename=$(date +"%Y-%m-%d-.md")

cat > "$filename" << EOF
---
layout: post
title: "网页名称"
categories: AI
tags: AI
author: li54426
---

* content
{:toc}
EOF

echo "文件已生成：$filename"
