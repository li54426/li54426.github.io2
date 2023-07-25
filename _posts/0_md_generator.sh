#!/bin/bash

filename=$(date +"%Y-%m-%d-.md")

cat > "$filename" << EOF
---
layout: post
title:  ""
date:   $(date +"%Y-%m-%d %H:%M:%S %z")
categories: default
tags: default
author: li54426
---

* content
{:toc}
EOF

echo "文件已生成：$filename"
