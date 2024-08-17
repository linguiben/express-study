// 1. 引入express
const express = require('express');

// 2.创建应用对象
const app = express();

// 3.创建路由规则
app.get('/',(request,response) => {
    // 设置响应
    response.send('Hello Express!');
})

// 4.监听端口启动服务
app.listen(8000,() => {
    console.log('服务已经启动，8000 端口监听中......')
})