# setTimeout引出的问题

### 一、Macrotask Queue和Microtask Queue

>   Macro、Micro 傻傻分不清楚

先来看一段代码，如果这段代码你能够准确的说出执行的顺序，哇~ 那你就很强啦
```javascript
setImmediate(function(){
    console.log(1);
},0);
setTimeout(function(){
    console.log(2);
},0);
new Promise(function(resolve){
    console.log(3);
    resolve();
    console.log(4);
}).then(function(){
    console.log(5);
});
console.log(6);
process.nextTick(function(){
    console.log(7);
});
console.log(8);

```

```javascript
// 3、4、6、8、7、5、2、1
```
我们都知道JavaScript是单线程的，在处理任务的时候：

JavaScript解析引擎，会先从**宏观任务队列**中取出**一个任务**，执行完毕后，将微观任务队列中的**所有任务都取出**，顺序执行。然后再取出**宏观任务队列**中的下一个任务，循环往复。直到两个队列中的任务都取完。

>   宏观任务队列每取一个，就相当于了一次`Event loop`

也有人这么说：
>   setImmediate方法则是在当前"任务队列"的尾部添加事件，也就是说，它指定的任务总是在下一次Event Loop时执行，这与setTimeout(fn, 0)很像。

知道了这个原理，再分享一波每种任务的属性：

名称|任务|
---|---|
Marcotask|script(整体代码)、setTimeout=setInterval、setImmediate、I/O、UI rendering
Mircotask|process.nextTick、Promises、Object.observe、MutationObserver

上述代码执行时，事件的注册顺序：
```javascript
    setImmediate - setTimeout - promise.then - process.nextTick
```

但因为`promise.then`和`process.nextTick`是微观任务，所以他们会先执行，`setImmediate`和`setTimeout`是宏观任务队列中的下一个。

并且他们之前也存在优先级顺序，我们根据输出结果可以很轻松的得到优先顺序

```javascript
    process.nextTick > promise.then > setTimeout > setImmediate
```

>   经过测试发现，setTimeout和setInterval的优先级相同

看到这里，是不是大概了解了这其中的关系。不用总靠“当做特例”来判断这些神奇的现象了。

来看一个很经典的笔试题
```javascript
var flag = true;
setTimeout(function() {
    flag = false;
}, 1000);
while(flag) {}
alert('this is an alert box');
```
猜猜答案是啥？

永远不会弹出alert。

首先再明确一下，js是单线程的。虽然setTimeout是一个异步的任务被放在了宏观队列中。但是第一个任务没执行完的时候，JavaScript解析引擎是不会去碰下一个任务的。script是算一个任务。

### 二、setTimeout的妙用
有蛮多时候，我们想要让一段代码在浏览器空闲的时候执行。

比如页面加载的时候，有些与渲染无关又特别耗时的计算，就可以通过`setTimeout`来后置，可以有效缓解页面的阻塞情况。

这点在ReactNative里甚至都成了一个api

![InteractionManager](https://github.com/w771854332/bengiBlog-node/blob/master/public/screenshot/InteractionManager.png?raw=true)

我们可以通过`InteractionManager`来让逻辑代码在ui线程执行之后进行，可以有效缓解切换页面时的卡顿情况。

再比如

![setTimeout2](https://github.com/w771854332/bengiBlog-node/blob/master/public/screenshot/setTimeout2.png?raw=true)

react-router有一个总所周知的问题，他不能很好的处理锚点。

假设我们有一个场景：
    需要点击标签按钮，跳转页面并滚动到响应的锚点位置

但是react-router拦截了url，使用hash并不会滚动。

我们可以获取url中的hash，通过
```javascript
scrollToAnchor = (anchorName) => {
    if (anchorName) {
        // 找到锚点
        let anchorElement = document.getElementById(anchorName);
        // 如果对应id的锚点存在，就跳转到锚点
        if(anchorElement) { anchorElement.scrollIntoView(); }
    }
}
```
类似的函数来实现锚点的效果。但是我们需要在`componentDidMount`中调用该函数。

但是我们想要尽可能方便的使用“锚点跳转”。并且这个方法其实跟每个组件本身都没有什么关系，把“锚点跳转”内嵌到每个组件中并不符合我们的编程原则，我们叫他“侵入式的代码”，完全没有必要。他最多算是一个“插件功能”。

于是我们统一管理url中的hash，并通过`setTimeout(fn,0)`来达到相同的效果。我觉得是一个更优解。

### 三、不要在项目中频繁大量的使用

虽然`setTimeout`有一些妙用，但是他本是确实是在`宏观任务队列中新增任务了`，所以万万不能滥用啊。
