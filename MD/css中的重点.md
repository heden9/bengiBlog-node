# css中的重点

## 1.css布局模型
css的布局模型在y轴上分布，划分为三层，我们常说的**文档流**指的就是流动模型这层。
| 层次      | |
| --------- |---|
| 流动模型层 | default
| 浮动模型层 | 设置了float之后
| 层次模型层 | 设置了position之后
不同层次的元素之间，在布局上，不会产生干扰
### 1.流动模型（flow）
流动（Flow）是默认的网页布局模式。也就是说网页在默认状态下的 HTML 网页元素都是根据流动模型来分布网页内容的。

-   1.块状元素都会在所处的包含元素内自上而下按顺序垂直延伸分布，因为在默认状态下，块状元素的宽度都为100%。实际上，块状元素都会以行的形式占据位置。如右侧代码编辑器中三个块状元素标签(div，h1，p)宽度显示为100%。

-   2.在流动模型下，内联元素都会在所处的包含元素内从左到右水平分布显示。（内联元素可不像块状元素这么霸道独占一行）
### 2.浮动模型（float）
任何元素在默认情况下是不能浮动的，但可以用 CSS 定义为浮动，如 div、p、table、img 等元素都可以被定义为浮动。设置了float属性后，该元素就从原本的**流动层**，转移到了**浮动层**，处于浮动层的元素，就像水平上的浮萍一样。
### 3.层次模型（layout）
什么是层布局模型？层布局模型就像是图像软件PS中非常流行的图层编辑功能一样，每个图层能够精确定位操作，但在网页设计领域，由于网页大小的活动性，层布局没能受到热捧。但是在网页上局部使用层布局还是有其方便之处的。下面我们来学习一下html中的层布局。

如何让html元素在网页中精确定位，就像图像软件PS中的图层一样可以对每个图层能够精确定位操作。CSS定义了一组定位（positioning）属性来支持层布局模型。

-   1.relative 相对定位
-   2.absolute 绝对定位
-   3.fixed 固定定位

#### 1.relative相对定位
**元素的本体还在文档流中保持原来的位置，但却在层次模型中有一个分身**，和translate非常类似。

看一个例子：
```css
    // css
    div{
        width: 50px;
        height: 30px;
        background: red;
        margin: 5px;
    }
    .div2{
        background: green;
        display: inline-block;
        width: 30px;
    }
    .div3{
        /* position: relative; */
        bottom: 20px;
        width: 30px;
        display: inline-block;
        background: rebeccapurple;
    }
```
```html
    <div></div>
    <div></div>
    <div class="div3"></div>
    <div class="div2"></div>
```
效果：


---
## 2.clear清除浮动的机制
[<<CSS中的浮动和清除浮动，梳理一下！>>](http://www.jianshu.com/p/09bd5873bed4)
>   浮动元素会脱离文档流并向左/向右浮动，直到碰到父元素或者另一个浮动元素

浮动这个词非常的形象，浮动了的元素真的就像泡沫块一样，漂浮在水面上。碰到墙(父元素)，或者碰到其他的泡沫块(另一个浮动的元素)，他就会像葫芦藻一样扎堆。

像这样:
![float](http://upload-images.jianshu.io/upload_images/1158202-022687081cf649ce.png?imageMogr2/auto-orient/strip%7CimageView2/2)

浮动的设计初衷是为了实现文字环绕效果：
![float](http://upload-images.jianshu.io/upload_images/1158202-27ac63a8ae142d04.png?imageMogr2/auto-orient/strip%7CimageView2/2)

但是人们很快发现了他的好处，可以设置宽高，并且一个挨着一个像内联元素一样排列。早期的浏览器是不支持`inline-block`的，于是`float`就成了大家所热爱的神器。相比`inline-block`,他真的很特别。
![float](http://upload-images.jianshu.io/upload_images/1158202-6d074de3fdb03dc1.png?imageMogr2/auto-orient/strip%7CimageView2/2)
#### 浮动的特征
脱离文档流，css布局模型分为
### 1.display:block;clear:both;
### 2.display:table;
## 3.BFC
## 4.vertical-align的对齐机制、line-height
[<<css行高line-height的一些深入理解及应用>>](http://www.zhangxinxu.com/wordpress/2009/11/css%E8%A1%8C%E9%AB%98line-height%E7%9A%84%E4%B8%80%E4%BA%9B%E6%B7%B1%E5%85%A5%E7%90%86%E8%A7%A3%E5%8F%8A%E5%BA%94%E7%94%A8/)
## 5.外边距合并的原理

