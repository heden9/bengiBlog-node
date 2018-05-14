# py学习指南


### 元组 tuple
元组是python中参数传递的一种有效方式。可以作为函数的返回值。
直接类比js中的解构
```python
  def exchange(a, b):
    return b, a

  a, b = exchange(1, 2)
```
```javascript
  function exchange(a, b){
    return [b, a]
  }
  var [a, b] = exchange(1, 2)
```
### 字典 dictionary
就是js中的对象

### 函数参数表
```python
  def f1(a, b, c=0, *args, **kw): # 第四个参数，并且没有参数名，就会被置入args
    print('a =', a, 'b =', b, 'c =', c, 'args =', args, 'kw =', kw)


  def f2(a, b, c=0, *, d, **kw): # *之后的参数，寻找到函数内部同名参数
    print('a =', a, 'b =', b, 'c =', c, 'd =', d, 'kw =', kw)
```

### 参数传递
python中函数接受可变参数（直接是js中的arguments）。带一个星号即可。

```python
  def bar(*numbers):
    return
```
元组打碎传入函数参数。```*```
```python
  tuple = (1, 2, 3, 4)
  def bar(*tuple):
    print(*tuple)
  bar(*tuple)
```
字典打碎传入函数参数。```**```
```python
  dict = { 'name': 'str', 'age': 12 }
  def bar(**dict):
    print(dict)
  bar(**dict)
```
