# webpack入门
>   前端自动构建工具 模块打包机

[![webpack](https://img.shields.io/badge/webpack-^3.8.1-brightgreen.svg?style=flat-square)](https://github.com/webpack/webpack)
## 什么是webpack？
>   对资源依赖进行预处理，集成，压缩

WebPack可以看做是模块打包机：它做的事情是，分析你的项目结构，找到JavaScript模块以及其它的一些浏览器不能直接运行的拓展语言（Scss，TypeScript等），并将其转换和打包为合适的格式供浏览器使用。

![webpack](https://webpack.js.org/bf093af83ee5548ff10fef24927b7cd2.svg)

### 一、安装webpack
#### 1.先检查是否有node环境
```javascript
    node -v
```
如果能够显示node版本，就ok，进入下一步，如果没有就去安装node呀（推荐安装v6.11.4版本）
提一嘴切换淘宝镜像
```javascript
    // npm
    npm config set registry https://registry.npm.taobao.org --global
    npm config set disturl https://npm.taobao.org/dist --global
```
```javascript
    // yarn
    yarn config set registry https://registry.npm.taobao.org --global
    yarn config set disturl https://npm.taobao.org/dist --global
```
#### 2.然后安装webpack（不使用全局安装）
```javascript
    npm i webpack --save-dev
    // 或 yarn add webpack --dev
```
#### 3.创建webpack.config.js
```javascript
    const path = require('path');

    module.exports = {
        // 入口文件的配置
        entry: {
            app: './src/index.js'
        },
        // 出口文件的配置
        output: {
            path: path.resolve(__dirname, 'dist'),
            filename: '[name].js'
        }
    }
```
`__dirname`是node中的一个全局变量，指向当前脚本指向目录  
`entry`和`output`是必选项，现在我们执行`npm run build`，项目正常打包，输出到`dist`目录

>   不能直接执行`webpack`命令，因为我们的webpack不是全局安装的，只能够在`node_modules`中进行访问，所以要在`package.json`中进行配置

#### 4.配置webpack-dev-server
##### 1.安装
```javascript
    yarn add webpack-dev-server --dev
    // npm i webpack-dev-server --save-dev
```
##### 2.配置html-webpack-plugin
```javascript
    yarn add html-webpack-plugin --dev
    // npm i html-webpack-plugin save--dev
```
##### 3.dev-server 的配置
```javascript
    devServer: {
        // 设置基本目录结构
        contentBase: path.resolve(__dirname, 'dist'),
        // 主机地址
        host: 'localhost',
        // 端口
        port: '8081',
        // 开启gzip压缩
        compress: true, 
    }
```
#### 5.css/style-loader的配置
##### 1.安装
```javascript
    yarn add style-loader css-loader --dev
```
基本配置
```javascript
    module: {
        rules: [
            {
                test: /\.css$/, // 正则匹配以css结尾的文件
                use: ['style-loader', 'css-loader']
                // 或 以对象形式
                use: [
                    { 
                        loader: 'style-loader'
                    },{
                        loader: 'css-loader'
                    }
                ]
                
            },
        ]
    }
    ...
    ...
    plugin: [
        new ExtractTextPlugin('css/styles.css'), // 输出的路径
    ]
```
将css单独打包
-   下载 `extract-text-webpack-plugin`插件
```javascript
    yarn add extract-text-webpack-plugin --dev
```
-   配置
```javascript
    const ExtractTextPlugin = require('extract-text-webpack-plugin');
    ...
    ...
    use: ExtractTextPlugin.extract({  // 将css单独打包的插件
        fallback: 'style-loader',
        use: 'css-loader'
    })
```
#### 6.file/url-loader的配置
```javascript
    yarn add file-loader url-loader --dev
```
`url-loader`依赖于`file-loader`,必须要同时安装
```javascript
    {
        test: /\.(png|jpg|gif)$/i, // i 表示无视大小写
        use: [{
            loader: 'url-loader',
            options: {
                limit: 500, // 大小限制， 小于该大小的图片会被打包成base64
                outputPath: 'images/' // 文件输出的路径
            }
        }]
    }
```

完整代码可见[https://github.com/w771854332/webpack-demo](https://github.com/w771854332/webpack-demo)