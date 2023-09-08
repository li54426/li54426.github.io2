---
layout: blog
banana: true
category: byte_tech
title:  "Go_"
date:   2023-08-17 09:59:12
background: green
tags:
- byte_tech
- go
---

* content
{:toc}






#### 携程

Go 语言中的 goroutine 就是这样一种机制，goroutine 的概念类似于线程，但 goroutine 是由 Go 的运行时（runtime）调度和管理的。Go 程序会智能地将 goroutine 中的任务合理地分配给每个 CPU。Go 语言之所以被称为现代化的编程语言，就是因为它在语言层面已经内置了调度和上下文切换的机制。

在 Go 语言编程中你不需要去自己写进程、线程、协程，你的技能包里只有一个技能–goroutine，当你需要让某个任务并发执行的时候，你只需要把这个任务包装成一个**函数**，开启一个 goroutine 去执行这个函数就可以了，就是这么简单粗暴。

协程:用户态,轻量级线程, 栈KB级别

线程:内核态,线程跑多个协程, 栈MB级别







```go
package main

import (
	"fmt"
	"time"
)

func main() {
	go hello() // 启动一个新的协程执行 hello() 函数

	// 主线程继续执行其他任务
	for i := 0; i < 5; i++ {
		fmt.Println("Main Thread:", i)
		time.Sleep(time.Second)
	}
}

func hello() {
	for i := 0; i < 5; i++ {
		fmt.Println("Hello Goroutine:", i)
		time.Sleep(time.Second)
	}
}

```



使用匿名函数启动协程

```go
package main

import (
    "fmt"
    "time"
)

func main() {
    // 定义匿名函数，作为协程的运行函数
    go func() {
        fmt.Println("协程开始执行")
        time.Sleep(2 * time.Second) // 模拟一些耗时操作
        fmt.Println("协程执行完成")
    }()

    // 主线程继续执行其他任务
    fmt.Println("主线程执行其他任务")

    // 防止主线程退出，等待一些时间以便协程执行完毕
    time.Sleep(3 * time.Second)
}

```













CSP (Communicating Sequential Processes) 通信顺序进程，是 Go 语言中重要的并发模型。

主要特征有

1. **顺序**进程：每个进程内部按顺序执行。
2. 通信进程：进程间通过通信 (Message Passing) 来协作。
3. 数据流：程序通过在进程间传递数据来工作。

Go 语言的 CSP 实现主要通过 goroutine 和 channel

- goroutine 作为顺序执行的进程
- channel 用于 goroutine 间的通信





#### 通信 / channel

提倡通过**通信**共享内存而不是通过共享内存而实现通信

- 通过通信共享内存---通道
- 通过共享内存实现通信---临界区

```go
var ch1 chan int   // 声明一个传递整型的通道
var ch2 chan bool  // 声明一个传递布尔型的通道
var ch3 chan []int // 声明一个传递int切片的通道

// 通道是引用类型，通道类型的空值是 nil。
// 声明的通道后需要使用 make 函数初始化之后才能使用。
ch4 := make(chan int)
ch5 := make(chan bool)
ch6 := make(chan []int)

// 发送    将一个值发送到通道中。
ch <- 10 // 把10发送到ch中

// 接收----从一个通道中接收值。
x := <- ch // 从ch中接收值并赋值给变量x
<-ch       // 从ch中接收值，忽略结果

//  close 函数来关闭通道。关闭通道不是必须
close(ch)
```

```go
func main() {
    ch1 := make(chan int)
    ch2 := make(chan int)
    // 开启goroutine将0~100的数发送到ch1中
    go func() {
        for i := 0; i < 100; i++ {
            ch1 <- i
        }
        close(ch1)
    }()
    // 开启goroutine从ch1中接收值，并将该值的平方发送到ch2中
    go func() {
        for {
            i, ok := <-ch1 // 通道关闭后再取值ok=false
            if !ok {
                break
            }
            ch2 <- i * i
        }
        close(ch2)
    }()
    // 在主goroutine中从ch2中接收值打印
    for i := range ch2 { // 通道关闭后会退出for range循环
        fmt.Println(i)
    }
}
```









#### 实例/ 生产者消费者模型

```go
package main

import "fmt"

func CalSquare() {
   src := make(chan int)     //   生产无缓冲
   dest := make(chan int, 3) //   消费缓冲3个元素
   
   // 子协程发送0-9数字
   go func() {
      defer close(src)
      for i := 0; i < 10; i++ {
         src <- i
      }
   }()

   // 子协程计算输入数字的平方
   go func() {
      defer close(dest)
      for i := range src {
         dest <- i * i
      }
   }()

   // 主协程输出最后的平方数
   for i := range dest {
      // 复杂操作
      // ...
      fmt.Println(i)
   }

}

func main() {
   CalSquare()
}

```







#### 互斥锁

- 互斥锁，确保同时只有一个 goroutine 可以**访问共享**数据。

```go
package main

import (
	"fmt"
	"sync"
	"time"
)

var (
	counter = 0
    // 保护临界区
	mutex   sync.Mutex
    // 保证所有的任务都能完成, 也就是主程序阻塞
	wg      sync.WaitGroup
)

func main() {
	wg.Add(2)

	go increment("Routine 1")
	go increment("Routine 2")

	wg.Wait()
	fmt.Println("Final counter:", counter)
}

func increment(name string) {
	defer wg.Done()

	for i := 0; i < 5; i++ {
		// 对公共资源进行加锁
		mutex.Lock()

		// 修改公共资源
		counter++
		fmt.Printf("[%s] Counter: %d\n", name, counter)

		// 解锁公共资源
		mutex.Unlock()

		// 模拟其他操作
		time.Sleep(time.Millisecond * 500)
	}
}

```







1. sync.RWMutex

读写互斥锁，可以同时允许多个读，但写时独占。读写互斥锁实现了读写分离，相比普通的互斥锁可以提供更高的并发性能。

```go
var mu sync.RWMutex

mu.RLock()
// 读共享资源
mu.RUnlock()

mu.Lock()
// 写共享资源
mu.Unlock()

```



sync.WaitGroup 是 Go 语言中的一个常用同步工具，可以用于等待一组 goroutine 结束。主要的使用方式是

- 创建一个 WaitGroup, 通常以参数传入函数
- 在启动 goroutine 前调用 Add 添加计数
- 在 goroutine 结束时调用 Done 减少计数
- 等待 goroutine 结束，调用 Wait 阻塞

```go
package main

import (
   "fmt"
   "sync"
)

func process(i int, wg *sync.WaitGroup) {
   fmt.Println("Start goroutine", i)
    // 结束时调用 Done 减少计数
   defer wg.Done()
   fmt.Printf("End goroutine%d\n", i)
}

func main() {

   var wg sync.WaitGroup

   for i := 1; i <= 3; i++ {
      wg.Add(1)
      go process(i, &wg)
   }

   wg.Wait()
   fmt.Println("All goroutines finished executing")
}

```

