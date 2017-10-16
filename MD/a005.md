# es6 之 Generator（二）
## Generator的异步应用
### 包括thunk和柯里化的一些知识

### 一、传统的异步方法
-   回调函数
-   事件监听
-   发布/订阅
-   Promise对象

#### 1.什么是异步？
异步和同步相对，指的是，代码不是连续执行。可能执行到片段A，因为A是一个特别耗时的工作，此时主程序需要暂时挂起片段A，先执行下面的片段B，
等到片段A的代码执行完毕，主程序再回过头来处理片段A的结果。
异步编程其实在一定程度上，大大提高了程序的运行效率。众所周知，Javascript是"单线程"的，因此只有异步编程才能够它满足繁重的计算需求，相比于
多线程同步，各有各的优点。脚本语言通常选择单线程异步。想要深入理解Javascript的运行机制，还是推荐阮一峰老师[<<JavaScript 运行机制详解：再谈Event Loop>>](http://www.ruanyifeng.com/blog/2014/10/event-loop.html)的文章。
#### 2.回调函数
如果说主程序是一个行军长队，有两个侦察兵A、B出去探风。同步编程就是行军长队停下来等待A探风回来，保证原来的行军顺序。
异步编程呢，就是行军长队按照原来的速度前进，侦察兵B在探风结束后，打了个电话回来，告诉部队前方情况如何。此时部队再根据当前情况进行调整策略。
这个电话 就可以称作为 **"回调函数(callback)"**

### 二、Thunk函数
所有的文章，介绍Generator函数都一定会带上Thunk函数。他们仿佛一对好基友，至于为啥thunk函数如此重要，我也很懵逼啊，我们一起往下看吧....TnT


从阮一峰老师的文章中，可以知道，thunk函数真的有点年头啊，据说在很久很久以前，几个研究计算机科学的老头坐在一起讨论，函数参数的问题，例如下面的例子。
```javascript
    function foo(a){
        return a * 2;
    }
    var x = 10;
    foo(x + 1);
```
- 1.计算机在处理以下代码的时候，究竟是应该先把(x+1)算出来得到11，再把11带入函数foo。这种方式被称为"**传值调用**"，C语言就采用这种方式。这种方式看起来感觉更加简单，
- 2.还是应该把(x+1)直接带入函数foo。得到式子(x + 1)*2，然后再取到x的值进行计算
对于这个例子，我们似乎不能够得到一个明确的答案，究竟哪种方式更好？

事实上，似乎"传值调用"除了实现更简单一些外，往往会造成一些性能损失。
```javascript
    function foo(a){
        return 2;
    }
    var x = 2;
    foo(Math.pow(x, 100));
```
上面这个例子，就能够很好的说明这点，函数foo里面根本没有使用到参数a，但是这段代码通常是计算机的噩梦。
——无缘无故算了x的100次幂。对于一个比较复杂的表达式作为参数，函数体内根本没有用到这个参数，实际上是有很大的性能损失的。
所以有许多科学家赞成第二种方式"传名调用"。也就有了我们今天的Thunk函数。
```javascript
    function thunk(){
        return x + 1;
    }
    foo(thunk);
    function foo(a){
        return a() + 2;
    }
```
以上js代码简单的实现了一个thunk函数，正好能体现出"传名调用"的原理。就是将参数放到一个临时的函数中，再将临时函数传入目标函数中去。
这个函数就叫做 "**Thunk**"函数。
#### javascript中的Thunk函数
在javascript中，thunk函数的作用其实就是，将多参数函数转化为单一参数为回调函数的函数。好长的一句话，可能有点绕。
说白了他就是一种简化代码的手段，减少重复代码，降低代码的冗余度。把一些经常用到的参数配置进去，之后再使用这个函数的时候就不用写那些默认项了，类似于记住密码。嗯..

来看一个thunk函数的简单实现
在这里比较推荐es6的写法，比较清楚
```javascript
    // es6
    const Thunk = function(fn) {
        return function (...args) {
            return function (callback) {
                return fn.call(this, ...args, callback);
            }
        };
    };
    // es5
    var Thunk = function(fn){
        return function (){
            var args = Array.prototype.slice.call(arguments);
            return function (callback){
                args.push(callback);
                return fn.apply(this, args);
            }
        };
    };

```
这是nodeJS中的一个方法
```javascript
    fs.readFile('data1.json', 'utf-8', (err, data) => {
        // 获取文件内容
    })
```
经过thunk的洗礼，变成了这个样子
```javascript
    const readFileThunk = Thunk(fs.readFile);
    readFileThunk('data1.json', 'utf-8')(function(err, data){
        // ...
    })
```
乍一看有一种变复杂的感觉，其实这个感觉没错。对于个体来说，他确实是变复杂了呃。而且他也等于这样一段代码。
```javascript
    const readFileBind = fs.readFile.bind(null, 'data1.json', 'utf-8');
    readFileBind(function(err, data){
        // ...
    })
```
后来tm发现一件很无语的事情...原来bind方法其实就是函数柯里化的一种实现。TnT，还顺带着能够绑定一下作用域，那还要thunk干啥.......可能是thunk方法更有针对性一些吧
附带一篇文章来介绍bind方法和柯里化——[<<JS中bind方法与函数柯里化>>](https://segmentfault.com/a/1190000003963461);

回到刚才的话题，对于个体来说确实变复杂了<-_<-

但是对于整体来说，很有可能代码变少了呢。。。好吧，其实我还是没能体会到柯里化带来的好处

再来看一个例子
```javascript
    function square(i) {
        return i * i;
    }

    function dubble(i) {
        return i *= 2;
    }

    function map(handeler, list) {
        return list.map(handeler);
    }

    // 数组的每一项平方
    map(square, [1, 2, 3, 4, 5]);
    map(square, [6, 7, 8, 9, 10]);
    map(square, [10, 20, 30, 40, 50]);
    // ......

    // 数组的每一项加倍
    map(dubble, [1, 2, 3, 4, 5]);
    map(dubble, [6, 7, 8, 9, 10]);
    map(dubble, [10, 20, 30, 40, 50]);
```
这个是正常的状态。
柯里化完了之后呢。。是这样
```javascript
    var mapSQ = currying(map, square);
    mapSQ([1, 2, 3, 4, 5]);
    mapSQ([6, 7, 8, 9, 10]);
    mapSQ([10, 20, 30, 40, 50]);
    // ......

    var mapDB = currying(map, dubble);
    mapDB([1, 2, 3, 4, 5]);
    mapDB([6, 7, 8, 9, 10]);
    mapDB([10, 20, 30, 40, 50]);
```
就不用每次都写square和dubble方法啦。。。少写了总共72个字母呢
实际语义没有什么变化，引用大佬的原话
>   我们缩小了函数的适用范围，但同时提高函数的适性

这些差不多就是thunk函数带来的好处，之前是如何喜欢bind的，现在就如何喜欢thunk把

总结一下thunk函数有几个特征：
1. 1.只有一个参数是回调函数，回调函数的第一个参数是"err"，第二个参数是"data"
2. 2.thunk函数和bind都是是柯里化的子集，具体什么是[柯里化](http://www.zhangxinxu.com/wordpress/2013/02/js-currying/)可以看看张鑫旭老师的这篇文章，还蛮有趣的...呵呵

在生成环境中，我们通常使用[thunkify](https://github.com/tj/node-thunkify)这个库
关于柯里化，我们之后在另一篇文章中再一起探讨一下。

终于，感觉总算把thunk函数介绍的七七八八了，接下来再回到我们今天的主角——————
Generator

### 三、thunk函数在Generator函数中的的应用
由于异步编程的弊端，我们现在要做的是尽量将异步编程同步化， 使异步编程拥有同步那样清晰的语义，和可维护性。

最最直接、迫切的需求，就是能够像同步那样，直接通过(=)赋值语句，来拿到异步函数的返回值。像下面这样：
```javascript
    const readFileThunk = thunkify(fs.readFile)
    const gen = function* () {
        const r1 = yield readFileThunk('data1.json')
        console.log(r1)
        const r2 = yield readFileThunk('data2.json')
        console.log(r2)
    }
```
以上代码除了有(yield)关键字，语义非常清晰。我们看起来貌似是在一个"顺序"的流程下，分别拿到(r1)、(r2)作为两次读取文件的结果。啊....太舒服了。
这是一个熟悉同步编程的程序员都能看懂的代码，完全不要动脑筋，没有一层一层的回调函数。不过别高兴的太早，上述代码还需要个发动机，他才能run起来。
#### 纯手动的驱动方式
```javascript
    const g = gen();
    g.next().value((err, data1) => {
        g.next(data1).value((err, data2) => {
            g.next(data2)
        })
    })
```
还是得通过回调函数，现在突然感觉，js的整个异步模型，就是基于回调函数的。
- 执行三次next方法，第一次传参无用，第二次传入读取结果data1，第三次传入读取结果data2，天衣无缝，非常完美。
我们是不是可以把驱动函数封装一下，能够自动识别有几个yield，需要执行几次next方法。于是就有了下面这段代码：
#### 封装run方法
```javascript
    function run(gen){
        const g = gen();
        function next(err, data){
            const result = g.next(data);
            if(data.done) return;
            result.value(next);
        }
        next()
    }
    run(gen);
```
看懂这段代码还是要费一些劲的，只要明确一点，**next方法返回的value是一个thunk函数，thunk函数只接受唯一的回调函数作为参数**就好了。
回调函数真是一个神奇的东西，上下文的转移，全都靠他了，嘿嘿，我感觉这篇文章应该改个名————<<论回调函数(callback)对js异步模型的重要性>>

另外强调一点，thunk函数其实并不是Generator函数自动执行的唯一方案，只要能够做到"**转移上下文**"（移交程序的控制权）的方案都能够实现这一点。
Promise也可以哦。

#### 安利一波co模块
大佬们频频提起的co模块，也是Generator全家桶的重要一员。只需要简单的两行
```javascript
    var co = require('co');
    co(gen);
```
我们编写好的，Generator函数就能够跑起来啦。
```javascript
    co(gen).then(function (){
      console.log('Generator 函数执行完成');
    });
```
co函数返回一个Promise对象，因此可以用then方法添加回调函数。

....此处占个空，来日回来补上基于Promise的实现