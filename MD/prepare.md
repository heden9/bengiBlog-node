捕获和冒泡的坑

1.先捕获再冒泡，是对其他元素说的。
对于同一个元素绑定的事件，是按照代码顺序来执行事件的


浏览器事件模型
异步事件驱动
事件捕获阶段
事件触发阶段
事件冒泡阶段



在一个事件监听函数中中止同一事件后续的其他监听函数
使用Event的stopImmediatePropagation方法，注意它与stopPropagation的区别

```javascript
  var body = document.body
  body.addEventListener('click',(e) => {
    console.log('first')
    e.stopImmediatePropagation()
  })
  body.addEventListener('click',(e) => {
    console.log('second')
  })
```
如何将一个div元素变成可输入编辑文本的元素(参考富文本编辑器)  contenteditable

BFC（块级格式化上下文），是页面上的一个隔离的独立容器，容器里面的子元素不会影响到外面元素，反之亦然。它与普通的块框类似，但不同之处在于:
（1）可以阻止元素被浮动元素覆盖。
（2）可以包含浮动元素。
（3）可以阻止margin重叠。
满足下列条件之一就可触发BFC：
【1】根元素，即HTML元素
【2】float的值不为none
【3】overflow的值不为visible
【4】display的值为inline-block、table-cell、table-caption
【5】position的值为absolute或fixed

2.统计单词出现次数(key => value)
```javascript
  var str = 'CORS、JSONP、Fetch、postMessage、Node、Webpack proxyTable';
  var arr = str.split(/\、| |\?|\,/);
  var result = arr.reduce(function(a, b, c){
    a[b] = (a[b] || 0) + 1;
    return a;
  }, {})
```
reduce的polyfill
```javascript
  Array.prototype.reduce = function(callback, initialVal){
    if (!this instanceof Array){
      throw new Error('need array')
    }
    if (!callback instanceof Function){
      throw new Error('need function')
    }
    if (this.length === 0 && initialVal == null){
      throw new Error('array is not empty or initialVal also')
    }
    var sum = initialVal || this[0];
    if (this.length === 0){
      return sum;
    }
    for(var i = 0; i < this.length; i++){
      var item = this[i];
      sum = callback(sum, item, i, this)
    }
    return sum;
  }
```


是
判断是否是数组的方法
```javascript
   Array.isArray(arr) 是 Object.prototype.toString.call(arg) === '[object Array]';
   //的语法糖。instanceof 跨frame时不能共享原型链。
```


gulp和webpack的区别？(模块与流，CommonChunks抽出公共模块)

gulp 是 task runner，Webpack 是 module bundler

gulp根据指定的任务一个个跑完，可以完成node下几乎所有的任务。文件stream
webpack是从一个入口进去，顺藤摸瓜，吧所有的资源打包输出


```javascript
  var a = 1;
  a.b = function(){
    alert(1);
  }
  a.b();
```


数组去重

set方法 最简单

遍历，用一个hashmap记录


浏览器缓存

强缓存 cache-control 200 from cache
协商缓存 304


## 红包雨总结


### 红包雨性能优化

#### 动画的性能优化
left top 改transform，并且我们为红包元素都开启了3d加速。
只有transform中的几个属性才能够开启3d加速，开启后，会为该元素创建一个独立的渲染层，可用Chrome查看layout border 为橙色。之后，该元素的动画不会触发repaint
3d加速对内存的占用比较严重，开启过多会导致浏览器卡死
通过Chrome的performance来查看性能开销。

全部使用raf来更新动画，raf在浏览器下一次重绘之前触发，几乎等于微任务。多处创建raf也没有关系，他不会带来额外的性能开销。比如计时器会创建一个新的loop。
另外，raf在页面最小化时候会停止，原因就是因为他是在下一次重绘之前触发。最小化之后就没有重绘了

又处于组件化的考虑，每个红包只需要处理自己的逻辑，降低复杂度，不集中处理位置信息
每个红包组件封装了自己的点击效果，爆炸，彩带的帧动画。用css3的animation的step-start实现。对用到的精灵表都进行了压缩处理，

缓存transform状态，不在动画中做dom查询
transform的前缀，兼容处理

做到后面才发现性能的问题在老旧手机上有点明显，尤其是iPhone 6以下设备 主要是游戏刚开始时raf执行缓慢。因为我们要确保红包在30秒内掉落干净，所以没做dom元素的最大限制。于是红包在游戏刚开始的时候大量堆积。导致卡死。

解决办法，因为不能更改红包数量，也不能延长游戏结束的时间，所以只能加快该类手机的红包掉落速度。
并且我们不能影响原本正常的手机，导致他们下落速度过快。

手机型号判断

有一个hack的方法，
```javascript
  var getGl = () => getCanvas().getContext('experimental-webgl');
  var debugInfo = getGl().getExtension('WEBGL_debug_renderer_info');
  var result = getGl().getParameter(debugInfo.UNMASKED_RENDERER_WEBGL);
```
获取设备的显卡型号。
再根据一张详情表，通过屏幕分辨率和显卡型号，来知道是哪个设备
```javascript
  // 计算屏幕分辨率的方法
  function getScreenWidth() {
      return Math.max(screen.width, screen.height) * (window.devicePixelRatio || 1);
  }
```
```javascript
  var devices = {
  "Apple A7 GPU": {
    1136: ["iPhone 5"],
    2048: ["iPad Air", "iPad Mini 2", "iPad Mini 3"]
  },

  "Apple A8 GPU": {
    1136: ["iPod touch (6th generation)"],
    1334: ["iPhone 6"],
    2208: ["iPhone 6 Plus"],
    2048: ["iPad Air 2", "iPad Mini 4"]
  },

  "Apple A9 GPU": {
    1136: ["iPhone SE"],
    1334: ["iPhone 6s"],
    2208: ["iPhone 6s Plus"],
    2224: ["iPad Pro (9.7-inch)"],
    2732: ["iPad Pro (12.9-inch)"]
  },

  "Apple A10 GPU": {
    1334: ["iPhone 7"],
    2208: ["iPhone 7 Plus"]
  },
  "Apple A11 GPU": {
    1334: ["iPhone 8"],
    2208: ["iPhone 8 Plus"],
    2436: ["iPhone X"],
}
```
对于iPhone来说的确能够准确识别


我们筛选所有ios10以下版本，和Android5以下版本，来加快红包下落速度，效果还是不错的。


事后分析原因，小小的红包雨游戏在各个设备上的表现不太好，有可能是react的拖慢了的原因，因为游戏内含有大量业务，也不方便使用canvas来做。
#### react的性能优化
shouldComponentUpdate 阻止红包的更新，该阻止的都阻止了



### cdn不稳定，引出的图片资源降级策略
监听window上的error事件，当页面发生错误时，e.target 是同正常的事件一样的。
先过滤掉target === window的情况，取到
```javascript
  window.addEventListener('error', function(event) {
      // 过滤 target 为 window 的异常，避免与 JavaScript runtime error 重复
      var errorTarget = event.target;
      if(errorTarget !== window && errorTarget.nodeName && LOAD_ERROR_TYPE[errorTarget.nodeName.toUpperCase()]) {
          handleStaticError(errorTarget, LOAD_ERROR_TYPE[errorTarget.nodeName.toUpperCase()]);
      }
  }, true);
```
setTimeout 结果存入红黑树中，执行时，时间复杂度是O(lg(n))
nextTick 结果放入栈中 微任务，每个tick会把数组中的回调都执行完
setImmediate 结果存入链表中，宏任务 只执行一个

### 华为小米某些机型html的font-size和‘最终的font-size’不相等，导致问题
```javascript
/*1.31 修复小米rem bug*/
  function setRem() {
      var e = 0;
      document.documentElement && document.documentElement.clientWidth
        ? e = document.documentElement.clientWidth
        : document.body && document.body.clientWidth
          ? e = document.body.clientWidth
          : window.innerWidth && (e = window.innerWidth),
      document.documentElement.style.fontSize = e > 750
        ? "100px"
        : e / 750 * 100 + "px";
  }
  function modifileRootRem () {
    var root = window.document.documentElement;
    var fontSize = parseFloat(root.style.fontSize);
    var finalFontSize = parseFloat(window.getComputedStyle(root).getPropertyValue("font-size"));
    if(finalFontSize === fontSize) return;
    root.style.fontSize = fontSize+(fontSize-finalFontSize) + "px";
  }
  setRem();
  modifileRootRem();
  window.onresize = function () {
    setRem();
    modifileRootRem();
  };
```
hiapp的项目

移动端兼容问题，
ios11的fixed bug问题及滚动问题，
解决办法。iscroll
在new一个对象的时候发生了什么


```javascript
  new Person("John") = {
    var obj = {};
	obj.__proto__ = Person.prototype; // 此时便建立了obj对象的原型链：
	// obj->Person.prototype->Object.prototype->null
	var result = Person.call(obj,"John"); // 相当于obj.Person("John")
	return typeof result === 'object' ? result : obj; // 如果无返回值或者返回一个非对象值，则将obj返回作为新对象
}
function _new(Person){

  var obj = {};
obj.__proto__ = Person.prototype; // 此时便建立了obj对象的原型链：
// obj->Person.prototype->Object.prototype->null
var result = Person.call(obj,"John"); // 相当于obj.Person("John")
return typeof result === 'object' ? result : obj;
}
```


单例模式
```javascript
  function Person(params) {
    if (Person.instance){
      return Person.instance;
    }
    this.name = '111';
    return Person.instance = this;
  }
```


es7中的装饰器，本质是使用Object.defainePropty来改变


### 源码篇
React 源码

Vue Object.definePropty  所以不兼容ie8.  通过设置get、set对页面中的元素进行数据劫持，

react-router
三个history: hashHistory、browserHistory、memoryHistroy
```javascript
  function Router() {
      this.routes = {};
      this.currentUrl = '';
  }
  Router.prototype.route = function(path, callback) {
      this.routes[path] = callback || function(){};
  };
  Router.prototype.refresh = function() {
      this.currentUrl = location.hash.slice(1) || '/';
      this.routes[this.currentUrl]();
  };
  Router.prototype.init = function() {
      window.addEventListener('load', this.refresh.bind(this), false);
      window.addEventListener('hashchange', this.refresh.bind(this), false);
  }
  window.Router = new Router();
  window.Router.init();
```
redux 单项数据流，把store装在闭包里。是一个观察者（发布、订阅）模式。

combineReducer   (state,action) => newState  所以可以通过curry和compose来进行组合
applyMiddleware  接受一个数组，数组中的函数的格式为  (store) => (next) => (action) => next(action)
通过compose来进行chain的组合，compose的顺序一般为从右到左，但中间件的执行顺序却是从左到右的。。这是一个控制反转。
每个中间件都把自己的action交给上一个中间件来控制。第一个中间件吧自己的action交给dispatch来控制

curry
```javascript
  /**
 *
 * @param {func} reduce 用于修改数组的方法，
 */
function createCurry(reduce){
  reduce = reduce || function(x){ return x }
  return function curry(fn){
    if (!fn instanceof Function){
      throw new Error('fn need function!')
    }
    let outerArgs = Array.prototype.slice.call(arguments, 1);
    let len = fn.length;
    function getCurry(sum){
      return function(){
        let innerArgs = Array.prototype.slice.call(arguments);
        let args = sum.concat(innerArgs);
        if (args.length === len){
          return fn.apply(this, reduce(args));
        }
        return getCurry(args);
      }
    }
    return getCurry(outerArgs)
  }
}
/**
 * 从左向右柯里化
 */
export const curry = createCurry();

/**
 * 从右向左柯里化
 */
export const curryRight = createCurry(function(arg) {
  return arg.reverse();
})

/**
 * 限制传入函数的参数个数
 * @param {func} fn
 * @param {int} number
 */
export function arg(fn, number) {
  return function(){
    let arg = Array.prototype.slice.call(arguments, 0, number)
    return fn.apply(this, arg);
  }
}
```

debounce 防抖 一般用于点击事件
```javascript
  var debounce = function(idle, action){
    var last
    return function(){
      var ctx = this, args = arguments
      clearTimeout(last)
      last = setTimeout(function(){
          action.apply(ctx, args)
      }, idle)
    }
  }

  var nextFunc = debounce(30, ajax)(id)
```
throttle 节流 一般用于滚动事件
```javascript
  var throttle = function(delay, action){
    var last = 0
    return function(){
      var curr = +new Date()
      if (curr - last > delay){
        action.apply(this, arguments)
        last = curr
      }
    }
  }
```
promise的实现
[](http://www.cnblogs.com/huansky/p/6064402.html)
# todo

## 服务器篇

负载均衡就是通过调度算法把请求尽可能均匀的分配给各个服务器


lvs 和 keepAlived  来实现负载均衡
keepAlived 可以设置各个服务器所扮演的角色。master和backup，备胎和master
并可以设置各自的权重。会优先为权重高的服务器创建连接。


keepAlived可以保证其中一台服务器宕机的情况下，服务不断。
当服务器恢复的时候，又能重新建立连接。是分布




## node篇
11.nodejs子进程 spawn，exec，execFile和fork的用法和区别？
spawn函数用给定的命令发布一个子进程，只能运行指定的程序，参数需要在列表中给出。
exec也是一个创建子进程的函数，与spawn函数不同它可以直接接受一个回调函数作为参数，回调函数有三个参数，分别是err, stdout , stderr。
execFile函数与exec函数类似，但execFile函数更显得精简，因为它可以直接执行所指定的文件。
fork函数可直接运行Node.js模块，我们可以直接通过指定模块路径而直接进行操作。


## express 和 koa对比
1。异常捕获困难
2。回调函数嵌套可怕
### event loop
process.nextTick()的回调函数执行的优先级要高于setImmediate()，process.nextTick()属于idle观察者。
setImmediate()属check观察者.在每一轮循环检查中,idle观察者先于I/O观察者,I/O观察者先于check观察者。
process.nextTick()的回调函数保存在一个数组中，会将异步回调放到当前帧的末尾、io回调之前，如果nextTick过多，会导致io回调不断延后,最后callback堆积太多。
setImmediate()的结果则是保存在链表中，会将异步回调放到下一帧,不影响io回调,不会造成callback 堆积。
process.nextTick()在每轮循环中会将数组中的回调函数全部执行完，而setImmediate()在每轮循环中执行链表中的一个回调函数。
process.nextTick()，效率最高，消费资源小，但会阻塞CPU的后续调用；
setTimeout()，精确度不高，可能有延迟执行的情况发生，且因为动用了红黑树，所以消耗资源大；
setImmediate()，消耗的资源小，也不会造成阻塞，但效率也是最低的。




## splice 和 slice
splice(index, howmany, item1, ... ,itemn)，他的返回值是被删除的项目
index 从0开始，howmany代表数量


slice(start, end)
如果 end 未被规定，那么 slice() 方法会选取从 start 到数组结尾的所有元素。


## 手写ajax
```javascript
  function ajax(){
    var xmlhttp;
    if(window.XMLHttpRequest){
        xmlhttp = new XMLHttpRequest();
    }else{
        // code for IE
        xmlhttp = ActiveXObject("Microsoft.XMLHTTP");
    }

    //判定执行状态
    xmlhttp.onreadystatechange = function(){
        /*
        readyState
            0: 请求未初始化
            1: 服务器连接已建立
            2: 请求已接收
            3: 请求处理中
            4: 请求已完成，且响应已就绪
        status
            200:请求成功
            404:未找到
            500:服务器内部错误
        */
        if (xmlhttp.readyState==4 && xmlhttp.status==200){
            document.getElementById("myDiv").innerHTML=xmlhttp.responseText;//获得字符串形式的响应数据

        }
      }
    xmlhttp.open("Get","url",true);

    //设置头信息
    xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");

    //将信息发送到服务器
    xmlhttp.send();

}
```


## dom宽高等
```
  element.clientWidth = content + padding （不包括滚动条，在Windows上，出现滚动条后，元素clientwidth会变化）
  clientLeft, clientTop 就是borderWidth
  element.clientHeight = content + padding
  element.getBoundingClientRect() 返回值情况
  offsetWidth = content + padding + border + 滚动条width
  offsetLeft,offsetTop 取的是离他最近的祖先元素。

  scrollTop，scrollLeft 滚动条距离顶部，左边的距离。
  scrollWidth, scrollHeight 内容全部的宽度/高度




  left:包围盒左边 border 以外的边缘距页面左边的距离
  right:包围盒右边 border 以外的边缘距页面左边的距离
  top:包围盒上边 border 以外的边缘距页面顶部的距离
  bottom:包围盒下边 border 以外的便于距页面顶部的距离
  width: content + padding + border
  height: content + padding + border
  注意，设置外边距时外边距合并的情况

```


### cookie操作

```javascript
  function setCookie(cname,cvalue,exdays)
{
  var d = new Date();
  d.setTime(d.getTime()+(exdays*24*60*60*1000));
  var expires = "expires="+d.toGMTString();
  document.cookie = cname + "=" + cvalue + "; " + expires;
}


function getCookie(cname)
{
  var name = cname + "=";
  var ca = document.cookie.split(';');
  for(var i=0; i<ca.length; i++)
  {
    var c = ca[i].trim();
    if (c.indexOf(name)==0) return c.substring(name.length,c.length);
  }
  return "";
}
```


### 说到前端优化

- 1.服务端渲染ssr，同构直出
- 2.渐进启动，先展示一个框架，然后使用可以加速初始渲染时间的模块或技术（例如tree-shaking和code-splitting），因为大部分性能问题来自于应用引导程序的初始分析时间。还可以在服务器上提前编译，从而减轻部分客户端的渲染过程，从而快速输出结果。最后，考虑使用Optimize.js来加快初始加载速度，它的原理是包装优先级高的调用函数
- 3.http缓存 强缓存
- 4.js代码异步调用 defer和async
- 5.通过tree-shaking和code-splitting减少净负载
- 6.feed中图片懒加载
- 7.选择一个合适的cdn
- 8.使用http/2.0 多路复用、server push、头部压缩
- 9.服务端压缩算法 Brotli或Zopfli或gzip
- 10.减少重绘重排


### 如何防御网页劫持

csp 内容安全策略（Content Security Policy）白名单机制。

运营商劫持的主要手法：
- 1.DNS 劫持。直接篡改 DNS 返回包，比例很小，除了让用户修改 DNS 没什么好办法。
- 2.HTTP 劫持。全部或部分替换/注入页面元素，比例很大。
[csp](http://www.ruanyifeng.com/blog/2016/09/csp.html)
遇到返回包全量替换（整个页面或 JS 文件），请用 HTTPS。
遇到 script、iframe 等注入，可以用 CSP 防御。


### nodejs event loop设计初衷
nodejs 具有事件驱动和非阻塞但线程的特点，使相关应用变得比较轻量和高效。当应用程序需要相关I/O操作时，线程并不会阻塞，而是把I/O操作移交给底层类库（如：libuv）。此时nodejs线程会去处理其他的任务，当底层库处理完相关的I/O操作后，会将主动权再次交还给nodejs线程。因此event loop的作用就是起到调度线程的作用，如当底层类库处理I/O操作后调度nodejs单线程处理后续的工作。也就是说当nodejs 程序启动的时候，它会开启一个event loop以实现异步的api调度、schedule timers 、回调process.nextTick()。

### webpack打包优化
- 1.文件多
- 2.依赖多
- 3.页面多


* 方法一 分开vendor和app
    - DllPlugin
    - DllReferencePlugin
* 方法二 并行压缩
    - UglifyJsPlugin
      - parallel
      - cache
* 方法三 对loader开启并行
    - HappyPack (如果src下依赖较少，则会延长时间)
* 方法四 babel-loader的优化
    - options.cacheDirectory
    - include
    - exclude
* 其他方法
    - 减少resolve
    - Devtool：去除sourceMap
    - cache-loader
    - node webpack升级

生成稳定的hash
  - 使用chunkHash（每个chunk自己的hash）
  - 提取webpack runtime(可以直接inline到html)
  - NamedChunkPlugin
code-split做的事
  - 为异步模块单独命名（如果用数字命名的话他会变）


#### 多页面应用的配置
- 多配置
    - 优点
      * webpack可以处理一个配置的数组
      * parallel-webpack可以大幅提升打包速度
      * 配置更加灵活
    - 缺点
      * 多页之间不能公用缓存
- 单配置


### 前端监控
- 1.window.onerror 监听error事件
```javascript
window.onerror = function(errorMessage, scriptURI, lineNo, columnNo, error) {
    console.log('errorMessage: ' + errorMessage); // 异常信息
    console.log('scriptURI: ' + scriptURI); // 异常文件路径
    console.log('lineNo: ' + lineNo); // 异常行号
    console.log('columnNo: ' + columnNo); // 异常列号
    console.log('error: ' + error); // 异常堆栈信息
};

console.log(a);
```
*  一个问题：跨域后，error事件无法正常捕获错误信息，统一返回Script Error事件。```解决方案便是script属性配置 crossorigin="anonymous" 并且服务器添加Access-Control-Allow-Origin。```
-  代码压缩后导致错误信息无法辨认，开启source-map
- 有些错误被框架或类库捕获，如React有componentDidCatch


