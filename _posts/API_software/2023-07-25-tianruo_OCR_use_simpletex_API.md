---
layout: blog
banana: true
category: API_software
title:  天若ocr调用simpletex
date:   2023-07-25 21:19:24
background: blue
tags:
- software
- API
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







- 一开始认为 `CustomHelp.HttpPost()`是一个具体的类, 但是也没有一个demo来说明各个参数的意义, 因此认为是**伪码**, 所以认为下面的也全是伪代码, 让我付出了惨重的代价
- 实际上就应该是一个具体的类, 因为后文的TxtFormat等也是具体的类, 但是没有使用说明, 就只能使用 **HttpWebResponse**库交换 http报文



#### 3 天若开源版本的代码

- 猜测**typeset_txt** 就是显示的内容, 也是 接口中返回的**原始字符串**对应起来

```c#
var img = image_screen;
				var inArray = OcrHelper.ImgToBytes(img);
				var s = "{\t\"formats\": [\"latex_styled\", \"text\"],\t\"metadata\": {\t\t\"count\": 0,\t\t\"platform\": \"windows 10\",\t\t\"skip_recrop\": true,\t\t\"user_id\": \"\",\t\t\"version\": \"snip.windows@01.02.0027\"\t},\t\"ocr\": [\"text\", \"math\"],\t\"src\": \"data:image/jpeg;base64," + Convert.ToBase64String(inArray) + "\"}";
				var bytes = Encoding.UTF8.GetBytes(s);
				var httpWebRequest = (HttpWebRequest)WebRequest.Create("https://api.mathpix.com/v3/latex");
				httpWebRequest.Method = "POST";
				httpWebRequest.ContentType = "application/json";
				httpWebRequest.Timeout = 8000;
				httpWebRequest.ReadWriteTimeout = 5000;
				httpWebRequest.Headers.Add("app_id: mathpix_chrome");
				httpWebRequest.Headers.Add("app_key: 85948264c5d443573286752fbe8df361");
				using (var requestStream = httpWebRequest.GetRequestStream())
				{
					requestStream.Write(bytes, 0, bytes.Length);
				}
				var responseStream = ((HttpWebResponse)httpWebRequest.GetResponse()).GetResponseStream();
				var value = new StreamReader(responseStream, Encoding.GetEncoding("utf-8")).ReadToEnd();
				responseStream.Close();
				var text = "$" + ((JObject)JsonConvert.DeserializeObject(value))["latex_styled"] + "$";
				split_txt = text;
				typeset_txt = text;
```







#### 4 simpletex API 的python调用

- 使用 **post** 方法

```python
import requests
api_url="https://server.simpletex.cn/api/latex_ocr/v2"  # 接口地址
data = { } # 请求数据
header={ "token": "" } # 鉴权信息，此处使用UAT方式
file=[("file",("test.png",open("test.png", 'rb')))] # 请求文件,字段名一般为file
res = requests.post(api_url, files=file, data=data, headers=header) # 使用requests库上传文件
print(res.status_code)
print(res.text)
```





#### 5 如何输出错误

- 发现 **MessageBox.Show**()能输出信息, 就用它来**调试**

```c#
MessageBox.Show(responseContent.ToString() );
```







#### 6 协议 post 的数据格式

- 边界符: `boundary=AaB03x `
    - Post 中定义的**换行符**是 \r\n, 每一个边界符前面都需要加 2 个连字符 “--”，然后跟上换行符。
- 使用**Content-Type** 指定发送或接收实体正文的**媒体类型**
    - `Content-Type` 由两部分组成，用斜杠分隔：媒体类型（media type）和子类型（subtype）。**常见的媒体**类型包括：
        - `text/plain`：纯文本类型。
        - `text/html`：HTML 文档类型。
        - `application/json`：JSON 数据类型。
        - `application/xml`：XML 数据类型。
        - application/octet-stream : 二进制数据.
        - `image/jpeg`：JPEG 图片类型。
        - `audio/mpeg`：MPEG 音频类型。
        - `video/mp4`：MP4 视频类型。
- `Content-Disposition`：该头部字段用于指示如何处理包含在消息体中的数据。它可以指定将数据显示在浏览器窗口中、作为附件下载、保存到磁盘等行为。常见的值包括：
    - `inline`：默认值，将数据在浏览器中显示。
    - `attachment`：将数据作为附件下载。
    - `filename=<文件名>`：指定下载时的文件名。
    - **Content-Disposition**: form-data; name="file"; filename="file1.dat", 通常是用在客户端向服务端**传送大文件数据**，如：图片或者文件
- 使用` boundary`来分隔文件
- 数据结束后的分界符，注意因为这个后面没有数据了所以需要**在后面追加一个 “--”** 表示**结束**。

```html
// 来自 https://blog.csdn.net/flymorn/article/details/6769722
Content-Type: multipart/form-data; boundary=AaB03x
 
 --AaB03x
 Content-Disposition: form-data; name="submit-name"
 
 Larry
 --AaB03x
 Content-Disposition: form-data; name="file"; filename="file1.dat"
 Content-Type: application/octet-stream
 
 ... contents of file1.dat ...
 --AaB03x--

```



#### 7 完整代码如下

```c#
	public static string OCR_Custom(Image image)
	{// Image 是一个类，它是用于处理图像和图形的基本类之一。
	    byte[] result;
	    using (var memoryStream = new MemoryStream())
	    {
	        image.Save(memoryStream, ImageFormat.Png);
	        result = memoryStream.ToArray();
	    }
	    // request
	    string url = "https://server.simpletex.cn/api/latex_ocr/v2";
	    HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
	    request.ContentType = "multipart/form-data;boundary=---------------------------boundary";
	    request.Method = "POST";
	    request.Headers["token"] = "";
	    string boundary = "---------------------------boundary";
	    byte[] boundaryBytes = Encoding.UTF8.GetBytes("\r\n--" + boundary + "\r\n");
	    string formDataTemplate = "--{0}\r\nContent-Type:application/octet-stream\r\nContent-Disposition: form-data; name=\"file\"; filename=\"image.png\"\r\nContent-Type: image/png\r\n\r\n";
	    string formData = string.Format(formDataTemplate, boundary);
	    byte[] formDataBytes = Encoding.UTF8.GetBytes(formData);
	    // 设置请求体长度
	    request.ContentLength = formDataBytes.Length + result.Length + boundaryBytes.Length;
	    // 将请求体数据写入请求流中
	    using (Stream requestStream = request.GetRequestStream())
	    {
	        requestStream.Write(formDataBytes, 0, formDataBytes.Length);
	        requestStream.Write(result, 0, result.Length);
	        requestStream.Write(boundaryBytes, 0, boundaryBytes.Length);
	    }
	    // 发送请求并获取响应
	    HttpWebResponse response = (HttpWebResponse)request.GetResponse();
	    // 处理响应
	    string responseContent;
	    using (StreamReader reader = new StreamReader(response.GetResponseStream()))
	    {
	        responseContent = reader.ReadToEnd();
	        // Console.WriteLine(responseContent);
	    }
	    response.Close();
	    var resultData = ((JObject)JsonConvert.DeserializeObject(responseContent));
	    var data = resultData["res"];
	    var region = data["latex"];
	    var text = "$" +region.ToString() + "$";
	    TxtFormat.Root jsonRoot=new TxtFormat.Root ();
	    jsonRoot.result=new List<TxtFormat.TextBlock>();
	    jsonRoot.isHasLocation=true;// 判断是否含有坐标返回
	    TxtFormat.TextBlock textBlock = new TxtFormat.TextBlock ();
	    textBlock.Text = text;//json 内的文本
	    textBlock.TopLeft = new Point (0,0);// 左上角坐标
	    textBlock.TopRight = new Point (0,0);// 右上角坐标
	    textBlock.BottomRight =new Point (0,0);// 右下角坐标
	    textBlock.BottomLeft =new Point (0,0);// 左下角坐标
	    jsonRoot.result.Add (textBlock);
        // `SerializeObject(object value)`：将对象序列化为 **JSON 字符串**。
	    return JsonConvert.SerializeObject (jsonRoot);
	}
	

```









#### 记录一下用的接口

| 服务                               | 免费额度                               | 超出免费额度              | 并发请求数 |
| ---------------------------------- | -------------------------------------- | ------------------------- | ---------- |
| **百度**通用文字识别               | 每月1000次（实名认证后）               | 0.0050元/次（开通付费后） |            |
| 通用文字识别（高精度版）           | 每月1000次（实名认证后）               | 0.028元/次（开通付费后）  |            |
|                                    |                                        |                           |            |
| 彩云小译API(在用)                  | 每月100万字符                          | 20元/100万字符            | 无相关说明 |
| **百度**通用翻译API（标准版）      | 完全免费                               |                           | 1次/秒     |
| **百度**通用翻译API（高级版）      | 每月200万字符                          | 49元/100万字符            | 10次/秒    |
|                                    |                                        |                           |            |
| **百度**教育场景文字识别           | 每月500次（有效期365天, 后续资源付费） | 1500元/万次（开通付费后） |            |
| **腾讯**数学试题识别()已经**废弃** | 每月1000次                             | 120元/1000次              |            |

