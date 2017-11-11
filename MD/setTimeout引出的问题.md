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

知道了这个原理，再分享一波每种任务的属性：

名称|任务|
---|---|
Marcotask|script(整体代码)、setTimeout=setInterval、setImmediate、I/O、UI rendering
Mircotask|process.nextTick、Promises、Object.observe、MutationObserver