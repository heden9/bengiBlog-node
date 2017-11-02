# vue入门

很好奇，一个专注react的人突然学起了vue，万物都是相同的。
## mvvm 数据双向绑定


### 入门
```javascript
    var vim = new Vue({
        el: '#app',
        data: { // model
            message: 'hello'
        }
    });

    console.log(vim);
```
### v-if
dom结构中找不到
```javascript
```
### v-else/v-else-if


### v-show
只是改变`display`属性
`v-if` 是“真正”的条件渲染，因为它会确保在切换过程中条件块内的事件监听器和子组件适当地被销毁和重建。
`v-if` 也是惰性的：如果在初始渲染时条件为假，则什么也不做——直到条件第一次变为真时，才会开始渲染条件块。
相比之下，`v-show` 就简单得多——不管初始条件是什么，元素总是会被渲染，并且只是简单地基于 CSS 进行切换。
一般来说，`v-if` 有更高的切换开销，而 `v-show`有更高的初始渲染开销。因此，如果需要非常频繁地切换，则使用 `v-show` 较好；如果在运行时条件很少改变，则使用 `v-if` 较好。

### v-for
```javascript
    <div v-for="(item, index) in items"></div>
    <div v-for="(val, key) in object"></div>
    <div v-for="(val, key, index) in object"></div>
```
`v-for` 默认行为试着不改变整体，而是替换元素。迫使其重新排序的元素，你需要提供一个 `key` 的特殊属性：
```javascript
    <div v-for="item in items" :key="item.id">
    {{ item.text }}
    </div>
```
和react中的key非常类似

### v-text

更新元素的 `textContent`。如果要更新部分的 `textContent`，需要使用 `{{ Mustache }}` 插值。

### v-html
更新元素的 innerHTML 。注意：内容按普通 HTML 插入 - 不会作为 Vue 模板进行编译 。如果试图使用 v-html 组合模板，可以重新考虑是否通过使用组件来替代。

### v-on
```javascript
    // v-on:click
    // @click
    <div>{{count}}</div>
    <button v-on:click="add">click me</button>

    ...
    methods: {
        add: function () {
            console.log(arguments);
            this.count ++;
        }
        // add(){
        //     this.count++
        // }
    }
```
### 传参和拿到事件源
```html
    <!-- 方法处理器 -->
    <button v-on:click="doThis"></button>
    <!-- 对象语法 (2.4.0+) -->
    <button v-on="{ mousedown: doThis, mouseup: doThat }"></button>
    <!-- 内联语句 -->
    <button v-on:click="doThat('hello', $event)"></button>
    <!-- 缩写 -->
    <button @click="doThis"></button>
    <!-- 停止冒泡 -->
    <button @click.stop="doThis"></button>
    <!-- 阻止默认行为 -->
    <button @click.prevent="doThis"></button>
    <!-- 阻止默认行为，没有表达式 -->
    <form @submit.prevent></form>
    <!--  串联修饰符 -->
    <button @click.stop.prevent="doThis"></button>
    <!-- 键修饰符，键别名 -->
    <input @keyup.enter="onEnter">
    <!-- 键修饰符，键代码 -->
    <input @keyup.13="onEnter">
    <!-- 点击回调只会触发一次 -->
    <button v-on:click.once="doThis"></button>
```

### v-model
修饰符
.lazy 失焦
.number 转数字
.trim 去前后空格


### v-bind/:
绑定属性


### v-cloak


### v-once