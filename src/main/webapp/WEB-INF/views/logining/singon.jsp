<%--
  Created by IntelliJ IDEA.
  @Author: laiyunjing
  @Date: 2019/7/24 0024 09:36
  @Version 1.0
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <script type="text/javascript" src="<%=path%>/huai/Jquery/jquery.min.js"></script>
    <script type="text/javascript" src="<%=path%>/huai/layui2.45/layui.all.js"></script>
    <script type="text/javascript" src="<%=path%>/huai/layui2.45/layui.js"></script>
    <script type="text/javascript" src="<%=path %>/huai/common/tool.js"></script>
    <link rel="stylesheet" href="<%=path%>/huai/layui2.45/css/layui.css">
    <link rel="stylesheet" href="<%=path%>/huai/Css/style.css">
    <title>登录</title>
</head>
<body>

<div class="login-main">
    <header class="layui-elip">登录</header>
    <form class="layui-form">
        <div class="layui-input-inline">
            <input type="text" name="account" required lay-verify="required" placeholder="用户名" autocomplete="off"
                   class="layui-input">
        </div>
        <div class="layui-input-inline">
            <input type="password" name="password" required lay-verify="required" placeholder="密码" autocomplete="off"
                   class="layui-input">
        </div>
        <div class="layui-input-inline login-btn">
            <button lay-submit lay-filter="login" class="layui-btn">登录</button>
        </div>
        <hr/>
        <!--<div class="layui-input-inline">
            <button type="button" class="layui-btn layui-btn-primary">QQ登录</button>
        </div>
        <div class="layui-input-inline">
            <button type="button" class="layui-btn layui-btn-normal">微信登录</button>
        </div>-->
        <p><a href="register.html" class="fl">立即注册</a><a href="javascript:;" class="fr">忘记密码？</a></p>
    </form>
</div>


<script type="text/javascript">
    layui.use(['form','layer','jquery'], function () {

        // 操作对象
        var form = layui.form;
        var $ = layui.jquery;
        form.on('submit(login)',function (data) {
            // console.log(data.field);
            $.ajax({
                url:'login.php',
                data:data.field,
                dataType:'text',
                type:'post',
                success:function (data) {
                    if (data == '1'){
                        location.href = "../index.php";
                    }else{
                        layer.msg('登录名或密码错误');
                    }
                }
            })
            return false;
        })

    });
</script>
</body>
</html>