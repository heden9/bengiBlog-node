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

JavaScript解析引擎，会先从**宏观任务队列**中取出**一个任务**，执行完毕后，将微观任务队列中的**所有任务都取出**，顺序执行。然后再取出**宏观任务队列**中的下一个任务，循环往复。直到两个队列中的任务都取完。

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

>   经过测试发现，setTimeout和setInterval的优先级相同

看到这里，是不是大概了解了这其中的关系。不用总靠“当做特例”来判断这些神奇的现象了。

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

首先再明确一下，js是单线程的。虽然setTimeout是一个异步的任务被放在了宏观队列中。但是第一个任务没执行完的时候，JavaScript解析引擎是不会去碰下一个任务的。script是算一个任务。

### 二、setTimeout的妙用
有蛮多时候，我们想要让一段代码在浏览器空闲的时候执行。

比如页面加载的时候，有些与渲染无关又特别耗时的计算，就可以通过`setTimeout`来后置，可以有效缓解页面的阻塞情况。

这点在ReactNative里甚至都成了一个api
