---
layout: blog
banana: true
category: byte_tech
title:  "Go_quick_book"
date:   2023-08-23 20:26:16
background: green
tags:
- byte_tech
- go
---

* content
{:toc}




### 1 变量

- **函数外**的每个语句都**必须**以关键字开始（var、const、func等）
- `:=`不能使用在函数外。
-  _多用于占位，表示忽略值。
- 

Go 语言是一种静态类型的编程语言，它提供了以下基本类型：Go 语言要求标识符以**一个字母或下划线**开头，后面可以跟任意数量的字母、数字、下划线。不能使用关键字作为标识符

- 布尔类型：bool
- 数字类型：int, int8, int16, int32, int64, uint, uint8, uint16, uint32, uint64, float32, float64, complex64, complex128
- 字符串类型：string
- 字符类型：rune (用于表示 Unicode 字符)
- 错误类型：error
- 指针类型：*T (T 为任意类型)
- 数组类型：[n] T (n 为数组长度，T 为元素类型)
- 切片类型：[] T (T 为元素类型)
- **字典**类型：map [K] V (K 为键类型，V 为值类型)
- 结构体类型：struct
- 接口类型：interface
- 函数类型：func
- 通道类型：chan T (T 为元素类型)



#### 1.1 基础类型

- 类型**不需要导入**
- 可以使用 `const`修饰
- **短变量声明**是一种简洁的变量声明方式，用于**同时声明和初始化**变量。但是这种方式**只能在函数内部使用**，不能在函数外部使用。当在函数外部声明变量时，只能使用 `var`

```go
var b, c int = 1, 2
var e float64

// 短变量声明
f := a

// 同时声明多个变量
var i, j, k = 2, false, "asd"

// 数组
var a [5]int
b := [5]int{1, 2, 3, 4, 5}

// 多维数组
var twoD [2][3]int
```





#### 1.2 常量

- 常量的声明方式和变量差不多，区别在于常量需要用 `const` 关键字修饰，不能使用`:=` 进行声明。

```go
const num int = 555
```







#### 1.3 string

- `string` 类型用于表示文本字符串。它是一种**不可变**的序列，由多个 Unicode 字符组成，并使用**双引号** `"` 或**反引号** ` ` ` 包围。
- 由于字符串是**不可变**的，如果需要对大量的字符串进行拼接操作，最好使用 `bytes.Buffer` 或 `strings.Builder` 类型，以提高性能和效率。
- Go 语言中要定义一个多行字符串时，就**必须**使用**反引号**字符

```go
s1:= `第一行
第二行
第三行`
fmt.Println(s1)
```





| 方法                                 |                |
| ------------------------------------ | -------------- |
| len(str)                             | 求长度         |
| +或ft.Sprintf                        | 拼接字符串     |
| strings.Split                        | 分割           |
| strings.contains                     | 判断是否包含   |
| strings.HasPrefix, strings.HasSuffix | 前缀/后缀判断  |
| strings.Inde(), strings.LastIndex0   | 子串出现的位置 |
| strings.Join(a[]string,sepstring)    | join妈         |



string包和 strings包有什么区别和联系

`strings` 包是 Go 语言的标准库，它提供了一些与字符串相关的函数和方法，例如字符串拼接、替换、切片等。

`string` 包是 Go 语言的基础数据类型，它表示一个固定长度的字符序列。与其他语言中的字符串不同，Go 语言中的字符串是不可变的，一旦被创建，就不能修改。





#### 1.4 字符

组成每个字符串的元素叫做 “字符”，可以通过遍历或者单个获取字符串元素获得字符。 字符用**单引号** (’) 包裹起来

Go 语言的字符有以下两种：

1. `uint8` 类型，或者叫 byte 型，代表了 ASCII 码的一个字符。
2. `rune` 类型，代表一个 UTF-8 字符。



```go
a :='中'
b :='x'
```

要修改字符串，需要先将其转换成 [] rune 或 [] byte，完成后再转换为 string。无论哪种转换，都会重新分配内存，并复制字节数组。

```go

func changestring(){
    s1 := "big"
    // 强制类型转换
    bytes1 := []byte(s1)
    bytes1[0]='p fmt.Println(string(bytes1))
    s2:="白萝卜"
    runes2:=[]rune(s2)
    runes2[0]='红fmt. Println(string(runes2))
}
```



#### 1.5 数值类型

整数类型分为：

- 有符号数：`int`、`int8`、`int16`、`int32 (rune)`、`int64`
- 无符号数：`uint`、`uint8 (byte)`、`uint16`、`uint32`、`uint64`、
- 其中，`uint8 `就是我们熟知的 byte 型，int16 对应 C 语言中的 short 型，int64 对应 C 语言中的 long 型。

| 类型   | 描述                                             |
| ------ | ------------------------------------------------ |
| uint8  | 无符号8位整型(o到255)                            |
| uint16 | 无符号16位整型(o到65535)                         |
| uint32 | 无符号32位整型(o到4294967295)                    |
| uint64 | 无符号64位整型(o到18446744073709551615)          |
| int8   | 有符号8位整型(-128到127)                         |
| inti6  | 有符号16位整型(-32768到32767)                    |
| int32  | 有符号32位整型(-2147483648到2147483647)          |
| int64  | 有符号64位整型(-9223372036854775808到92233部@6谱 |



#### 1.6 类型转换

**使用表达式 `T(v)` 将变量 v 的值的类型转换为 T**。注意是转换的是 **变量的值**，变量本身的类型不变。

```go
c := int(52.6)

```



#### 1. 生命周期

Go 语言中没有像其他一些编程语言（如 C++、Java 等）中那样的块级作用域。也就是说，Go 语言中没有在大括号内定义的生命周期。

在 Go 语言中，变量的生命周期是由它们的作用域决定的。Go 语言中的作用域分为两种：文件作用域和函数作用域。在文件作用域中，变量的生命周期从文件开始到文件结束。在函数作用域中，变量的生命周期从函数开始到函数结束。

因此，如果您想在一个大括号内定义一个变量的生命周期，您需要使用嵌套的函数或者其他的代码结构来实现。例如，您可以使用一个内部函数来定义一个变量的生命周期，并在外部函数中调用它。

总的来说，虽然 Go 语言中没有块级作用域，但它提供了其他的方法来控制变量的生命周期，并且这些方法通常更加简单和直观。



### 2 高级变量

#### 引用类型

Go 语言中的引用类型是指一种**特殊**的变量类型，它存储的不是值本身，而是对值的一个引用。当您使用引用类型变量时，实际上是在**操作**它所引用的值。

Go 语言中有三种引用类型：

- 指针：指针是一种特殊的变量类型，它存储的是一个值的地址。通过指针，您可以操作它所指向的值。
- 切片：切片是一种引用类型，它存储的是一组值的引用。通过切片，您可以操作它所引用的一组值。
- 字典：字典是一种引用类型，它存储的是一组键值对的引用。通过字典，您可以操作它所引用的一组键值对。

与值类型不同，引用类型变量存储的是对值的引用，而不是值本身。这意味着，如果您修改了引用类型变量所引用的值，那么其他引用该值的变量也会看到**修改**的效果。

**数组** array 类型是**值类型**，那么在使用相同的类型的变量初始化另一个变量时，两个变量**互不影响**







#### 数组

- 数组长度必须是常量，且是类型的组成部分。一旦定义，长度不能变。
- 访问越界，如果下标在数组合法范围之外，则触发访问越界，会panic
- 传递数组到函数中时，实际上是传递了数组的**副本**。因此，在函数中修改数组的值**不会影响**原数组的值。

```go
a := [3]int{1, 2}   // 未初始化元素值为 0。
b := [...]int{1, 2, 3, 4}   // 通过初始化值确定数组长度。


func printArr(arr *[5]int) {
    arr[0] = 10
    for i, v := range arr {
        fmt.Println(i, v)
    }
}

```

















#### 切片---可变的数组

- 声明切片和声明数组类似，但是**不指定长度**：
- `append, len, cap`是全局函数, 不是方法

```go
// 声明一个 int 类型, 名为 a的切片
// a == nil
var a []int

// b != nil, 以下两个形式等价
b := []int {}
var s1 []int = []int{}

// 可以在声明的时候直接初始化
var a = []int {1, 2, 3, 4}

// 短变量声明
a := []int {1, 2, 3, 4}


// 使用 make 函数可以在创建切片时指定长度和容量。
// 创建一个 //[0 0 0 0 0] len = 5 cap = 5
a := make([]int, 5)

// 从数组或者切片中 获取切片
// 前闭后开 [), 因此相减就是数组长度
a := [5]string {"a", "b", "c", "d", "e"} //数组
b := []int {1, 2, 3, 4} //切片
sliA := a[2:4]   //  [c d]
sliB := b[1:3]   //   [2 3]


// 获取长度
len (a)
// 获取容量
cap(s)


// 多维切片
ss := [][]int {
    []int {1, 2, 3}, //切片元素的类型可以省去
    []int {4, 5, 6},
    []int {7, 8, 9},
}


// 复制切片
// dst 是目标切片，src 是源切片，该函数会将 src 中的元素复制到 dst 中，并返回复制的元素个数（该返回值是两个切片长度中的小值）
func copy(dst []Type, src []Type) int

```





#### 切片的容量

前面提到：切片为我们提供了 “动态数组”。但该 “动态数组” 并不是真正意义上的能扩展长度的动态数组。

**切片并不存储任何数据，它只是一个引用类型，切片总是指向一个底层的数组，描述这个底层数组的一段。**

```go
package main

import "fmt"

func main() {
	array := [5]string {"aa", "bb", "cc", "dd", "ee"} //数组
	fmt.Println(array) //[aa bb cc dd ee]

	slice1 := array[0:2] //切片1
	slice2 := array[1:3] //切片2
	slice3 := array[2:5] //切片3

	fmt.Println(slice1) //[aa bb]
	fmt.Println(slice2) //[bb cc]
	fmt.Println(slice3) //[cc dd ee]

	slice1[0] = "xx" //修改切片1中的值
	slice2[1] = "yy" //修改切片2中的值
	slice3[2] = "zz" ////修改切片3中的值

	fmt.Println(array) //[xx bb yy dd zz]
	fmt.Println(slice1) //[xx bb]
	fmt.Println(slice2) //[bb yy]
	fmt.Println(slice3) //[yy dd zz]
}

```



#### 切片扩容过程

- 在 Go 语言中，当切片添加的元素数量超过了底层数组的容量时，切片会发生扩容，即系统会**创建**一个新的底层数组，并将原来的元素复制到新数组中。这是由于切片的底层数组具有自动扩容的特性。

- 具体来说，当切片的容量不足以容纳新添加的元素时，Go 语言会按照一定的策略（**通常是成倍增加容量**）重新分配底层数组，并将原来的元素复制到新的底层数组中。这意味着在添加元素过程中，可能会涉及内存的重新分配和数据的复制操作，因此可能会导致性能上的开销。

    需要注意的是，扩容过程不会改变原来切片的引用，而是返回一个新的切片，因此我们在使用切片时需要使用扩容后的新切片来接收扩容后的结果。

#### 初始切片

- 切片的零值是 `nil`，当声明一个切片，但不出初始化它，该切片便为 `nil` 切片。`nil` 切片的长度和容量为 0 且没有底层数组。

```go
func main() {
	var s []int
	fmt.Println(s, len(s), cap(s))
	if s == nil {
		fmt.Println("s切片是nil切片")
	}
}

```







#### map

- 无序的
- Go 语言中使用 for range 遍历 map。

```go
var mp = map[string]int {"数学":100, "语文":90, "Go":100}

// 可以先声明再使用，注意这样需要使用 make 函数初始化后才能使用：
var scores map[string]int
scores = make(map[string]int)


// 建议这样直接写 
m := make(map[string]int)

// 增加键值对
// 当 key 不存在时为增加，当 key 存在时为修改
scores["数学"] = 100 

// 删除键值对
delete(scores, "语文")

// 查找
// 如果查找的 key 不存在，则会返回 value 类型的 “零值”：
score, exist := scores["数学"] //使用两个返回值
fmt.Println(score, exist) //100 true

score1 := scores["语文"] //使用一个返回值
fmt.Println(score1) //90

score2, exist2 := scores["Java"] //查找不存在的key
fmt.Println(score2, exist2) //0 false


// 获取数量
keyNum := len(scores) //获取scores这个map中key的数量


// Go 语言中使用 for range 遍历 map。
for key, value := range scores {
    fmt.Println(key, value)
}

// 只想遍历 key
for k := range scoreMap {
    fmt.Println(k)
}

```



#### map 也是引用

`map` 也是引用类型，则意味着，如果有几个 `map` 同时指向一个底层 `map`，其中一个 `map` 改变某个键值对，那么其他的也会做出同样的改变（因为底层 `map` 变了）。

```go
package main

import "fmt"

func main() {
	map0 := make(map[string]string) //底层map0
	map0["name"] = "XingXiaoguan" //增加一个键值对

	//map1 map2 引用map0
	map1 := map0
	map2 := map0

	fmt.Println(map0["name"], map1["name"], map2["name"]) //都是XingXiaoguan

	map1["name"] = "XingRenGuanXue" //改变map1的name对应的值
	fmt.Println(map0["name"], map1["name"], map2["name"]) //全部变为XingRenGuanXue
}

```





#### 指针  和 new

- 和 `C`中的很像
- 区别于 C/C++ 中的指针，Go 语言中的指针**不能进行偏移和运算**，是安全指针。
- 当一个指针被定义后没有分配到任何变量时，它的值为 nil

```go
// p == nil
var p *int
var a int = 66 //a是值为66的int变量
p = &a //将a的地址赋给指针p
var b = *p //根据p中的值找到a，将其值赋给b
fmt.Println(b) //66

*p = 99 //根据p中的值找到a，改变a的值
fmt.Println(a) //99



```





- new 是一个内置的**函数**
- 并且创建后内存对应的值为**类型零值**

```go
func new(Type) *Type

p := new(dog)
fmt.Printf("%T\n", p) //*main.dog
fmt.Println(p) //&{ 0}
fmt.Println(*p) //{ 0}
```



####  make

- make 也是用于内存分配的，区别于 new，它只用于 slice、map 以及 chan 的内存创建，而且它返回的类型就是这三个类型本身，而不是他们的指针类型
- 是内置函数

```go
func make(t Type, size ...IntegerType) Type

var b map[string]int
b = make(map[string]int, 10)
```





#### 结构体

-  struct 在方法中传参时是值类型而非引用类型，所以当需要在方法内改变这个对象的字段值时，应该使用的是 struct 变量的指针，而非 struct 变量。

```go
type 结构体名字 struct {
    字段名1 类型1
    字段名2 类型2
    ...
}

type man struct {
    name string
    age int
}

var a human
a.name = "zhang san"
a.age = 14

// 直接赋值
// 按顺序赋值
a :={"zhagnsan", 14}
a := {age:3, name:"zhang san"}
```



#### 结构体指针

```go
d := dog{"哮地犬", 2}
p := &d //获取到d的地址
n := (*p).name
fmt.Println(n) //哮天犬
// 上面的方式比较麻烦, Go 语言提供了隐式间接引用：
n := p.name //这样也行
fmt.Println(n)

```





#### 结构体嵌套

- 一个结构体也可以作为另一个结构体的字段

```go
package main

import "fmt"

type score struct {
    English int
    Chinese int
}

type people struct {
    name   string
    age    int
    grades score
}

func main () {
    a := people {"zhangsan", 18, score {English: 90, Chinese: 95}}
    fmt.Println (a)            //{zhangsan 18 {90 95}}
    fmt.Println (a.grades.English) //90
    fmt.Println (a.grades.Chinese) //95
}

```



使用匿名字段, 它是指只提供类型，不写字段名：

```go
package main

import "fmt"

type score struct {
    English int
    Chinese int
}

type people struct {
    name   string
    age    int
    score
}

func main () {
    a := people {"zhangsan", 18, score {English: 90, Chinese: 95}}
    fmt.Println (a)            //{zhangsan 18 {90 95}}
    fmt.Println (a.English) //90
    fmt.Println (a.Chinese) //95

}

```



#### interface

- 为了保护你的 Go 语言职业生涯，请牢记接口（interface）是一种**类型**。

Go 语言中的接口（interface type）是一种抽象的数据类型，它定义了一组**方法签名**，但不具体实现这些方法。接口只定义了方法的外部行为，而不关心方法的内部实现。

在 Go 语言中，接口是通过关键字 `interface` 来定义的。一个接口定义了一组方法签名，这些方法签名**必须**在任何实现该接口的类型中实现。



```go
type 接口类型名 interface{
    方法名1( 参数列表1 ) 返回值列表1
    方法名2( 参数列表2 ) 返回值列表2
    …
}
```





例如，下面是一个简单的接口定义：

```go
type MyInterface interface {
    Method1()
    Method2()
}
```

这个接口定义了两个方法签名 `Method1` 和 `Method2`。任何实现这个接口的类型都必须实现这两个方法。

在 Go 语言中，接口是一种类型，可以像其他类型一样被使用。您可以定义变量、常量和数组等，它们的类型都是接口。

例如，下面是一个使用接口的示例：

```go
type MyImplementation struct {}

func (m MyImplementation) Method1() {
    // implementation of Method1
}

func (m MyImplementation) Method2() {
    // implementation of Method2
}

var myVar MyInterface = MyImplementation{}
```

在这个示例中，我们定义了一个类型 `MyImplementation`，它实现了接口 `MyInterface`。我们还定义了一个变量 `myVar`，它的类型是接口 `MyInterface`，并将其赋值为一个 `MyImplementation` 类型的值。

通过使用接口，我们可以将不同的类型统一起来，使它们能够以相同的方式进行交互。这有助于实现代码的模块化和可复用性。

总之，接口是 Go 语言中一种非常重要的类型，它们可以帮助您实现抽象和多态性，提高代码的灵活性和可复用性。



Go 语言中的接口类似于 C++ 中的**接口类**的概念。在 C++ 中，接口类是一个抽象基类，它定义了一组**纯虚函数**，这些函数需要在任何继承该接口类的类中实现。与 C++ 中的接口类类似，Go 语言中的接口也是一种抽象的数据类型，它定义了一组方法签名，但不具体实现这些方法。任何类型都可以实现一个或多个接口，从而使其具有接口定义的方法。

与 C++ 中的接口类不同的是，Go 语言中的接口不能继承，也不能包含数据成员。Go 语言中的接口更加简单和轻量级，它们只定义了方法签名，而没有任何其他的实现细节。这使得 Go 语言中的接口更加灵活和易于使用，同时也使得代码更加简洁和易于维护。







### 流程控制--- 没有括号   与 下划线

#### if

```go
if {   // 必须和 if 在同一行
    
}else{// else 必须在 { 后面
}
    
}
```

if 还有一种特殊的写法，可以在 if 表达式之前添加一个**执行语句**，再根据变量值进行判断，代码如下：

```go
if err := Connect(); err != nil {  
	fmt.Println(err)
    return
}
```

登录后复制

#### for

```go
for 初始化语句; 条件表达式; 后置语句 {
    //循环体代码
}

```

`for` 循环的另一种形式，在某种数据类型的**区间**（range）上遍历，如字符串或切片。

```go
func main() {
    s, sep := "", ""
    for _, arg := range os.Args[1:] {
        s += sep + arg
        sep = " "
    }
    fmt.Println(s)
}
```





#### switch

```go
switch 变量 {
    case 选项1 :
    	//操作1代码
    case 选项2 :
    	//操作2代码
    case 选项3 :
    	//操作3代码
    case 选项n:
    	//操作n代码
	default :
    	//默认操作
}

```







#### 下划线

- **import 下划线**（如：`import _ hello/imp`）的作用：当导入一个包时，该包下的文件里所有 init () 函数都会被执行，然而，有些时候我们并不需要把整个包都导入进来，仅仅是是希望它执行 init () 函数而已。这个时候就可以使用 import引用该包。即使用【import _ 包路径】只是引用该包，仅仅是为了调用 init () 函数，所以无法通过包名来调用包中的其他函数。 
- 代码中: 忽略这个变量.













### 函数和方法

#### 函数

- 类型在变量名后
- 如果你有多个**参数**的类型相同，你可以进行简写，只需要在这几个相同的参数**最后写一遍**类型即可。
- 函数可以有 **0 个或多个返回值**。和参数不同，有几个返回值就写几个返回值类型，不能简写。

```go
package main

import "fmt"

func add(x int, y int) int {
	return x + y
}

func main() {
	fmt.Println(add(1, 2))
}

```



通过给返回值进行**命名**，使用空 `return` 语句，这样会直接返回已命名的返回值。

```go
func sumAndDiff(x, y int) (sum int, diff int) {//提前命名返回值
	sum = x + y
	diff = x - y //返回值在函数中被初始化
	return //返回值已经初始化了，不需要再在return语句中写变量了
}
```



#### 导出

- 在 Go 语言中，如果一个名字以大写字母开头，那么它就是已导出的，这意味着别的包可以使用它。（相当于 Java 中的 `public` 的作用）
- 比如我们常用的打印函数 `fmt.Println(...)`，可以看到 `Println()` 的首字母是大写的，所以我们能够导入 `fmt` 包后使用该方法。





#### 函数重载

Go 语言支持函数重载，但是它的方式与其他语言有所不同。

在 Go 语言中，函数重载是通过不同的函数签名来实现的。函数签名是指函数的名称、参数类型和顺序。如果两个函数具有不同的函数签名，那么它们就可以被认为是重载的函数。

例如：

```go
func myFunction(a int) {
    // implementation here
}

func myFunction(a int, b string) {
    // implementation here
}
```

在这个例子中，`myFunction` 函数被重载了两次，一次只有一个整数参数，另一次有一个整数参数和一个字符串参数。

需要注意的是，Go 语言中函数的**返回类型**并不是函数签名的一部分，因此不能通过返回类型来实现函数重载。

总的来说，Go 语言的函数重载是通过函数签名来实现的，这与其他语言有所不同，但是它仍然是一种非常强大的功能，可以帮助我们更好地组织代码。















#### 方法

- Go 中也有类似于面向对象中方法的概念，也叫方法（`method`），这种方法其实是一种**特殊的函数**（`function`）—— 带有接收者（`receiver`）的函数。
- 通过`.` 可以调用方法
- 通过交换`函数名`以及 `函数参数`来区分函数以及方法
- 有点类似于传入指针

```go
package main

import "fmt"

type dog struct {
	name string
}

func (d dog) say() {//方法
	fmt.Println(d.name + " 汪汪汪。。。方法")
}

func main() {
	d := dog{"哮天犬"}
	d.watchDoor()
}


```



可以实现一种多态性

- 相同的方法名, 但是不同的对象(结构体)调用

```go
package main

import "fmt"

type dog struct {
	name string
}

type cat struct {
	name string
}

type rabbit struct {
	name string
}

// 使用 函数来实现, 需要不同的函数名
func dogSay(d dog) {
	fmt.Println(d.name + " 汪汪汪。。。函数")
}

func catSay(c cat)  {
	fmt.Println(c.name + " 喵喵喵。。。函数")
}

func (d dog) say() {
	fmt.Println(d.name + " 汪汪汪。。。方法")
}

// 使用方法来实现, 相同的函数名就可以
func (c cat) say()  {
	fmt.Println(c.name + " 喵喵喵。。。方法")
}

func (r rabbit) say() {
	fmt.Println(r.name + " 吱吱吱。。。方法")
}

func main() {
	d := dog{"哮天犬"}
	c := cat{"加菲猫"}
	r := rabbit{"玉兔"}

	d.say() //调用
	c.say()
	r.say()
}

```



#### 指针和方法

- 接收者使用指针传的是引用，不使用指针传的是值拷贝。

- 如果**函数**的参数是一个指针参数，那么该函数就必须接收一个指针才行，如果是值则报错：如果函数的参数是**值**，而不是指针，那么该函数必须接受值，否则会报错：

- 而如果**方法**的接收者是一个**指针**，那么该方法被调用时，接收者既可以是**指针**，又可以是**值**：如果方法的接收者是一个**值**，那么该方法被调用时，接收者既可以是值，又可以是指针：

- 

    

```go
package main

import "fmt"

type dog struct {
	name string
}

// 修改成功
func (d *dog) rename(name string) {
	d.name = name
	fmt.Println("方法内:" + d.name)
}

// 修改不成功
func (d dog) rename1(name string)  {
	d.name = name
	fmt.Println("方法内:" + d.name)
}

```



```go
// 必须是 double(&i)
func double(x *int) {
	*x = *x * 2
}

// d.rename("小黑黑")
func (d *dog) rename(name string) {
	d.name = name
	fmt.Println("方法内:" + d.name)
}

d := dog{"哮天犬"}
p := &d
p.rename1("小红红") 	
func (d dog) rename1(name string)  {
	d.name = name
	fmt.Println("方法内:" + d.name)
}
```





#### 类型选择

- `x.(type)` 的语法只能在 `switch` 语句内部使用，用于判断 `x` 的类型。它会返回一个特殊的类型 `type`，表示 `x` 的实际类型。

```go
switch value := x.(type) {
    case string:
    	fmt.Printf("%s是个字符串。开心", value)
    case int:
   		value *= 2
   		fmt.Printf("翻倍了，%d是个整数。哈哈", value)
    case human:
    	fmt.Println("这是个结构体。", value)
    default:
    	fmt.Printf("前面的case都没猜对，x是%T类型", value)
		fmt.Println("x的值为", value)
}
```





### 错误处理

#### panic

panic 语句用于引发一个运行时错误，并使程序崩溃。在 Golang 中，panic 语句的语法如下：

```go
go
复制代码panic("error message")
```

其中，"error message" 是一个字符串，用于描述错误信息。当程序执行到 panic 语句时，会引发一个 panic 错误，并将程序崩溃。





#### recover

recover 语句用于恢复程序的执行，如果程序发生了 panic 错误，可以使用 recover 语句来捕获该错误，并进行相应的处理。在 Golang 中，recover 语句的语法如下：

recover 语句用于恢复程序的执行，如果程序发生了 panic 错误，可以使用 recover 语句来捕获该错误，并进行相应的处理。在 Golang 中，recover 语句的语法如下：

```go
go复制代码package main

import "fmt"

func main() {
    defer func() {
        if err := recover(); err != nil {
            fmt.Println("recover error:", err)
        }
    }()
    panic("panic error")
}
```

输出结果为：

```go
go
复制代码recover error: panic error
```

在上面的示例中，使用 defer 语句来定义一个匿名函数，用来捕获 panic 错误，并输出错误信息。





#### error 接口

接口签名, 只有一个 **Error**() 方法，返回一个 **string**，用来备注错误信息。任何实现了这个方法的结构体都实现了 **error** 接口。

```go
type error interface {
    Error() string
}

```



实例分析

```go
// Go1.12/src/net/net.go 的 AddrError
type AddrError struct {
    Err  string
    Addr string
}

//使用 **指针** 接收器实现该Error()接口
func (e *AddrError) Error() string {
    if e == nil {
    	return "<nil>"
    }
    s := e.Err
    if e.Addr != "" {
    	s = "address " + e.Addr + ": " + s
    }
    return s
}

```



在 Go 里面，使用指针实现接口有两个主要用途：

1. 为了在实现该函数处可以修改指针调用者
2. 大结构使用指针可以减小拷贝，另外可以保证共享，维持全局一个类型，类似于单例。





### 多线程

#### defer

- 用于注册延迟调用
- 直到return前才会被执行, 可以用来做资源管理
- 多个 `defer`语句, 先进后出的方式( 栈 )执行
- defer 后面的语句在执行的时候，函数调用的参数会被保存起来，但是不执行。



```go
func main() {
    var whatever [5]struct{}

    for i := range whatever {
        defer fmt.Println(i)  // 4  3  2  1   0
    }
    
}

```

```go
type Test struct {
    name string
}

func (t *Test) Close() {
    fmt.Println(t.name, " closed")
}
func main() {
    ts := []Test{{"a"}, {"b"}, {"c"}}
    for _, t := range ts {
        defer t.Close()
    }
}

//    c  closed
//    c  closed
//    c  closed
```





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











### 面向"对象"

> **尽管 Go 拥有类型和方法，也允许面向对象风格的编程，但它没有类型层级**。 在 Go 中 “接口” 的概念提供了不同的方法，我们相信它易于使用且在某些方面更通用。 也有一些在其它类型中嵌入类型的方法，来提供类似（而非完全相同）的东西进行子类化。 此外，Go 中的方法比 C++ 或 Java 中的更通用：它们可被定义为任何种类的数据。 甚至是像普通的 “未装箱” 整数这样的内建类型。它们并不受结构（类）的限制。
>
> 此外，**类型层级的缺失也使 Go 中的 “对象” 感觉起来比 C++ 或 Java 的更轻量级**。



#### "继承"成员---匿名字段

```go
package main

import "fmt"

type people struct {
	name string
	age int
}

type student struct {
	people
	school string
}

func (s student) say() {
	fmt.Printf("我是%s，今年%d岁了，在%s上学。", s.name, s.age, s.school)
}

func main() {
	stu := student{people{"行小观", 1}, "阳光小学"}
	stu.say()
}

```



出现了字段冲突，Go 会先访问外层的字段。比如，`stu.name` 是`李向前`（外层），`stu.people.name` 是`李二狗`（内层）。

```go
package main

import "fmt"

type people struct {
	name string //人名
	age int
}

type student struct {
	people
	name string //学生名
	school string
}

func main() {
	stu := student{people{"李二狗", 1}, "李向前", "阳光学校"}
	fmt.Println(stu.name) //李向前
	fmt.Println(stu.people.name) //李二狗
}

```





#### "继承"方法

```go
package main

import "fmt"

// 定义父类
type Parent struct {
	name string
	age  int
}

// 父类的方法
func (p *Parent) SayHello() {
	fmt.Printf("Hello, I'm %s. ", p.name)
	fmt.Printf("I'm %d years old.\n", p.age)
}

// 定义子类
type Child struct {
	Parent // 组合父类
	school string
}

// 子类的方法
func (c *Child) SayHello() {
	// 调用父类的方法
	c.Parent.SayHello()
	fmt.Printf("I study at %s school.\n", c.school)
}

func main() {
	p := &Parent{
		name: "John",
		age:  35,
	}
	p.SayHello()

	c := &Child{
		Parent: Parent{
			name: "Tom",
			age:  8,
		},
		school: "ABC",
	}
	c.SayHello()
}


Hello, I'm John. I'm 35 years old.
Hello, I'm Tom. I'm 8 years old.
I study at ABC school.

```



#### 重写 字段

```go
package main

import "fmt"

type people struct {
	name string //乳名
	age int
}

type student struct {
	people
	name string //大名
	school string
}

func (s student) say() {
	fmt.Printf("我是%s，今年%d岁了，和我一起学习Go语言吧！\n", s.name, s.age)
}

func main() {
	stu := student{people{"李二狗", 1}, "李向前","阳光小学"}
	stu.say()
}

```



#### "重写"方法

```go
package main

import "fmt"

type people struct {
	name string
	age int
}

type student struct {
	people
	school string
}

type programmer struct {
	people
	language string
}

func (p people) say() { //people的say方法
	fmt.Printf("我是%s，今年%d岁了，和我一起学习Go语言吧！\n", p.name, p.age)
}

func (s student) say() { //student重写people的say方法
	fmt.Printf("我是%s，是个学生，今年%d岁了，我在%s上学！\n", s.name, s.age, s.school)
}

func (p programmer) say() { //programmer重写people的say方法
	fmt.Printf("我是%s，是个程序员，今年%d岁了，我使用%s语言！\n", p.name, p.age, p.language)
}

func main() {
	stu := student{people{"李向前", 1}, "阳光小学"}
	stu.say()
	prmger := programmer{people{"张三", 1}, "Go"}
	prmger.say()
}


我是李向前，是个学生，今年1岁了，我在阳光小学上学！
我是张三，是个程序员，今年1岁了，我使用Go语言！
```





### 接口

简单地来说，接口就是规范，如果你的类实现了接口，那么该类就必须具有接口所要求的一切功能、行为。接口中通常定义的都是方法。



#### 接口的声明

```go
type human interface { //定义human接口
	say()
	eat()
}

// 调用接口
h.say()
h.eat()

type adult interface { //定义adult接口
	say()
	eat()
	drink()
	work()
}

type teenager interface { //定义teenager接口
	say()
	eat()
	learn()
}

```





```go
package main

import "fmt"

type people struct {
	name string
	age int
}

type student struct {
	people //"继承"people
	subject string
	school string
}

type programmer struct {
	people //"继承"people
	language string
	company string
}

type human interface { //定义human接口
	say()
	eat()
}

type adult interface { //定义adult接口
	say()
	eat()
	drink()
	work()
}

type teenager interface { //定义teenager接口
	say()
	eat()
	learn()
}

func (p people) say() { //people实现say()方法
	fmt.Printf("我是%s，今年%d。\n", p.name, p.age)
}

func (p people) eat() { //people实现eat()方法
	fmt.Printf("我是%s，在吃饭。\n", p.name)
}

func (s student) learn() { //student实现learn()方法
	fmt.Printf("我在%s学习%s。\n", s.school, s.subject)
}

func (s student) eat() { //student重写eat()方法
	fmt.Printf("我是%s，在%s学校食堂吃饭。\n", s.name, s.school)
}

func (pr programmer) work() { //programmer实现work()方法
	fmt.Printf("我在%s用%s工作。\n", pr.company, pr.language)
}

func (pr programmer) drink() {//programmer实现drink()方法
	fmt.Printf("我是成年人了，能大口喝酒。\n")
}

func (pr programmer) eat() { //programmer重写eat()方法
	fmt.Printf("我是%s，在%s公司餐厅吃饭。\n", pr.name, pr.company)
}


func main() {
	xiaoguan := people{"行小观", 20}
	zhangsan := student{people{"张三", 20}, "数学", "银河大学"}
	lisi := programmer{people{"李四", 21},"Go", "火星有限公司"}

	var h human
	h = xiaoguan
	h.say()
	h.eat()
	fmt.Println("------------")
	var a adult
	a = lisi
	a.say()
	a.eat()
	a.work()
	fmt.Println("------------")
	var t teenager
	t = zhangsan
	t.say()
	t.eat()
	t.learn()
}

```



#### 接口值

- 是不是可以理解为, 有着共同`方法`的一组对象
- 接口也是值，这就意味着接口能像**值一样进行传递**，并可以作为函数的参数和返回值。
- 如果定义了一个接口类型变量，那么该变量中可以存储实现了该接口的任意类型值：
- 不能存储未实现该 `interface` 接口的类型值：

```go
func main() {
    //这三个人都实现了human接口
    xiaoguan := people{"行小观", 20}
	zhangsan := student{people{"张三", 20}, "数学", "银河大学"}
	lisi := programmer{people{"李四", 21},"Go", "火星有限公司"}
    
    var h human //定义human类型变量
    //所以h变量可以存这三个人
	h = xiaoguan
	h = zhangsan
    h = lisi
}


// 不可以
func main() {
    xiaoguan := people{"行小观", 20} //实现human接口
	zhangsan := student{people{"张三", 20}, "数学", "银河大学"} //实现teenager接口
	lisi := programmer{people{"李四", 21},"Go", "火星有限公司"} //实现adult接口
    
    var a adult //定义adult类型变量
    //但zhangsan没实现adult接口
    a = zhangsan //所以a不能存zhangsan，会报错
}
```





#### 空接口

```go
interface {}

a := people{"zhang san", 14}
var ept interface{}
ept = 10
ept = a
```



#### 接口做返回值

```go
package main

import "fmt"

type sayer interface {//接口
	say()
}

func foo(a sayer) { //函数的参数是接口值
	a.say()
}

type people struct { //结构体类型
	name string
	age int
}

func (p people) say() { //people实现了接口sayer
	fmt.Printf("我是%s，今年%d岁。", p.name, p.age)
}

type MyInt int //MyInt类型

func (m MyInt) say() { //MyInt实现了接口sayer
	fmt.Printf("我是%d。\n", m)
}

func main() {
	xiaoguan := people{"行小观", 20}
	foo(xiaoguan) //结构体类型作为参数
    
    i := MyInt(5)
	foo(i) //MyInt类型作为参数
}

```





#### "继承"接口

就是把一个接口当做**匿名字段**嵌入另一个接口中

- 它定义了两个结构体 `animal` 和 `dog`，`dog` 结构体使用匿名字段 `animal` 来实现继承。
- 接口 `runner` 和 `watcher` 定义了方法 `run()` 和 `watch()`，`watcher` 接口继承了 `runner` 接口。
- 然后，在 `main()` 函数中创建了一个 `animal` 类型的变量 `a` 和一个 `dog` 类型的变量 `d`。最后调用了 `a.run()`、`d.run()` 和 `d.watch()` 方法来输出结果。

```go
package main

import "fmt"

type animal struct { //结构体animal
	name string
	age int
}

type dog struct { //结构体dog
	animal //“继承”animal
	address string
}

type runner interface { //runner接口
	run()
}

type watcher interface { //watcher接口
	runner //“继承”runner接口
	watch()
}

func (a animal) run() { //animal实现runner接口
	fmt.Printf("%s会跑\n", a.name)
}

func (d dog) watch()  { //dog实现watcher接口
	fmt.Printf("%s在%s看门\n", d.name, d.address)
}

func main() {
	a := animal{"小动物", 12}
	d := dog{animal{"哮天犬", 13}, "天庭"}
	a.run()
	d.run() //哮天犬可以调用“继承”得到的接口中的方法
	d.watch()
}

```









### 依赖管理

go 依赖管理主要经历以下三个阶段：

- GOPATH
- GO VENDOR
- GO Module





#### gopath



`GOROOT` 和 `GOPATH` 是两个与 Go 语言开发环境相关的环境变量，它们有不同的作用和含义。

1. GOROOT（Go Root）：`GOROOT` 是指向你的 Go 安装目录的环境变量。它用于告诉 Go 编译器和工具在哪里找到 Go 的**标准库**和其他**系统**级别的包。当你安装 Go 时，会自动设置 `GOROOT` 环境变量。
2. GOPATH（Go Path）：`GOPATH` 是指向你的 Go 工作区的环境变量。它是你的**项目代码**和**第三方包**的存放路径。在 `GOPATH` 下，按照约定的目录结构，你可以创建 `src`、`pkg` 和 `bin` 三个目录。`src` 目录用于存放你的项目代码，`pkg` 目录用于存放编译后的包对象文件，`bin` 目录用于存放可执行文件。

联系：

- `GOPATH` 可以包含多个路径，用冒号（Unix/Linux）或分号（Windows）分隔，以指定多个工作区。
- 在 `GOPATH` 下的 `src` 目录中，你可以创建多个项目目录，每个目录对应一个独立的项目。
- 在项目目录中，你可以使用 `import` 语句引入其他项目或第三方包，Go 编译器会在 `GOPATH` 下的相应目录中查找这些包。

区别：

- `GOROOT` 是指向 Go 的安装目录，用于找到 Go 的标准库和系统级别的包。
- `GOPATH` 是指向你的工作区目录，用于存放你的项目代码和第三方包。



gopath 是 go 语言支持的一个环境变量，value 是 Go 项目的工作区。

```bash
cd $GOPATH
|---bin    项目编译的二进制文件
|---pkg   项目编译的中间产物加速编译
|---src  项目源码
```

- 项目代码直接依赖src下的代码
- `go get`下载最新版本的包到src 目录下

同一个 pkg，但是 pkg 有不同版本 pkg v1 和 pkg v2, 里面包含两个方法。而 src 下只能有一个版本存在，那 AB 项目无法保证都能编译通过。

就是在 gopath 管理模式下，如果多个项目依赖同一个库，则依赖该库是同一份代码，所以不同项目不能依赖同一个库的不同版本，这很显然不能满足我们的项目依赖需求。无法实现 package 的多版本控制。

为了解决这个问题，go vendor 出现了。









#### Go Vendor

- 项目目录下增加 vendor 文件, 所有依赖包**副本**形式放在`$ProjectRoot/vendor`
- 依赖寻址方式:vendor=>GOPATH



问题

- A依赖于 B C
- B C 依赖于 D不同的版本





#### go module

有了 Go module 之后，可以方便地管理项目的依赖关系，并且**不需要手动**下载库。使用 Go module，你可以在代码中引入需要的库，并通过指定版本或者版本范围来自动获取相应的库。当你首次引入一个新的库时，Go module 会自动下载该库及其依赖到本地的缓存中。这样，你就可以随意引入库，而无需手动下载。



依赖管理三要素

- 1.配置文件, 描述依赖go.mod
- 2.中心仓库管理依赖库 Proxy
- 3.本地工具 go get/mod



```go
module example/project/ap  // p依赖管理基本单元
go 1.16                    // 原生库
require (                  // 单元依赖
    example/lib1 v1.0.2
    example/lib2 v1.0.0 // indirect 
    example/lib3 v0.1.0-20190725025543-5a5fe074e612
   example/lib4 v0.0.0-20180306012644-bacd9c7ef1dd // indirect example/lib5/v3 v3.0.2 
)
```



依赖配置 - indirect 关键字

- A->B->C，A->B 属于**直接**依赖，A->C 属于**间接**依赖。
- 在 go.mod 中，对于没有直接导入该依赖模块的包，也就是非直接依赖，标识间接依赖。所以加上 indirect 后缀。



为什么需要 Proxy

直接使用版本管理仓库下载依赖，存在多个问题，

- 无法保证构建确定性：软件作者可以直接代码平台增加 / 修改 / 删除软件版本，导致下次构建使用另外版本的依赖，或者找不到依赖版本。
- 无法保证依赖可用性：依赖软件作者可以直接代码平台删除软件，导致依赖不可用。
- 增加第三方代码托管平台的压力，代码托管平台负载问题。

使用 go proxy 之后，构建时会直接从 go proxy 站点拉取依赖。类比项目中，下游无法满足我们上游的需求。



```go
GOPROXY="https://proxy1.cn, https://proxy2.cn ,direct"
```







#### 工具 - go get/mod

开头提到 go model 有两个本地工具，go get/mod。

| 指令功能 |                          |
| -------- | ------------------------ |
| @update  | 默认                     |
| @none    | 删除依赖                 |
| @v1.1.2  | 下载指定tag版本,语义版本 |
| @23dfdd5 | 下载特定的commit版本     |
| @master  | 下载分支的最新commit     |





go mod 

| 指令 | 功能                            |
| ---- | ------------------------------- |
| init | 初始化,创建go.mod文件           |
| tidy | 增加需要的依赖,删除不需要的依赖 |

















#### go module 使用方法

1. 确保你的项目目录下有一个有效的 `go.mod` 文件。如果没有，可以通过运行 `go mod init` 命令来初始化一个新的模块。
2. 在你的项目中，使用 `import` 语句导入你需要的依赖项。
3. 运行 `go mod tidy` 命令来自动分析你的代码并下载缺少的依赖项。这个命令会根据你的代码中的导入语句自动更新 `go.mod` 文件，并下载相应的依赖项。
4. 如果你想手动下载特定的依赖项，可以使用 `go get` 命令，例如 `go get github.com/example/package`。



```bash
$ go env
GO111MODULE="on"
GOARCH="amd64"
GOBIN=""
GOCACHE="/home/runner/.cache/go-build"
GOENV="/home/runner/.config/go/env"
GOEXE=""
GOEXPERIMENT=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GOINSECURE=""
GOMODCACHE="/home/runner/go/pkg/mod"
GONOPROXY=""
GONOSUMDB=""
GOOS="linux"
GOPATH="/home/runner/go"
GOPRIVATE=""
GOPROXY="https://goproxy.cn,direct"
GOROOT="/nix/store/4m1nfq0xhc9p1hi6dnxbcpppcgz22yf9-go-1.17.5/share/go"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/nix/store/4m1nfq0xhc9p1hi6dnxbcpppcgz22yf9-go-1.17.5/share/go/pkg/tool/linux_amd64"
GOVCS=""
GOVERSION="go1.17.5"
GCCGO="gccgo"
AR="ar"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
GOMOD="/home/runner/app/go.mod"
CGO_CFLAGS="-g -O2"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-g -O2"
CGO_FFLAGS="-g -O2"
CGO_LDFLAGS="-g -O2"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build2769124553=/tmp/go-build -gno-record-gcc-switches"



#  设置 
go env -w GO111MODULE=on
go env -w GOPROXY=https://goproxy.cn,direct

```



GO111MODULE 有三个值：off、on 和 auto (默认值)

- `GO111MODULE=off` ：go 命令行将不会支持 module 功能，寻找依赖包的方式将会沿用旧版本那种通过 vendor 目录或者 GOPATH 模式来查找。

- `GO111MODULE=on` ：go 命令行会使用 modules，而一点也不会去 GOPATH 目录下查找。

- ```
    GO111MODULE=auto
    ```

     

    ：默认值，go 命令行将会根据当前目录来决定是否启用 module 功能。这种情况下可以分为两种情形：

    - 当前目录在 GOPATH/src 之外且该目录包含 go.mod 文件
    - 当前文件在包含 go.mod 文件的目录下面。











[go mod 使用 | 全网最详细 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/482014524?utm_id=0)

直接在文件里 import 然后运行 go mod tidy就行吗

go build 编译的时候会根据 `go.mod` 里自己**下载**包

```bash
go mod init packagename


Go mod provides access to operations on modules.

Note that support for modules is built into all the go commands,
not just 'go mod'. For example, day-to-day adding, removing, upgrading,
and downgrading of dependencies should be done using 'go get'.
See 'go help modules' for an overview of module functionality.

Usage:

    go mod <command> [arguments]

The commands are:

    download    download modules to local cache
    edit        edit go.mod from tools or scripts
    graph       print module requirement graph
    init        initialize new module in current directory
    tidy        add missing and remove unused modules
    vendor      make vendored copy of dependencies
    verify      verify dependencies have expected content
    why         explain why packages or modules are needed

Use "go help mod <command>" for more information about a command.
```



#### 如何指定包版本

在 Go 中，可以使用 Go Modules 来管理和指定包的版本。Go Modules 是 Go 1.11 版本引入的一种包管理机制，它允许你在项目中明确指定所使用的包的版本。

以下是一些常用的指定包版本的方法：

1. 使用固定版本号：在你的项目的 go.mod 文件中，可以直接指定包的固定版本号。例如：

    ```go
    go 1.16
    
    require (
        github.com/gin-gonic/gin v1.7.4
    )
    ```

    在这个例子中，我们明确指定了使用 `github.com/gin-gonic/gin` 的 v1.7.4 版本。

2. 使用语义化版本控制：除了指定固定版本号，你还可以使用语义化版本控制来指定包的版本。例如，你可以使用 `^` 符号来指定兼容的最新版本。例如：

    ```go
    go 1.16
    
    require (
        github.com/gin-gonic/gin ^1.7.0
    )
    ```

    在这个例子中，我们指定了使用 `github.com/gin-gonic/gin` 的兼容版本大于等于 1.7.0 且小于 2.0.0 的最新版本。

3. 使用特定的版本范围：除了使用 `^` 符号，你还可以使用其他运算符来指定特定的版本范围。例如，你可以使用 `>`、`>=`、`<`、`<=` 等符号来指定版本的范围。例如：

    ```go
    go 1.16
    
    require (
        github.com/gin-gonic/gin >=1.7.0, <1.8.0
    )
    ```

    在这个例子中，我们指定了使用 `github.com/gin-gonic/gin` 的版本大于等于 1.7.0 且小于 1.8.0。





### 项目构建/ 编译



一个 Go 工程中主要包含以下三个目录：

```
    src：源代码文件
    pkg：包文件
    bin：相关bin文件
```

1: 建立工程文件夹 goproject

2: 在工程文件夹中建立 src,pkg,bin 文件夹

3: 在 GOPATH 中添加 projiect 路径 例 e:/goproject

4: 如工程中有自己的包 examplepackage，那在 src 文件夹下建立以包名命名的文件夹 例 examplepackage

5：在 src 文件夹下编写主程序代码代码 goproject.go

6：在 examplepackage 文件夹中编写 examplepackage.go 和 包测试文件 examplepackage_test.go

7：编译调试包

go build examplepackage

go test examplepackage

go install examplepackage

这时在 pkg 文件夹中可以发现会有一个相应的操作系统文件夹如 windows_386z, 在这个文件夹中会有 examplepackage 文件夹，在该文件中有 examplepackage.a 文件

8：编译主程序

go build goproject.go

成功后会生成 goproject.exe 文件

至此一个 Go 工程编辑成功。

```bash
1.建立工程文件夹 go
$ pwd
/Users/***/Desktop/go
2: 在工程文件夹中建立src,pkg,bin文件夹
$ ls
bin        conf    pkg        src
3: 在GOPATH中添加projiect路径
$ go env
GOPATH="/Users/liupengjie/Desktop/go"
```





#### go命令

- `go env` 用于打印 Go 语言的环境信息。

- `go run` 命令可以编译并运行命令源码文件。

- `go get` 可以根据要求和实际情况从互联网上**下载**或更新指定的代码包及其依赖包，并对它们进行编译和安装。

- go build 命令用于编译我们指定的源码文件或代码包以及它们的依赖包。

- go install 用于编译并安装指定的代码包及它们的依赖包。

- go clean 命令会删除掉执行其它命令时产生的一些文件和目录。

- go doc 命令可以打印附于 Go 语言程序实体上的文档。我们可以通过把程序实体的标识符作为该命令的参数来达到查看其文档的目的。

    go test 命令用于对 Go 语言编写的程序进行测试。

    go list 命令的作用是列出指定的代码包的信息。

    go fix 会把指定代码包的所有 Go 语言源码文件中的旧版本代码修正为新版本的代码。

    go vet 是一个用于检查 Go 语言源码中静态错误的简单工具。

    go tool pprof 命令来交互式的访问概要文件的内容。
