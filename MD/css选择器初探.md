# css选择器
## 一、常用的
### 1.id选择器
```css
    #div1 {
        width: 100px;
    }
```
### 2.class选择器
```css
    .div2 {
        width: 200px;
    }
```
### 3.标签选择器
```css
    tag {
        width: 200px;
    }
```
### 4.后代选择器
```css
    #div2 .div {
        width: 200px;
    }
```
### 5.子代选择器
```css
    #div2>.div {
        width: 200px;
    }
```
### 6.多类选择器
```css
    .div2.div{
        width: 200px;
    }
```
### 7.多个选择器
```css
    .div1,.div2{
        width: 200px;
        height: 200px;
        background: red;
    }
```
### 下一个兄弟选择器
```css
    .div1+p{
        width: 200px;
        height: 200px;
        background: red;
    }
```
选中紧接.div1后的一个p元素
### 下面所有兄弟选择器
```css
    .div1~p{
        width: 200px;
        height: 20px;
        background: blue;
    }
```
选中紧接.div1后的所有的p元素
### 通配符选择器
```css
    * {
        margin: 0;
        padding: 0;
    }
```
### 伪元素选择器
```cssv
    .div1::after {
        content: '';
    }
    .div1::before {
        content: '';
    }
```
不常用的
```css
    p::first-letter {
        color: red;
    }
    p::first-line {
        color: green;
    }
```
#### 伪类选择器(太多了，介绍几个)
```css
    p:first-child {

    } // p是他的父元素的第一个孩子
    p:first-of-type{

    } // 第一个出现的p
    p:last-child {

    }
    a:active {

    }
    a:hover {

    }
    p:nth-child(n){ // 表达式从1开始

    }
```
#### 属性选择器
```css
    [target] {}
    [target=-blank] {}
    [title~=flower] {}
```
#### 还有很多复杂的不常用的选择器，这里一一介绍了

### 二、选择器权重
名称          | 权重 | 
-------------|------|
内联样式style  | 1000 | 
id           | 100  | 
class、伪类选择器       | 10   |
标签、伪元素   | 1    |
*、>、+       |   0  |

#### 比较规则
1,0,0,0 > 0,99,99,99
逐级比较
例：
```css
    #div1 .div2 a {} // 100, 10, 1
    #div2 .div2 .div3 {} // 100, 10, 10 他的权重大
```
```css
    .div2 #div3 {} // 10, 100 
    #div2 .div2 {} // 100, 10 相同，
```
同一档次的选择器进行叠加，然后逐级比较