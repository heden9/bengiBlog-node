# es6 之 async
推荐不了解Generator的童鞋回去看看上篇文章。
## 浅析async和Generator的关系
### async是Generator的语法糖
经典的Generator函数写法
```javascript
    const readFile = function(fileName, codeType) {
        return new Promise((resolve, reject) => {
            fs.readFile(fileName, codeType, (err, data) => {
                if(err) reject(err);
                resolve(data);
            })
        })
    }
    function* gen(){
        const r1 = yield readFile('data1.json', 'utf-8');
        console.log(r1);
        const r2 = yield readFile('data2.json', 'utf-8');
        console.log(r2);
    }
```
以上代码基于Promise，但执行还需要co模块。随着es7草案迎来了async/await，代码就变成
```javascript
    async function gen(){
        const r1 = await readFile('data1.json', 'utf-8');
        console.log(r1);
        const r2 = await readFile('data2.json', 'utf-8');
        console.log(r2);
    }
```
async修饰的函数，内置执行器，只需要```gen()```, 就相当于上方代码的```co(gen)```。
是不是很简单，语义也很清晰。async修饰，表示该函数是一个异步函数，await表示该方法需要等待返回。哈哈，
比起yield和*，瞬间感觉亲近了很多。
总结一下，async具有以下特点
- 1.内置执行器。
- 2.更好的语义。
- 3.更广的适用性。
- 4.返回值是 Promise。
- 5.不再支持thunk函数啦，只能跟Promise。

原来thunk函数只是一个过渡方案呀。我们费了好大的力气来学习他，结果发现最新的语法已经不支持thunk函数了，呜呜呜...
不过，在学习thunk函数的过程中，我们也收获了很多呀。
在这里引用王福朋老师的一句话
> 因此，Promise才是异步的终极解决方案和未来

回顾一下javascript异步编程的发展历史：
- 1.回调嵌套
```javascript
    fs.readFile('data1.json', (err, data) => {
        fs.readFile('data2.json', (err, data) => {
            fs.readFile('data3.json', (err, data) => {
                fs.readFile('data4.json', (err, data) => {

                })
            })
        })
    })
```

- 2.Promise
```javascript
    readFilePromise('data1.json').then(data => {
        return readFilePromise('data2.json')
    }).then(data => {
        return readFilePromise('data3.json')
    }).then(data => {
        return readFilePromise('data4.json')
    })
```
- 3.Generator
```javascript
    co(function* () {
        const r1 = yield readFilePromise('data1.json')
        const r2 = yield readFilePromise('data2.json')
        const r3 = yield readFilePromise('data3.json')
        const r4 = yield readFilePromise('data4.json')
    })
```
- 4.async/await
```javascript
    async function gen(){
        const r1 = await readFilePromise('data1.json');
        const r2 = await readFilePromise('data2.json');
        const r3 = await readFilePromise('data3.json');
        const r4 = await readFilePromise('data4.json');
    }
```
可以看出来的是，代码越来越简洁，语义越来越清晰。
语言正在向着尽量简单易懂的方向发展，毕竟也是没有人喜欢复杂繁琐的东西的嘛：）