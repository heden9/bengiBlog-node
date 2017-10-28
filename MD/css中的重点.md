# css中的重点
## 1.clear清除浮动的机制
[<<CSS中的浮动和清除浮动，梳理一下！>>](http://www.jianshu.com/p/09bd5873bed4)
>   浮动元素会脱离文档流并向左/向右浮动，直到碰到父元素或者另一个浮动元素

浮动这个词非常的形象，浮动了的元素真的就像泡沫块一样，漂浮在水面上。碰到墙(父元素)，或者碰到其他的泡沫块(另一个浮动的元素)，他就会像葫芦藻一样扎堆。

像这样:
![float](http://upload-images.jianshu.io/upload_images/1158202-022687081cf649ce.png?imageMogr2/auto-orient/strip%7CimageView2/2)

浮动的设计初衷是为了实现文字环绕效果：
![float](http://upload-images.jianshu.io/upload_images/1158202-27ac63a8ae142d04.png?imageMogr2/auto-orient/strip%7CimageView2/2)

但是人们很快发现了他的好处，可以设置宽高，并且一个挨着一个像内联元素一样排列。早期的浏览器是不支持`inline-block`的，于是`float`就成了大家所热爱的神器。相比`inline-block`,他真的很特别。

#### 浮动的特征

### 1.display:block;clear:both;
### 2.display:table;
## 2.BFC
## 3.vertical-align的对齐机制、line-height
[<<css行高line-height的一些深入理解及应用>>](http://www.zhangxinxu.com/wordpress/2009/11/css%E8%A1%8C%E9%AB%98line-height%E7%9A%84%E4%B8%80%E4%BA%9B%E6%B7%B1%E5%85%A5%E7%90%86%E8%A7%A3%E5%8F%8A%E5%BA%94%E7%94%A8/)
## 4.外边距合并的原理
## 5.css布局模型
-   1.流动模型
-   2.浮动模型
-   3.层次模型

