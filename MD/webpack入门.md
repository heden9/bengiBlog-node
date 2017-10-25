# webpack入门
>   前端自动构建工具 模块打包机

生产模式
开发模式
对资源依赖进行预处理，集成，压缩

分析项目结构，找到js模块以及其他的一些浏览器不能直接运行的拓展语言（less、Typescript）,并将其转换和打包围合适的格式供浏览器使用。

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

`entry`和`output`是必选项，现在我们执行`npm run build`

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
```
将css单独打包
```javascript
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