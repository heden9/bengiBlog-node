## 剑指offer test

二叉树的遍历
```javascript
  function preOrder(root){
    if (root){
      console.log(root.val);
      preOrder(root.left);
      preOrder(root.right);
    }
  }
```
非递归
```javascript
  function preOrder(root){
    var stack = [];
    stack.push(root);
    while(stack.length ！== 0){
      var node = stack.pop();
      console.log(node.val);
      node.left && stack.push(node.left);
      node.right && stack.push(node.right);
    }
  }
```
求二叉树的深度
```javascript
  function TreeDepth(pRoot){
    if (!pRoot){
        return 0;
    }
    var left = 1 + TreeDepth(pRoot.left);
    var right = 1 + TreeDepth(pRoot.right);

    return Math.max(left, right);
  }
```
### 1.查找
在一个二维数组中，每一行都按照从左到右递增的顺序排序，每一列都按照从上到下递增的顺序排序。请完成一个函数，输入这样的一个二维数组和一个整数，判断数组中是否含有该整数。

```javascript
  function Find(target, array){
    var len = array.length-1;
    var i = 0;
    while((len >= 0)&& (i < array[len].length)){
        if(array[len][i] > target){
            len--;
        }else if(array[len][i] < target){
            i++;
        }else{
            return true;
        }
    }
    return false;
  }
```

二分查找的策略
```
  [ 1, 2, 3, 4, 5 ]
  [ 6, 7, 8 ]
  [ 9, 10, 11, 23 ]
```
先从矩阵左下角开始（9数字位置），进行计算。

### 2.二叉树的重建
输入某二叉树的前序遍历和中序遍历的结果，请重建出该二叉树。假设输入的前序遍历和中序遍历的结果中都不含重复的数字。例如输入前序遍历序列{1,2,4,7,3,5,6,8}和中序遍历序列{4,7,2,1,5,3,8,6}，则重建二叉树并返回。

递归方法重建
```javascript
  function reConstructBinaryTree(pre, vin){
    if(!pre || !pre.length){
      return null;
    }

    var binaryTree = {
      val: pre[0]
    }

    for(var i = 0; i < pre.length; i++){
      if(pre[0] === vin[i]){
        binaryTree.left = reConstructBinaryTree(pre.slice(1, i+1), vin.slice(0, i+1));
        binaryTree.right = reConstructBinaryTree(pre.slice(i+1), vin.slice(i+1));
      }
    }
    return binaryTree;
  }
```

```javascript
  [1, 2, 4, 7, 3, 5, 6, 8] // 前序  中左右
  [4, 7, 2, 1, 5, 3, 8, 6] // 中序  左中右
```
因为二叉树中没有重复元素，可知目标元素 的left子集为：
-   1.中序序列中，相同元素的前面所有元素。即[4, 7, 2]
-   2.因为元素数量固定，所以可知 在 前序序列中 left元素子集为[2, 4, 7]
-   3.right的元素子集为[3, 5, 6, 8] 和 [5, 3, 8, 6]
可以按此递归下去


### 3.青蛙跳台阶🐸

一只青蛙一次可以跳上1级台阶，也可以跳上2级。求该青蛙跳上一个n级的台阶总共有多少种跳法。

找规律的方法发现，刚好是一个类斐波那契数列
```
  f = {
    n == 0: 0,
    n == 1: 1,
    n == 2: 2,
    else : f(n - 1) + f(n - 2)
  }
```
所以可用迭代法来接斐波那契数列
```javascript
  function jump(number){
    if (number <= 2) return number;
    var a, b, res;
    a = 1, b = 2;
    for (var i = 3; i<=number; i++){
      res = a + b;
      a = b;
      b = res;
    }

    return res;
  }
```


### 4.青蛙跳变形

一只青蛙一次可以跳上1级台阶，也可以跳上2级……它也可以跳上n级。求该青蛙跳上一个n级的台阶总共有多少种跳法。

```javascript
  function jump(number){
    return 1 << (--number);
  }
```
分析
> 因为有n级台阶，青蛙每次能够跳1、2、3、.... n级
  跳1级，剩下n-1级，跳法为f(n-1),
  跳2级，剩下n-2级，跳法为f(n-2),
  ....
  所以f(n)=f(n-1)+f(n-2)+...+f(1)
  因为f(n-1)=f(n-2)+f(n-3)+...+f(1)
  f(n)=2 * f(n-1)
  f(n)=2^(n-1)

### 5.矩阵覆盖
这又是一个斐波那契题

我们可以用2*1的小矩形横着或者竖着去覆盖更大的矩形。请问用n个2*1的小矩形无重叠地覆盖一个2*n的大矩形，总共有多少种方法？
如题。注意看矩阵是 2 * n的
```javascript
  [][][]...
  [][][]...
```
当矩阵宽度target = 0时， return 0
当target = 1时，return 1
当target = 2时，return 2
....
当target = n时，此时f(n)有两种case：
第一块竖着放：
```javascript
  [1][][]...
  [1][][]...
```
之后剩余的target宽度为n-1，于是f(n)=f(n-1)
第一块横着放：
```javascript
  [1][1][ ]...
  [ ][ ][ ]...
```
由于第一块横着放，决定了第二块也必须要横着放。所以剩余的target宽度就只能为n-2，于是f(n)=f(n-2);

于是综合两种case，f(n)=f(n-1)+f(n-2)

又是一个斐波那契数列。解法如下
```javascript
  function rectCover(number){
    // write code here
    if(number <=2) return number;
    var a = 1,b = 2, res;
    for(var i = 2; i<number; i++){
      res = a + b;
      a = b;
      b = res;
    }
    return res;
  }
```

### 5.输入一个链表，输出该链表中倒数第k个结点。

```javascript
  function FindKthToTail(head, k){
    // write code here
    k --;
    var head2;
    var currentHead = head;
    if (k===0 && !head.next){
        return head;
    }
    var i = 0;
    while(head){
        if(i === k){
            head2 = currentHead;
        }else if (head2){
            head2 = head2.next;
        }
        head = head.next;
        i++;
    }
    return head2;
  }
```

### 6.逆置链表

明确引用类型
```javascript
  function ReverseList(pHead){
      // write code here
      var a1 = pHead;
      var a2 = null, temp = null;
      while(a1){
          temp = a1.next;
          a1.next = a2;
          a2 = a1;
          a1 = temp;
      }
      return a2;
  }
```

### 6.链表合并
按照升序合并两个链表
```javascript
  function Merge(pHead1, pHead2){
    // write code here
    if (pHead1 === null){
        return pHead2;
    }
    if (pHead2 === null){
        return pHead1;
    }
    if(pHead1.val < pHead2.val){
        pHead1.next = Merge(pHead1.next, pHead2);
        return pHead1;
    }else {
        pHead2.next = Merge(pHead1, pHead2.next);
        return pHead2;
    }
  }
```

### 7.判断b树是a树的子树

```javascript
  function HasSubTree(root1, root2){
    if (!root1 || !root2){
      return false;
    }
    return isSubTree(root1, root2) || isSubTree(root1.left, root2) || isSubTree(root1.right, root2);
  }

  function isSubTree(root1, root2){
    if (!root2){ // 若b子树为空
      return true;
    }
    if (!root1){
      return false;
    }
    if (root1.val == root2.val){
      return isSubTree(root1.left, root2.left) && isSubTree(root1.right, root2.right);
    }else {
      return false;
    }
  }
```


### 8.反转二叉树

```javascript
  function Mirror(root){
    if (!root){
      return null;
    }
    var left = root.left;
    root.left = Mirror(root.right);
    root.right = Mirror(left);
    return root;
  }
```

### 6.判断栈的出栈序列是否合法

```JavaScript
  function IsPopOrder(pushV, popV){
    var stack = [];
    var di = 0;
    for(var i = 0; i < pushV.length; i++){
      // 开始入栈，直到栈顶元素等于出栈序列的第一个。 然后直接出栈
      stack.push(pushV[i]);
      while(stack.length && stack[stack.length - 1] == popV[di]){
        stack.pop();
        di ++;
      }
    }
    return stack.length === 0;
  }
```

### 7.二叉树的层序遍历
利用队列

```javascript
  function PrintFromTopToBottom(root){
      var stack = [];
      var log = [];
      root && stack.push(root);
      while (stack.length !== 0){
          var node = stack.shift();

          node.left && stack.push(node.left);
          node.right && stack.push(node.right);
          log.push(node.val)
      }
      return log;
  }
```

### 8.求两个链表的第一个公共节点
两个链表有公共节点
```
  1
   \  y
    2 - 3 - 4
   /    z
  2  x
 /
1
```
可以看出来，两个指针走的步数是相同的。两个指针加起来 x + y + z 总步数刚好能相同。
所以我们让p1走到头后，就往pHead2上走。p2走到头后往pHead1上走。他们就一定能在公共节点处回合。
```javascript
  function FindFirstCommonNode(pHead1, pHead2){
    var p1 = pHead1;
    var p2 = pHead2;
    while(p1 !== p2){
      p1 = p1 ? p1.next : pHead2;
      p2 = p2 ? p2.next : pHead1;
    }
    return p1;
  }
```

#### 判断链表是否有环
两个指针从头开始，一个走两步，一个走一步。等到走两步的追上走一步的指针后。就能证明链表有环。
```
  1 - 1 - 1 - 2 - 3
     x    |        \
          8         4
          |        /
          7 - 6 - 5
```
设链表在第x个节点处产生环。环内有n个节点。在距交点 y处相遇。
可得公式 2（X + N + Y）= X + 2N - Y
可知 X = Y

### 求1+2+3+...+n
求1+2+3+...+n，要求不能使用乘除法、for、while、if、else、switch、case等关键字及条件判断语句（A?B:C）。
```javascript
function Sum_Solution(n){
    // write code here
    var res = n;
    return res && (res += Sum_Solution(n - 1)), res;
}
```
