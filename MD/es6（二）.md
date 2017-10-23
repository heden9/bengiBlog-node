# es6（二）
> ECMAScript 6.0（以下简称 ES6）是 JavaScript 语言的下一代标准，已经在2015年6月正式发布了。它的目标，是使得 JavaScript 语言可以用来编写复杂的大型应用程序，成为企业级开发语言。

* es6在2017年可谓是大火，被越来越多的人频频提及，在React、ReactNative开发中广泛使用。javascript在es6的推出后，是越来越健全，真不能认为它是一个"玩具语言"啦。haha
较为深入的学习es6是非常有必要的，我总结了一些es6相关的语法特性及较为详细的使用说明，其中还有一些学习心得，希望可以给大家带来帮助。

### 一、解构赋值
#### 1.数组的解构
数组下标顺序对应
```javascript
    var [a, b, c] = [1, 2, 3];
    console.log(a, b, c); // 1, 2, 3
```
还可以不完全解构
```javascript
    var [a, , c] = [1, 2, 3];
    console.log(a, c); // 1, 3
```
适用于嵌套解构
```javascript
    var [a, b, c, d] = [1, 2, 3, [4, 5]];
    console.log(a, b, c, d); // 1, 2, 3, [4, 5];
```
```javascript
    var [a, b, c, [d, e]] = [1, 2, 3, [4, 5]];
    console.log(a, b, c, d, e); // 1, 2, 3, 4, 5;
```
配合rest运算符，可将数组末尾元素都收集起来，**只能放在末尾**
```javascript
    var [a, b, c, ...d] = [1, 2, 3, 4, 5];
    console.log(a, b, c, d); // 1, 2, 3, [4, 5];
```
只要右边是可遍历解构（数组，迭代器，类数组）都能够结构成功。
#### 2.对象的解构
变量属性名对应
```javascript
    var {a, b, c} = {a: 1, b: 2, c: 3};
    console.log(a, b, c); // 1, 2, 3
```
还可以设置模式（别名）
```javascript
    var {a: A, b: B, c: C} = {a: 1, b: 2, c: 3};
    console.log(A, B, C); // 1, 2, 3
```
这时候a, b, c分别是"模式"，解构去匹配符合格式的对象结构。它先找到同名属性，然后再赋值给对应的变量。
真正被赋值的是后面的A、B、C，所以A、B、C 也可以称作a、b、c的别名。
这有一个特殊情况
```javascript
    let a = 2;
    ({a} = {a: 1}) // 不能写成 {a} = {a: 1}
    console.log(a) // 1
```

如果有一个变量前面定义过，现在想给他重新赋值，就需要把```{a} = {a: 1}```用小括号包裹起来，这个是js解析引擎的一个问题
#### 3.字符串的解构
```javascript
    let {a, b, c} = 'hello';
    console.log(a, b, c) // 'h', 'e', 'c'
```
字符串也可看作是特殊的数组, 满足所有数组的操作
#### 4.可设置初始值
```javascript
    let {a, b, c, d = 5} = {a: 1, b: 2, c: 3};
    console.log(a, b, c, d) // 1, 2, 3, 3
```
数组也是一样的
#### 5.复杂的解构操作
```javascript
    let obj = {
        bar: 'xxx',
        foo: {
            arr: [
                'hello',
                {a: 1}
            ],
            baz: 1
        }
    }
    let { foo: { arr: [x, {a}], baz}, bar} = obj;
    console.log(x, a, baz, bar); // 'hello', 1, 1, 'xxx'
```
hah, 是不是很绕，面对这种复杂结构的解构，我们只要记住一句话
> 数组找下标，对象找同名属性

就ok啦。
#### 6.解构在函数参数中的使用
```javascript
    function foo({a, b, c, d=2}){
        console.log(a, b, c, d); // 1, 2, 3, 2
    }
    foo({a: 1, b: 2, c: 3});
```
其实理解了数组和对象的解构，在哪都能灵活运用啦。
#### 7.交换变量的值
```javascript
    var a = 1, b = 2;
    [b, a] = [a, b];
```
### 二、扩展运算符(spread)和rest运算符
扩展运算符(spread)也叫圆点运算符(...)，他的作用是，遍历目标对象，输出所有结果。
所以只要是能够遍历的数据结构如（数组、类数组、迭代器、对象），都能够使用(...)进行操作。
#### 1.数组/对象浅拷贝
```javascript
    let arr = [1, 2, 3, 4];
    let newArr = [...arr];
    console.log(arr === newArr); // false
    let obj = { a: 1, b: 2};
    let newObj = { ...obj};
    console.log(obj === newObj); // false
```
利用圆点操作符，可以快速进行浅拷贝，非常的优雅。
但对于复杂的对象、数组结构，该操作无法拷贝深层的数据，所以强调这只是**浅拷贝**。
#### 2.合并数组、对象
```javascript
    let arr1 = [1, 2];
    let arr2 = [3, 4];
    let newArr = [...arr1, ...arr2];
    console.log(newArr); // 1, 2, 3, 4
    let obj1 = { a: 1, b: 2};
    let obj2 = { a: 3, c: 2};
    let newObj = { ...obj1, ...obj2};
    console.log(newObj); // { a: 3, b: 2, c: 2};
```
由此就可以引申出各种神奇操作，还需要我们在平时慢慢摸索，在这里就不一一介绍了。
#### 3.rest运算符
rest运算符实质上相当于spread的反例，不知道还记不记得上面的一个例子
```javascript
    function foo(...arg){
        console.log(arg); // 相当于arguments
    }
```
可以知道rest实质上就是把剩余参数作为数组元素收集起来
### 三、字符串扩展方法
#### 1.模板字符串
使用反引号(``)，可以保留字符串的格式，空格回车，使用(${})来引入变量
```javascript
    // 模板字符串
    var a = 1;
    var str = `sss
    hello world${a}`;
    // 普通字符串
    var a = 1;
    var str = 'sss'
    + 'hello world' + a;
```
#### 2.includes 、startsWidth、endsWidth
传统上，javascript中只有indexOf方法可以用来确定两个字符串的包含关系，es6提出了三个方法来帮助我们分析两个字符串的关系
1. includes    : 返回布尔值，表示是否找到了参数字符串
2. startsWidth : 返回布尔值，表示参数字符串是否在源字符串的头部
3. endsWidth   : 返回布尔值
```javascript
    var s = 'hello world!';
    s.includes('lo wo'); // true
    s.startsWidth('he'); // true
    s.endsWidth('d!'): // true
```
他们还包含第二个参数，表示开始搜索的位置。
```javascript
    var s = 'hello world!';
    s.includes('world', 6); // false
    s.startsWidth('world', 6); // true
    s.endsWidth('world', 5): // true
```
#### 3.padStart、padEnd
padStart(n, s);
表示在目标字符串头、尾不停插入字符串s，并使插入完成后的字符串长度为n
```javascript
    'x'.padStart(8, 'ab'); // 'abababax'
    'x'.padEnd(2, 'ab'); // 'xab'
```
- 如果原字符串的长度大于指定的n的长度，则会返回原字符串
- 如果第二个参数的默认值为空格
#### 4.repeat
repeat(n)
表示将目标字符串重复n此，并将他作为结果返回
```javascript
    'x'.repeat(5); // 'xxxxx'
```
### 四、Number的扩展
#### 1.进制转换
在之前的版本，进制转换通常用
```javascript
    let num = 5;
    console.log(num.toString(2)); // 十进制转换为二进制

    let num2 = 101;
    console.log(parseInt(num2, 2)); // 二进制转换为十进制
```
这些写法非常的不好记而且麻烦，现在es6为我们提供了一些新方法
```javascript
    let num3 = 0B101; // 表示二进制 0B 或 0b
    let num4 = 0O101; // 表示八进制 0O 或 0o
```
#### 2.Number.isFinite
isFinite 用来检查 是否**非无穷**
```javascript
    Number.isFinite(5); // true
    Number.isFinite('5'); // false
    Number.isFinite(Infinity); // false
```
#### 3.es6一些方法被移植到Number对象上
如 isNaN、parseInt、parseFloat、isInteger
行为完全不变，这样做的目的，是逐步减少全局性方法，使语言逐步模块化。
#### 4.安全整数和Number.isSafeInteger
js能够准确表示的整数范围在-2^53 到 2^53 之前（不包含两个端点）
```javascript
    Number.MAX_SAFE_INTEGER; // 9007199254740991
    Number.MIN_SAFE_INTEGER; // -9007199254740991
```
#### 5.Math中新增非主流方法
```javascript
    Math.trunc(5.5); // 取整 5
    Math.sign(5); // 1
    Math.sign(0); // 0
    Math.sign(-5); // -1
```
sign用来判断是否为正数、负数、零。
### 五、函数的扩展
箭头函数单独拎出来提过啦
所以说说别的
#### 1.参数默认值
```javascript
    function foo(x=5, y){
        // 传入的参数只要等于undefined或者不传入参数，就会取走默认值
    }
```
配合解构赋值食用风味更佳
#### 2.```foo.length```返回的是没有默认值的参数的个数
#### 3.```foo.name```返回的是函数的名字
#### 4.严格模式（use strict）
- ES6:规定只要函数参数使用了默认值、解构赋值、或者扩展运算符，那么函数内部就不能显式设定为严格模式， 否则会报错。
1. 全局变量必须显示声明
2. 禁止this关键字指向全局对象 构造函数必须new
```javascript
    'use strict';
    function People(name, age){
        this.name = name;
        this.age = age;
    }
    People('lisi', 18); // Cannot set property 'name' of undefined
```
3. 对象不能有重复属性
4. 函数不能有重名参数
5. 禁止使用with
```javascript
    'use strict';
    let a = 1;
    let b = {
        a: 2
    }
    with(b){
        console.log(a);
    }
    // strict mode code may not include a with statement
```
6. 禁止使用arguments.callee
### 五、数组的扩展
#### 1.Array.from
Array.from方法用于将两类对象转为真正的数组：类似数组的对象（array-like object）和可遍历（iterable）的对象（包括ES6新增的数据结构Set和Map）。
##### 类数组的对象
```javascript
    let arrayLike = {
        '0': 'a',
        '1': 'b',
        '2': 'c',
        length: 3
    };

    // ES5的写法
    var arr1 = [].slice.call(arrayLike); // ['a', 'b', 'c']

    // ES6的写法
    let arr2 = Array.from(arrayLike); // ['a', 'b', 'c']
```
##### NodeList 转化为数组的方法
```javascript
    let ps = document.querySelectorAll('p'); // NodeList 类型 类数组
    let arr = [...ps];
    let arr2 = Array.from(ps);
    let arr3 = [].slice.call(ps); // 实例方法
    //  arr3 = Array.prototype.slice.call(ps); // 类方法
    let arr4 = arr4.constructor;
```

#### 2.Array.of
将一堆元素转化为数组
```javascript
    let arr = new Array(1,2,3,4); // [1,2,3,4]
    let arr2 = new Array(3); // [empty × 3]
    let arr3 = Array.of(3); // [3]
```
#### 3.copyWithin
1. target（必需）：从该位置开始替换数据。
2. start（可选）：从该位置开始读取数据，默认为0。如果为负值，表示倒数。
3. end（可选）：到该位置前停止读取数据，默认等于数组长度。如果为负值，表示倒数。
```javascript
    [1, 2, 3, 4, 5, 6].copyWithin(0, 3, 4); // 4, 2, 3, 4, 5, 6
```
#### 4.find 和 findIndex
find用于找出第一个符合条件的数组成员。
```javascript
    [1, 2, 3, 4, 5, 6].find((item, key, arr) => (item > 3)) // 4
```
findIndex返回第一个符合条件的数组成员的位置，如果所有成员都不符合条件，则返回-1。
```javascript
    [1, 2, 3, 4, 5, 6].find((item, key, arr) => (item > 3)) // 4
```
#### 5.includes 与 字符串的类似
#### 6.entries，keys 和 values 与迭代器的类似
entries 可用next()执行, 适用于不规则输出的情况
```javascript
    let letter = ['a', 'b', 'c'];
    let entries = letter.entries();
    console.log(entries.next().value); // [0, 'a']
    cosole.log(123);
    console.log(entries.next().value); // [1, 'b']
    cosole.log(456);
    console.log(entries.next().value); // [2, 'c']
```
#### 7.for of遍历
```javascript
    for(let item of arr){
        console.log(item); // 内容
    }
    for(let item of arr.keys()){
        console.log(item); // 索引
    }
    for(let [index, item] of arr.entries()){
        console.log(item, index); // 内容 + 索引
    }
```
#### 8.其他遍历方法
1. forEach():没有返回值，只是针对每个元素调用func
2. map():返回一 个新的Array，每个元素为调用func的结果
3. filter():返回一个符合func条件的元素数组
4. some():返回一个boolean，判断是否有元素是否符合func条件
5. every():返回一个boolean，判断每个元素是否符合func条件