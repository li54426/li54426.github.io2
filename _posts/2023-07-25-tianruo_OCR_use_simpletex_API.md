---
layout: post
title: "天若ocr调用simpletex"
date:   2023-07-25 21:19:24 +0800
categories: API
tags: software
author: li54426
---

* content
{:toc}


天若 OCR调用 simpletex API

记录一次使用别人的接口






#### 1 什么是天若 OCR

- **图片转文字**准确率超高的办公利器
- 可以截图
- 可以翻译
- 可以识别公式





#### 2 作者暴露出的部分接口

```C#
//image：要识别的图片
public static string OCR_Custom(Image image)
{
    //string url = "";
    //string poststr ="";
    //string result =CustomHelp.HttpPost(url,poststr);
    //获取请求获取解析结果后按照下面格式进行解析
    TxtFormat.Root jsonRoot=new TxtFormat.Root();
    jsonRoot.result=new List<TxtFormat.TextBlock>();
    jsonRoot.isHasLocation=true;//判断是否含有坐标返回
    for(int i=0; i<5; i++)//遍历返回的json字符串
    {
        TxtFormat.TextBlock textBlock = new TxtFormat.TextBlock();
        textBlock.Text = "公式测试文本"+i.ToString();//json内的文本
        textBlock.TopLeft = new Point(0,0);//左上角坐标
        textBlock.TopRight = new Point(0,0);//右上角坐标
        textBlock.BottomRight =new Point(0,0);//右下角坐标
        textBlock.BottomLeft =new Point(0,0);//左下角坐标
        jsonRoot.result.Add(textBlock);
    }
    string json = JsonConvert.SerializeObject(jsonRoot);
    return json;
}
```





