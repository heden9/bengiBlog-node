### immutable-js 简介

immutable-js 使用了另一套数据结构的 API ，与我们的常见操作有些许不同，它将所有的原生对象都会转化成 immutable-js 的内部对象，并且任何操作最终都会返回一个新的 immutable 的值。

```js
const { fromJS } = require('immutable')
const data = {
  val: 1,
  desc: {
    text: 'a',
  },
}
const a = fromJS(data)
const b = a.set('val', 2)
console.log(a.get('val')) // 1
console.log(b.get('val')) // 2
const pathToText = ['desc', 'text']
const c = a.setIn([...pathToText], 'c')
console.log(a.getIn([...pathToText])) // 'a'
console.log(c.getIn([...pathToText])) // 'c'

```

对于性能方面，immutable-js 也有它的优势，举个简单的例子：

```js
const { fromJS } = require('immutable')
const data = {
  content: {
    time: '2018-02-01',
    val: 'Hello World',
  },
  desc: {
    text: 'a',
  },
}
const a = fromJS(data)
const b = a.setIn(['desc', 'text'], 'b')
console.log(b.get('desc') === a.get('desc'))       // false
console.log(b.get('content') === a.get('content')) // true
const c = a.toJS()
const d = b.toJS()
console.log(c.desc === d.desc)       // false
console.log(c.content === d.content) // false
```

从上面的例子可以看出来，在 immutable-js 的数据结构中，深层次的对象在没有修改的情况下仍然能够保证严格相等。这里的严格相等就可以认为是没有新建这个对象，仍然在内部保持着之前的引用，但是修改却不会同步的修改。

经常使用 React 的同学肯定也对 immutable-js 不陌生，这也就是为什么 immutable-js 会极大提高 React 页面性能的原因之一了。

### immer
与 immutable-js 最大的不同，immer 是使用原生数据结构的 API 而不是内置的 API，举个简单例子：

```js
const produce = require('immer')
const state = {
  done: false,
  val: 'string',
}
const newState = produce(state, (draft) => {
  draft.done = true
})
console.log(state.done) // false
console.log(newState.done) // true
```

### immer 原理解析

其实纵观 immer 的实现，核心的原理就是放在了对对象读写的劫持，从表现形式上立刻就能让人想到 vue ，mobx 从核心原理上来说也是对对象的读写劫持，最近有另一篇非常火的文章 -- 如何让 (a == 1 && a == 2 && a == 3) 为 true，也相信不少的小伙伴读过，除了那个肉眼不可见字符的答案，其他答案也算是对对象的读写劫持从而达到目标。
