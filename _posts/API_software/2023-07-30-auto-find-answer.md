---
layout: blog
banana: true
category: API_software
title:  自动化查题
date:   2023-07-30 17:55:31
background: blue
tags:
- API_software
- python
- auto
---

* content
{:toc}


- 问题文件 `question.txt`
- 题库文件 `diction.xlsx`
- 输出为`查询结果.xlsx`





#### 1 读取查询列表

```python
##########-读取查询列-#########


# 文本预处理

filepath = "./auto/question.txt"

with open(filepath, 'r', encoding='utf-8') as f:
    text = f.read()

text_new = text.replace('（', '(')
text_new = text_new.replace('）', ')')

with open(filepath, 'w', encoding='utf-8') as f:
    f.write(text_new)




# 打开txt文件并读取内容
with open("./auto/question.txt", "r", encoding="utf-8") as file:
    content = file.read()
# print("contect=", content)

# 把题目导出来
pattern = r'(\d+\.+)(.+?)(?=(\(|\。|\n|$))'
matches = re.findall(pattern, content, flags=re.DOTALL)
# [('1. ', '质量流量计不能够直接测出的参数是（ ）'),.....]
```



#### 2 读取题库

```python
######### 读取题库 ##############
dic = []
# 读取单选题
df= pd.read_excel("./auto/diction.xlsx", sheet_name="one", usecols=[0,1])
value_array = df[["题目", "答案"]].values
#print(df)
dic1= [(question, ans) for question, ans in value_array]
dic.extend(dic1)

```



#### 3 进行查题

```python
########### 进行查询 ###############
res= []

num = 0

for match in matches:
    # 查询id, 查询题目
    id = match[0]
    qu = match[1]
    
    # 题目过短, 自己进行处理
    if(len(qu)<=5):
        res.append((id, "没有答案"))
        continue
    
    flag = 0
    # 开始从题库中查询
    for allqu, ans in dic:
        if qu in allqu:
            res.append((id, ans))
            flag =1
            num+=1
            break
        
    
    if(flag ==0):
        res.append((id, "没有答案"))

# print("res=", res)
print("共查询到", num , "/", len(res),"个结果")

# 输出为 execl, 一共两列
data = {
    '题号': [item[0] for item in res],
    '答案': [item[1] for item in res]
}
df=pd.DataFrame(data)
df.to_excel("./auto/查询结果.xlsx",sheet_name="Sheet1", header=None, index=False)



############ 如果没有搜索到答案 ###########
print("下面请输入没有搜索到答案的问题")
for i in range(100):
    s = input("请输入问题：(右键即黏贴)\n")

    for ques, ans in dic:
        if s in ques:
            print(ans,"\n\n\n")

```







#### 4 总体代码

```python
import re
import pandas as pd



##########-读取查询列-#########


# 文本预处理

filepath = "./auto/question.txt"

with open(filepath, 'r', encoding='utf-8') as f:
    text = f.read()

text_new = text.replace('（', '(')
text_new = text_new.replace('）', ')')

with open(filepath, 'w', encoding='utf-8') as f:
    f.write(text_new)




# 打开txt文件并读取内容
with open("./auto/question.txt", "r", encoding="utf-8") as file:
    content = file.read()
# print("contect=", content)

# 把题目导出来
pattern = r'(\d+\.+)(.+?)(?=(\(|\。|\n|$))'
matches = re.findall(pattern, content, flags=re.DOTALL)
# [('1. ', '质量流量计不能够直接测出的参数是（ ）'),.....]

# print("maches=", matches)

matches = [(ma[0], ma[1] ) for ma in matches]
print("maches=", matches)


# 将数据转换成 DataFrame 格式

# 将数据转换成 DataFrame 格式, 并修改列名为 "序号" 和 "答案"
df = pd.DataFrame(matches, columns=['序号', '问题'])

# 使用 slice() 方法将 content 列的字符串长度截断为 20
df['问题'] = df['问题']#.str.slice(20)



# print("df=", df)
# 将数据保存到 Excel 文件中
df.to_excel('./auto/问题列表.xlsx', index=False)






######### 读取题库 ##############
dic = []
# 读取单选题
df= pd.read_excel("./auto/diction.xlsx", sheet_name="one", usecols=[0,1])
value_array = df[["题目", "答案"]].values
#print(df)
dic1= [(question, ans) for question, ans in value_array]
dic.extend(dic1)




# dic = [('修改后的《安全生产法》由习近平主席于2014年签署第十三号令予以公布，自2014年（）起施行。', 'C'),(),,,,]
# print("\n\n\ndic=", dic)


########### 进行查询 ###############
res= []

num = 0

for match in matches:
    # 查询id, 查询题目
    id = match[0]
    qu = match[1]
    
    # 题目过短, 自己进行处理
    if(len(qu)<=5):
        res.append((id, "没有答案"))
        continue
    
    flag = 0
    # 开始从题库中查询
    for allqu, ans in dic:
        if qu in allqu:
            res.append((id, ans))
            flag =1
            num+=1
            break
        
    
    if(flag ==0):
        res.append((id, "没有答案"))

# print("res=", res)
print("共查询到", num , "/", len(res),"个结果")

# 输出为 execl, 一共两列
data = {
    '题号': [item[0] for item in res],
    '答案': [item[1] for item in res]
}
df=pd.DataFrame(data)
df.to_excel("./auto/查询结果.xlsx",sheet_name="Sheet1", header=None, index=False)



############ 如果没有搜索到答案 ###########
print("下面请输入没有搜索到答案的问题")
for i in range(100):
    s = input("请输入问题：(右键即黏贴)\n")

    for ques, ans in dic:
        if s in ques:
            print(ans,"\n\n\n")

```

