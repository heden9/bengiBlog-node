# sass
sass使用ruby编写。
- .sass后缀的延续了ruby的一些语法，没有大括号和分号。
采用严格的缩进进行控制。
```javascript
	$color: #f00;
	#div1 
		background-color: $color;
```
- .scss后缀的书写方式和传统css非常类似
```javascript
	$color: #f00;
	#div1 {
		background-color: $color;
	}
```
## 1.sass的安装，Windows环境下需要安装ruby的环境，(记得配置环境变量并重启),mac下自带ruby环境。
## 2.sass的常用命令
```javascript
	sass [--watch] (sass文件路径):(css文件路径) [--style] [compressed(压缩)] [compact(紧凑)] [expanded(展开)] [nested(嵌套)]
```
使用watch命令后，保存及会修改生成的css文件
## 3.sass的基本语法
#### 1.声明变量
```javascript
	$color: #f00;
```
与php的声明方式类似。
#### 2.后代选择器
```javascript
	.aa {
		color: red;
		.bb {
			color: green;
		}
	}

	// 转换为

	.aa {
		color: red;
	}
	.aa .bb {
		color: green;
	}
```
所有的后代选择器都类似
#### 3.父选择器的标识符&
拿到父选择器的名字
```javascript
	.aa {
		&:hover{
			color: red;
		}
		&-bb{
			color: green;
		}
	}
	// 转换为
	.aa {}
	.aa:hover { 
		color: red;
	}
	.aa-bb{
		color: green;
	}
```
#### 4.嵌套属性
```javascript
	.aa {
		background:{
			color: red;
		}
		border: {
			bottom:{
				color:red;
			}
		}
	}
```
#### 5.将变量作为属性名
```javascript
	$width: width;
	#div1{
		#($width): 200px;
	}
```
#### 6.mixin 混合
```javascript
	@mixin foo($bg: red){ // 若不传参数，则省略括号
		width: 200px;
		height: 200px;
		background: $bg;
	}
	#div1 {
		@include foo;
	}
	#div2 {
		@include foo(green);
	}
```
#### 7.@extend
```javascript
	#div4 {
		@extend #div1;
	}
```
会将子选择器的