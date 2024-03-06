---
layout: blog
banana: true
category: byte_tech
title:  "Go_"
date:   2023-08-11 10:11:14
background: green
tags:
- byte_tech
- go
---

* content
{:toc}






#### 四个场景,如何解决?

- 系统奔溃-------消息队列, 解耦
- 服务处理能力有限------削峰, 消息队列
- 链路耗时长尾-------异步, 消息队列
- 日志如何处理------





#### 常见的消息队列

- Kafka:分布式的、分区的、多副本的日志提交服务,在高吞吐场景下发挥较为出色
- RocketMQ:低延迟、强一致、高性能、高可靠、万亿级容量和灵活的可扩展性,在一些**实时**场景中运用较广
- Pulsar:是下一代云原生分布式消息流平台,集消息、存储、轻量化函数式计算为一体、采用存算分离的架构设计
- BMQ:和Pulsar架构类似, 存算分离, 初期定位是承接高吞吐的离线业务场景, 逐步替换掉对应的Kafka集群





#### 使用 kafka流程

- 创建集群
- 新增Topic
- 编写生产者逻辑
- 编写消费者逻辑



#### 基本概念

- Topic:逻辑队列, 不同Topic可以建立不同的Topic 
- 每个 topic 内部有 很多 `partition`, 可以并行处理
- Cluster: 物理集群,每个集群中可以建立多个不同的Topic 
- Producer:生产者,负责将业务消息发送到Topic中
- Consumer:消费者,负责消费Topic中的消息
- ConsumerGroup:消费者组,不同组Consumer消费进度**互不干涉**







leader 是 负责存储生产者的产品供消费者使用

follwer 努力保证 leader一样



从一条消息的视角,看看为什么Kafka能支撑这么高的吞吐?

- 批量发送可以减少O次数, 从而加强发送能力
- 通过压缩,减少消息大小,目前支持Snappy、Gzip、LZ4、ZSTD压缩算法
- 采用顺序写的方式进行写入,以提高写入效率 
