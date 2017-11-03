# easyWrite

[![React](https://img.shields.io/badge/react-^15.4.0-brightgreen.svg?style=flat-square)](https://github.com/facebook/react)
[![Ant Design](https://img.shields.io/badge/ant--design-^2.13.3-yellowgreen.svg?style=flat-square)](https://github.com/ant-design/ant-design)
[![dva](https://img.shields.io/badge/dva-^1.2.1-orange.svg?style=flat-square)](https://github.com/dvajs/dva)

[![MIT](https://img.shields.io/dub/l/vibe-d.svg?style=flat-square)](http://opensource.org/licenses/MIT)
[![js-standard-style](https://img.shields.io/badge/code%20style-standard-brightgreen.svg)](http://standardjs.com)
演示地址 <http://mgq.jblog.info>


### 前言 

这是一个智能填写表格的系统，通过教师基础信息的采集，以及日常科研信息的录入，来扩充知识储备。在往后填表的过程中，先分析表格，再自动填充可识别内容，大幅度减少老师的工作量。项目采用前后端分离的架构。分为pc端、微信端。依托公众号进行开发。

### Feature
-  1.采用[dva](https://github.com/dvajs/dva)作为项目脚手架
-  2.pc端采用react-router4的动态路由，实现多页面拆分打包，加快首屏加载时间。
-  3。配置了babel-plugin-import，实现antd资源的按需打包
-  4.使用[roadhog](https://github.com/sorrycc/roadhog)本地调试和构建，其中Mock功能实现脱离后端独立开发。
-  5.编写request模块统一管理ajax，使用async/await
-  6.对redux的store进行本地存储，在刷新时自动存入localstorage中。

***
> 项目运行步骤 （推荐使用 **[yarn](https://github.com/yarnpkg/yarn)** 进行安装 也可使用 **[npm](https://github.com/npm/npm)** ）
```bash
 git clone https://github.com/w771854332/easyWrile.git
```
```bash
 yarn
```
```bash
 yarn start
```

### 项目截图

|首页|文档页|个人页|
|:--:|:--:|:--:|
![首页](http://blog.bengiw.com:3000/screenshot/easyWrite.png)|![文档页](http://blog.bengiw.com:3000/screenshot/easyWrite2.png)|![个人页](http://blog.bengiw.com:3000/screenshot/easyWrite3.png)
|文档页空|
![文档页空](http://blog.bengiw.com:3000/screenshot/easyWrite4.png)|


如果横屏显示的话：
![](http://blog.bengiw.com:3000/screenshot/easyWrite5.png)



