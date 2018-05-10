# rxjs 学习



### concatAll switch mergeAll
这些属于合并运算符。
concatAll

switch

mergeAll

### Subject BehaviorSubject ReplaySubject AsyncSubject

#### Subject
实现一个简单的Subject
```javascript
  const subject = {
    observables: [],
    subscribe(o) {
      this.observables.push(o);
    },
    map(...args) {
      this.observables.forEach(o => o.next(...args));
    }
    next(v) {
      this.map(v);
    },
    error(err) {
      this.map(err);
    }
    complete() {
      this.map();
    }
  }


  var source = Rx.Observable.interval(1000).take(3);
  var o1 = {
    next(e) {
      console.log("next1 " + e);
    },
    error(err) {
      console.log("error1 " + err);
    },
    complete() {
      console.log("complete1 ");
    }
  };

  var o2 = {
    next(e) {
      console.log("next2 " + e);
    },
    error(err) {
      console.log("error2 " + err);
    },
    complete() {
      console.log("complete2 ");
    }
  };
  subject.subscribe(o1);
  source.subscribe(subject);

  setTimeout(() => subject.subscribe(o2), 1000);


  // next1 0
  // next1 1
  // next2 1
  // next1 2
  // next2 2
  // complete1
  // complete2
```

React中的实践
```javascript
  class MyButton extends React.Component {
    constructor(props) {
        super(props);
        this.state = { count: 0 };
        this.subject = new Rx.Subject();

        this.subject
            .mapTo(1)
            .scan((origin, next) => origin + next)
            .subscribe(x => {
                this.setState({ count: x })
            })
    }
    render() {
        return <button onClick={event => this.subject.next(event)}>{this.state.count}</button>
    }
  }
```
#### BehaviorSubject

  强调当前值的概念， 构建时需要传一个初值

```javascript
  var subject = new Rx.BehaviorSubject(0); // 0是初始值

  subject.subscribe({
    next: (v) => console.log('observerA: ' + v)
  });

  subject.next(1);
  subject.next(2);

  subject.subscribe({
    next: (v) => console.log('observerB: ' + v)
  });

  subject.next(3);

  // observerA: 0
  // observerA: 1
  // observerA: 2
  // observerB: 2
  // observerA: 3
  // observerB: 3
```

#### ReplaySubject

  缓存几个值，构建时传入一个数字。会为每一个观察者都记录n个值。依次输出
```javascript
  var subject = new Rx.ReplaySubject(2); // 重複發送最後 2 個元素
  var observerA = {
      next: value => console.log('A next: ' + value),
      error: error => console.log('A error: ' + error),
      complete: () => console.log('A complete!')
  }

  var observerB = {
      next: value => console.log('B next: ' + value),
      error: error => console.log('B error: ' + error),
      complete: () => console.log('B complete!')
  }

  subject.subscribe(observerA);
  subject.next(1);
  // "A next: 1"
  subject.next(2);
  // "A next: 2"
  subject.next(3);
  // "A next: 3"

  setTimeout(() => {
      subject.subscribe(observerB);
      // "B next: 2"
      // "B next: 3"
  },3000)
```

### AsyncSubject

类似promise。在complete之后。才吐出最后一个值。好像这个没啥用啊。
```javascript
  var subject = new Rx.AsyncSubject();
  var observerA = {
      next: value => console.log('A next: ' + value),
      error: error => console.log('A error: ' + error),
      complete: () => console.log('A complete!')
  }

  var observerB = {
      next: value => console.log('B next: ' + value),
      error: error => console.log('B error: ' + error),
      complete: () => console.log('B complete!')
  }

  subject.subscribe(observerA);
  subject.next(1);
  subject.next(2);
  subject.next(3);
  subject.complete();
  // "A next: 3"
  // "A complete!"

  setTimeout(() => {
      subject.subscribe(observerB);
      // "B next: 3"
      // "B complete!"
  },3000)
```
