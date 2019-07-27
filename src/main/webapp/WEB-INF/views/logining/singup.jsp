<%--
  Created by IntelliJ IDEA.
  @Author: laiyunjing
  @Date: 2019/7/24 0024 09:27
  @Version 1.0
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <title>注册</title>
</head>
<body>
<body>
<h1 align="center">用户注册</h1>
<form  action="" method="post">
    <table align="center">
        <tr><td>用户名：</td><td><input type="text" name="name" placeholder="请输入用户名"></td></tr>
        <tr><td>密码：</td><td><input type="password" name="password" placeholder="请输入密码"></td></tr>
        <tr><td>用户名拼音：</td><td><input type="text" name="loginName" placeholder="请输入用户名拼音"></td></tr>
        <tr><td><input type="submit" title="提交"></td></tr>.
    </table>
</form>
</body>
</body>
</html>
