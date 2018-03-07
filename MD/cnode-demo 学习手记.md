# cnode-demo 学习手记


项目目录介绍

```bash
├── .idea
│   ├── cnode-demo.iml
│   ├── inspectionProfiles
│   ├── modules.xml
│   └── workspace.xml
├── build
├── client
│   ├── App.jsx
│   └── app.js
└── package.json

```

```
yarn add babel-preset-es2015 babel-preset-es2015-loose babel-preset-react --dev
```

```
babel-preset-env // 你唯一需要的babel插件
```
rimraf是一个node的工具包，专门用来删除文件夹


服务端渲染的必要性，
单页应用存在的问题

- SEO不友好
- 首屏加载时间长，体验不好

React因为虚拟dom的存在，可以很方便的做服务端渲染。react-dom是专门为web端开发的渲染工具，我们可以调用react-dom/server 包中的方法，将react组件渲染称为字符串


服务端渲染要解决的问题：
- 服务端没有window，document对象。这个是浏览器这个js执行环境提供给我们的东西



webpack配置中的libraryTarget配置commonjs2的作用，可以看到生成的server-entry.js文件中，有module.exports


开发时常用的配置
- webpack dev server
- Hot module replacement  热更新


```bash
  "dev:client": "cross-env NODE_ENV=development webpack-dev-server --config build/webpack.config.client.js"
```

配置dev下的webpack-dev-server 设置环境变量 安装cross-env

安装react的热更新
```bash
yarn add react-hot-loader@next --dev
```
