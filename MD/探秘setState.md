# 探秘setState

### 一、setState是异步的
首先我们明确一点，setState是异步的方法。（不能保证是同步的），相信各位都写过这样的代码。
```javascript
    state = {
        val: '456'
    };
    ...
    ...
    componentDidMount(){
        this.setState({
            val: '123'
        });
        console.log(this.state.val);  // '456'
    }
```
我在第一次写出这样的代码的时候，也很诧异，为啥不能得到正确的`state`的啊！百思不得其解.....😒

后来查了资料才发现...`setState`是一个异步的方法。这真的很难发现。
### 二、setState合并更新
先来看看setState的更新机制:
>   setState 通过一个队列机制实现 state 更新。当执行 setState 时，会将需要更新的 state 合并 后放入状态队列，而不会立刻更新 this.state，队列机制可以高效地批量更新 state。

可以看到React很智能的帮我们把setState的操作都收集起来，集中处理，妈妈再也不用担心我们写出以下代码来影响性能：
```javascript
    this.setState({
        val: '123'
    });
    this.setState({
        val: '456'
    })
```
他会将上述多个`setState`操作合并为一个，我们称之为`批量更新（batchedUpdates）`，如果我们在`render`中控制台输出的话，可以发现其实只触发了一次`render`方法。视图只更新了一次，由此可验证`setState`被合并了。

还有这种操作：
```javascript
   // sum 1
    for(let i = 0; i < 4; i ++){
      this.setState({
        sum: i + this.state.sum
      })
    }
```
`render`方法也只会触发一次，并且修改后的`sum`值为4，对于同一个state的修改都会被后面的覆盖。

>   注意一点，在`render`方法调用前，`state`是都不会更新的。

这点真的是做的非常好呀，想想看上面这两种情况完全可以用一次`setState`操作来完成。就算我们是新手，React也尽量的为我们考虑了很多....是吧 😄

但是这样也带来了问题。假如我们要用state的值，通过几步来计算一个结果，还得找个变量tmp给每次计算的结果存起来。十分的不优雅。有没有解决办法呢...有的，看下面的介绍。

先来看一下setState的执行过程
![setState](https://github.com/w771854332/bengiBlog-node/blob/master/public/screenshot/setState.png?raw=true)

看上去蛮复杂的把。其实简单的来看，setState被分为两种状态：
-   批量更新模式
-   普通更新模式

上面我们看到的例子就是处于批量更新模式，我们再来看一个例子：

```javascript
export default class App extends React.Component {
  state = {
    sum: 1
  };
  componentDidMount(){
    setTimeout(()=>{
      this.setState({
        sum: '123'
      })
      console.log('did',this.state.sum);
      this.setState({
        sum: '345'
      })
      console.log('did',this.state.sum);
    }, 0);

  }
  render(){
    console.log('render',this.state.sum)
    return (
      <div>{this.state.sum}</div>
    )
  }
}
```

ps：setTimeout时间设为0的意思就不提了
你猜控制台输出的结果是啥 😄


```javascript
    // render 1
    // render 123
    // did 123
    // render 345
    // did 345
```

好啦，这就是所谓的普通更新模式。意思也非常好理解，在同一个`执行栈`中的每个`setState`操作都会触发生命周期 -> 更新state并更新视图（确实是要等到render之时/后，才能拿到正确的state）

我们再来看一次那张图

![setState](https://github.com/w771854332/bengiBlog-node/blob/master/public/screenshot/setState.png?raw=true)

我们发现，React在一次`执行栈`中，会将所有的`setState`操作都压入`dirtyComponents`中，React会比较`dirtyComponents`的长度，进行`updateComponent`操作。进行生命周期方法。

针对`setTimeout`来说，他相当于新开了一个`Macrotask Queue`。这都是后话了。现在理解起来就是，`setTimeout`会跳出当前执行队列，没有前置的`batchedUpdate`的方法调用，在判断`是否处于批量更新模式`时，走向了右边。
### 二、setState其实没这么简单
既然`setState`是异步的方法，那么我们有没有办法拿到更改之后的state呢？ 答案是可以的。很简单，`setState`的第二个参数是一个回调函数。 😒...懵逼

如果没有人告诉你，恐怕怎样都想不到吧。。

```javascript
    this.setState({
        sum: '123'
    },()=>{
        console.log(this.state.sum); // '123'
    });
```
这样我们就可以拿到更改后的`state`，不过这个回调函数貌似没啥用。。。跟`componentDidUpdate`差不多嘛。如果我们想实现同步更新的话，也不用这种方法

```javascript
    setTimeout(()=>{
      this.setState({
        sum: '123'
      })
      console.log('did',this.state.sum);
      this.setState({
        sum: '345'
      })
      console.log('did',this.state.sum);
    }, 0);
```

这样就可以呀。。不过这种方式，会在视图上看到飞闪而过的中间结果，并不是一个好方法。

这是一种实现，还有一个你更想不到的事情

-----

`setState`接受一个函数作为参数，其实他应该是这样的
```javascript
    this.setState((prevState, nextProps)=>({
      ...prevState
    }))
```

有没有震惊的感觉...真是个大彩蛋啊

这个可不只是变一变写法这么简单 😄

```javascript
class App extends React.Component {
  state = {
    number: 1
  };
  clickHandle = () => {
    this.setState((prevState, nextProps)=>({
      number: prevState.number + 1
    }))
    this.setState((prevState, nextProps)=>({
      number: prevState.number + 1
    }))
    this.setState((prevState, nextProps)=>({
      number: prevState.number + 1
    }))
  };
  render(){
    return (
      <div>
        <span>{this.state.number}</span>
        <button onClick={this.clickHandle}>click me</button>
      </div>
    )
  }
}
```

猜一猜点击了`click me`之后会number是多少呢。
答案是4，这不就是我们梦寐以求的结果嘛。是不是有点意想不到，前面我们已经认定了state记不住，现在这画风变得有点快。而且视图只会更新一次哦。

这一连串的`setState`是如何合并的呢。

我仿佛看到了函数式编程中的`函子(Functor)`和`管道(pipe)`，我想React在把`setState`放入`dirtyCompoents`之前，应该也是用一个函子对他进行包装，在`updateComponents`时，应该是有一个类似`co`的自执行方法，对函子进行顺序调用😄，中间的过程变量都是不会丢的。嗯，这很函数式。

引用程墨老师的一段话
>   让setState接受一个函数的API设计很棒！因为这符合函数式编程的思想，让开发者写出没有副作用的函数，我们的increment函数并不去修改组件状态，只是把“希望的状态改变”返回给React，维护状态这些苦力活完全交给React去做。
[@程墨Morgan](https://www.zhihu.com/people/morgancheng/activities)


[《setState：这个API设计到底怎么样》](https://zhuanlan.zhihu.com/p/25954470)
