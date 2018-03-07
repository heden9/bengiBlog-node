# 了解http

http:  包头、包体

包头： 请求头、响应头

包体：

accept：接受什么格式的
accept-encoding：压缩方式
cache-control：缓存设置
content-type：包体的格式 text/html
content-length：包体的长度

http版本 0.9 1 2 常用的1.1
模拟http请求：

请求行（请求方法、请求路径、请求协议）
请求方法： GET/ POST/ PUT/ DELETE/ HEAD/ OPTIONS/ TRACE

GET 所有的信息都放在url上

```
    GET /http1/test.php HTTP/1.1
    Host:localhost
```

请求头信息

请求头主体信息

响应头信息 status code 200


HEAD和GET基本一致，发送请求不返回请求地址的内容

有的服务器不支持PUT，报错
Method not allowed 405

OPTIONS 返回服务器可用的方法
cookie httponly 可以预防xss攻击



302  临时重定向


301  永久重定向


307  http/1.1  类似临时重定向


TRACE  如果你是用代理上网的  看到代理有没有修改你的请求


DELETE  删除服务器上的资源


1xx 保留字

2xx 成功

3xx 重定向（301，302）

4xx 客户端请求错误

5xx 服务器错误



手机端通常采用前端渲染

-   减少http连接
-   减少回传数据的大小  前端渲染ok，打包ok
-   优化http头

304 确定当前浏览器缓存里面的内容有没有被改变  时间、文件
last-modify：服务器上的文件，最后被改动的时间
etag：是一个类似文件hash的东西，数据摘要算法

服务器上的文件被打开了，打了个空格，又消掉了，改动时间是发生了变化的。

请求头        |  响应头|
-------------|------|
if-none-match |  etag|
if-modified-since|  date|


如果比对无误，返回304，使用协议缓存


php中
```php
    <?php
        header('location:http://www.baidu.com')
    ?>
```
header跳转，是包头跳转，先执行

```javascript
    location = 'http://www.baidu.com'
```
script中js代码跳转，是包体跳转，是发起了一次正常的GET请求



```php
    <?php
        header('location:http://www.baidu.com', true, 301)
    ?>
```

#### 301 和 302 的区别

他是给robots.txt看的

搜索引擎优化 SEO
a跳转到b
搜索引擎看到你是302，那么a的内容依旧要访问
但是如果是301，那么a的内容爬虫就不爬了


#### 307来了
307能够把重定向的数据带到新的页面



#### 盗链问题

referer  标记请求来自哪里

判断referer必须指向host，可以解决

Apache 重写模块 mod_rewrite
.htaccess
