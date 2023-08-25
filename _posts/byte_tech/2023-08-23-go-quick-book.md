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




### 变量

Go 语言是一种静态类型的编程语言，它提供了以下基本类型：Go 语言要求标识符以一个字母或下划线开头，后面可以跟任意数量的字母、数字、下划线。不能使用关键字作为标识符

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



#### 基础类型

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





#### 常量

- 常量的声明方式和变量差不多，区别在于常量需要用 `const` 关键字修饰，不能使用`:=` 进行声明。

```go
const num int = 555
```







#### string

- `string` 类型用于表示文本字符串。它是一种不可变的序列，由多个 Unicode 字符组成，并使用双引号 `"` 或反引号 ``` 包围。
- 由于字符串是**不可变**的，如果需要对大量的字符串进行拼接操作，最好使用 `bytes.Buffer` 或 `strings.Builder` 类型，以提高性能和效率。







#### 数值类型

整数类型分为：

- 有符号数：`int`、`int8`、`int16`、`int32 (rune)`、`int64`
- 无符号数：`uint`、`uint8 (byte)`、`uint16`、`uint32`、`uint64`、





#### 类型转换

**使用表达式 `T(v)` 将变量 v 的值的类型转换为 T**。注意是转换的是 **变量的值**，变量本身的类型不变。







### 高级变量

#### 切片---可变的数组

- 声明切片和声明数组类似，但是**不指定长度**：

```go
// 声明一个 int 类型, 名为 a的切片
var a []int

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


// 遍历
for key, value := range scores {
    fmt.Println(key, value)
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





#### 指针

- 和 `C`中的很像

```go
var p *int
var a int = 66 //a是值为66的int变量
p = &a //将a的地址赋给指针p
var b = *p //根据p中的值找到a，将其值赋给b
fmt.Println(b) //66

*p = 99 //根据p中的值找到a，改变a的值
fmt.Println(a) //99

```



#### 结构体

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



#### new 

```go
p := new(dog)
fmt.Printf("%T\n", p) //*main.dog
fmt.Println(p) //&{ 0}
fmt.Println(*p) //{ 0}
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



### 流程控制--- 没有括号

#### if

```go
if {
    
}
else{
    
}
```



#### for

```go
for 初始化语句; 条件表达式; 后置语句 {
    //循环体代码
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

