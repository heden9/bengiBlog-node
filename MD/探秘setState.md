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
我在第一次写出这样的代码的时候，也很诧异，为啥不能得到正确的`state`的啊！百思不得其解.....:(

后来查了资料才发现...`setState`是一个异步的方法。这真的很难发现。
### 二、setState合并更新
先来看看setState的更新机制:
>   setState 通过一个队列机制实现 state 更新。当执行 setState 时，会将需要更新的 state 合并 后放入状态队列，而不会立刻更新 this.state，队列机制可以高效地批量更新 state。

可以看到React很智能的帮我们把setState的操作都收集起来，集中处理，妈妈再也不用担心我们写出以下代码来影响性能：
```javascript
    this.setState({
        val: '123'
    });
    this.setState({
        val: '456'
    })
```
他会将上述多个`setState`操作合并为一个`setState`，我们称之为`批量更新 batchedUpdates`，如果我们在`render`中控制台输出的话，可以发现其实只触发了一次`render`方法。视图只更新了一次，由此可验证`setState`被合并了。

还有这种操作：
```javascript
   // sum 1
    for(let i = 0; i < 4; i ++){
      this.setState({
        sum: i + this.state.sum
      })
    }
```
`render`方法也只会触发一次，并且修改后的`sum`值为4，对于同一个state的修改都会被后面的覆盖。

>   注意一点，在`render`方法调用前，`state`是都不会更新的。

这点真的是做的非常好呀，想想看上面这两种情况完全可以用一次`setState`操作来完成。就算我们是新手，React也尽量的为我们考虑了很多....是吧 :)


来看一下setState之后的流程
