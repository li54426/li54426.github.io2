---
layout: blog
category: lib_linux
title:  
date:   2023-08-02 22:26:13
tags:
- lib_linux
---

* content
{:toc}


### 写在开头

“**如无必要，勿增实体**”---------威廉

这就是著名的奥卡姆剃刀原则, 他说的是, 小就是美, 今天在写处理`http`的网络库时, 深有感触

http协议位于传输层上方, 但是不一定是最高的层次, 他就像操作系统对于硬件和用户的关系一样, 既要支持用户直接用, 也要支持作为协议的一层

从支持用户直接使用的角度来看, 报文的请求行, 请求头, 请求体要一块进行处理, 但是从协议的一层来看, 请求体要向上传递, 交给另一个协议进行处理, 设计时, 要让 `body`部分不处理, 这就带来了一个问题, 如何区分`headers`和`body`, 因为headers可以有很多行, 协议的设计人员使用一个**空行**来进行分隔, 既要用少的规则来区分不同的属性, 又要尽可能的简单





### 1 HttpRequest

- 存储了连接的**状态**, `URL`以及 `headers`

```c++
class HttpRequest{
public:
    using HttpMap= map<string, string> ;

    enum Method{
        kInvalid, kGet, kPost, kHead, kPut, kDelete
    };

    enum Version{
        kUnkown, kHttp10 , kHttp11
    };
private:
    Method method_;
    Version version_;    

    std::string path_;
    std::string query_;
    Timestamp receiveTime_;
    std::map<string, string> headers_;

};
```







### 2 HttpContext

#### 2.1 主要的功能: 

- 处理 `http`报文, 将报文解析出来, 传入成员`HttpRequest`中

```c++
class HttpContext{
public:
    enum HttpRequestParseState{
        kExpectRequestLine, // 期望解析请求行
        kExpectHeaders, // 期望解析请求头部
        kExpectBody, // 期望解析请求体
        kGotAll, // 已经解析完整请求
    };
    bool parseRequCest(Buffer* buf, Timestamp receivetime);
private:
    HttpRequestParseState state_;
    HttpRequest request_;

};

```



#### 2.2 http报文格式

- 请求行 / 状态行
    - 方法名
    - URL
    - 协议版本
- **请求头** / 响应头
- 请求体 / 响应体

```bash
POST /index.html HTTP/1.1 #(回车换行)
Who: Alex                 #(回车换行)
Content-Type: text/plain 
Host: 127.0.0.1:8888
Content-Length: 28
Cookie: JSESSIONID=24DF2688E37EE4F66D9669D2542AC17B #(回车换行)
#(回车换行)
Let's watch a movie together



# 响应报文
HTTP/1.1 200 OK 
Server: Apache-Coyote/1.1
Content-Type: application/json 
Transfer-Encoding: chunked 
Date: Mon, 12 Sep 2011 12: 41: 24 GMT
6f
{"password":"1234","userName":"tom","birthday":null,"salary":0,
"realName": "tomson","userId": "1000","dept":null}
0
```

其中, 状态行和首部中的每行都是以**回车符** (\r，%0d，CR) 和**换行符** (\n，%0a，LF) 结束, `headers`和`body`中间有一个空行

因此我们也要分为三部分处理, 首先处理请求行, 再处理 `header`, 最后再处理 请求体



#### 2.3 核心函数`bool parseRequCest(Buffer* buf, Timestamp receivetime);`

- 功能: 从buffer中将报文解析出来

```c++
bool HttpContext::parseRequCest(Buffer *buf, Timestamp receivetime)
{
    bool ok = true;
    bool has_more = true;
    while(has_more){
        if(state_ ==kExpectRequestLine){
            // 找到第一行结束的位置
            const char *crlf = buf->findCRLF();

            if(crlf){
                // 处理 请求行
                ok = processRequestLine(buf-> Peek(), crlf);

                if(ok){
                    // 设置时间戳
                    request_.setReceiveTime(receivetime);
                    buf-> Retrieve(crlf + 2 - buf-> Peek());
                    // 处理完请求行, 处理 headers
                    state_ = kExpectHeaders;
                }
                else{// !ok
                    // 遇到错误, 处理失败
                    has_more = false;
                }
            }
            else{// ! crlf
                // 没有找到 crlf, 非法报文
                has_more = false;
            }
        }

        // 处理 头部, 本身没有循环, 通过外部循环来**逐行** 处理
        else if (state_ == kExpectHeaders){// state_ != kExpectRequestLine
            const char* crlf = buf->findCRLF();

            if(crlf){
                const char * colon = std::find(buf-> Peek(), crlf, ':');
                if(colon != crlf){
                    ++colon;
                    while(*colon == ' '){
                        colon++;
                    }
                    request_.addHeader(string(buf-> Peek(), colon), string(colon, crlf));
                }
                // 有一个空行, 头部处理完毕
                else{
                    state_ = kGotAll;
                    has_more = false;
                }
                buf-> Retrieve(crlf + 2 - buf-> Peek());
            }
            // 没找到回车换行, 非法报文
            else{
                has_more = false;
            }
        }

        // body 部分依旧留在 buf中, 
        // 空语句, 在这里不处理, 只是为了逻辑上更顺畅
        else if (state_ == kExpectBody){

        }

    }
    return ok;
}

```





#### 2.4处理请求行

- 每个值中间都用空格`方法(空格)URL(空格)版本CRLF`

```c++
bool HttpContext::processRequestLine(const char *begin, const char *end)
{
    // 传进来的数据就是一行, 不用找 crlf
    // 以空格为准
    bool succeed = false;
    const char * start = begin;
    const char * space = std::find(start, end, ' ');

    // 设置方法名
    if(space != end && request_.setMethod(string(start, space))){
        start = space +1;

        // 继续查找下一个空格
        space = std::find(start, end, ' ');
        if(space != end){
            const char * question = std::find(start, space, '?');
            if(question != space){
                request_.setPath(string(start, question));
                request_.setQuery(string(question, space));
            }
            else{
                request_.setPath(string(start, space));
            }

            start = space+1;
            succeed = end - start == 8 && std::equal(start, end-1, "HTTP/1.");

            if(succeed ){
                if(*(end-1) == '1'){
                    request_.setVersion(HttpRequest::kHttp11);
                }
                if(*(end-1) == '0'){
                    request_.setVersion(HttpRequest::kHttp10);
                }
                else{
                    succeed = false;
                }
            }

        }// space != end
    
        
    }// set method
    return succeed;
}
```





### httpResponse

```c++
class HttpResponse{
public:
      enum HttpStatusCode
    {
        kUnknown,
        k200Ok = 200,
        k301MovedPermanently = 301,
        k400BadRequest = 400,
        k404NotFound = 404,
    };

    explicit HttpResponse(bool close)
        : status_code_(kUnknown),
        close_connection_(close)
    {
    }

        void setStatusCode(HttpStatusCode code)
    { status_code_ = code; }

    void setStatusMessage(const string& message)
    { status_message_ = message; }

    void setCloseConnection(bool on)
    { close_connection_ = on; }

    bool closeConnection() const
    { return close_connection_; }

    void setContentType(const string& contentType)
    { addHeader("Content-Type", contentType); }

    // FIXME: replace string with StringPiece
    void addHeader(const string& key, const string& value)
    { headers_[key] = value; }

    void setBody(const string& body)
    { body_ = body; }

    void appendToBuffer(Buffer* output) const;

private:
    HttpStatusCode status_code_;
    string body_;
    string status_message_;
    bool close_connection_;
    std::map<string, string> headers_;
};

```

