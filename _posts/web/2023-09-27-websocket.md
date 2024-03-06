---
layout: blog
category: web
title:  
date:   2023-09-27 09:53:31
background-image: http://ot1cc1u9t.bkt.clouddn.com/17-8-1/24280498.jpg
tags:
- web
- protocol
---

* content
{:toc}




#### websocket 协议

- WebSocket 是一种用于在 Web 浏览器和服务器之间进行**双向通信**的协议。它提供了实时性、高效性和可靠性，使得服务器可以主动推送数据给客户端，客户端也可以向服务器发送数据，实现了全双工通信。
- 当我们使用 `HTTP`协议时, 因为 http使用了 cs架构, 因此, 我们没有办法让服务器主动向客户推送消息, 如果我们想要主动推送消息, 只能通过更低层次 `tcp` 来进行双向的通信





特点

- 双向通信
- 建立在` TCP 协议`之上，服务器端的实现比较容易。
- 与 `HTTP 协议`有着良好的兼容性。默认端口**也是** 80 和 443，并且`握手阶段`采用 HTTP 协议，因此握手时不容易屏蔽，`能通过各种 HTTP 代理服务器`。
