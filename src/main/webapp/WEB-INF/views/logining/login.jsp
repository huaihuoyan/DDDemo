<%--
  Created by IntelliJ IDEA.
  @Author: laiyunjing
  @Date: 2019/7/24 0024 09:23
  @Version 1.0
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <script type="text/javascript" src="<%=path%>/huai/Jquery/jquery.min.js"></script>
    <script type="text/javascript" src="<%=path%>/huai/layui2.45/layui.all.js"></script>
    <script type="text/javascript" src="<%=path%>/huai/layui2.45/layui.js"></script>
    <script type="text/javascript" src="<%=path %>/huai/common/tool.js"></script>
    <link rel="stylesheet" href="<%=path%>/huai/layui2.45/css/layui.css">
    <title>登录</title>
</head>
<body >

<h2 align="center">用户登录</h2>
<h5 align="center">${error}</h5>
<h5 align="center">${succeed}</h5>
<form align="center" action="" method="post" id="loginform">
    <div > 用户名：<input  style="text-align: left" type="text" id="username" name="username"></div>
    <div > 密   码：<input  style="text-align: left" type="password" id="password" name="password"></div>
    <div style="color:#f37b1b;font-size: 15px;margin:10px 0 10px 10px;">
        <b><span  id='unifo_login_span_id' >
					   	 <%--<%--%>
                             <%--Object obj = request--%>
                                     <%--.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);--%>
                             <%--String msg = "";--%>
                             <%--if (obj != null) {--%>
                                 <%--if (obj instanceof IncorrectCaptchaException)--%>
                                     <%--msg = "验证码错误！";--%>
                                 <%--else--%>
                                     <%--msg = "账号或密码错误！";--%>
                             <%--}else{--%>
                                 <%--if(request.getAttribute("message")!= null){--%>
                                     <%--msg=(String)request.getAttribute("message");--%>
                                 <%--}--%>
                             <%--}--%>
                             <%--out.println("<span >" + msg + "</span>");--%>
                         <%--%>   </span>&nbsp;&nbsp;</b>--%>
    </div>
    <input type="button" id="btn_submit" title="登录" value="登录">
    <a style="margin-left: 40px" href="">注册</a>
</form>


<script >

    //阻止浏览器回退事件
    var btnFlag=true;

    $(function() {
        if (window.history && window.history.pushState)
        {	　　$(window).on('popstate', function () {
            window.history.pushState('forward', null, '#');
            window.history.forward(1);
        });
        }
        window.history.pushState('forward', null, '#'); //在IE中必须得有这两行	　　
        window.history.forward(1);

        $("#btn_submit").click(function () {
            dologin();
        })


        function kickout(){
            var href=location.href;
            if(href.indexOf("kickout")>0){
                alert("您的账号在另一台设备上登录，您被挤下线，若不是您本人操作，请立即修改密码！");
            }
        }
        window.onload=kickout();

    })



    function dologin(){
        //重置提示信息
        $("#unifo_login_span_id").text("    ");
        var password = $("#password").val();//用户输入密码
        var username=$("#username").val();
        if(username == "" || username == null ||password == "" || password == null){
            $("#unifo_login_span_id").text("账户、密码必须填写");
            $.messager.progress('close');
            return;
        }
        /* var randomcode = $("#randomcode").val();
        if(randomcode == "" || randomcode == null ){
            $("#unifo_login_span_id").text("验证码必须填写");
            return;
        } */
        //校验非法字符
        var patrn=/[!#@$%^&*()_+<>?:"{},\/;'[\]]/;
        if(patrn.test(username)||patrn.test(password)){
            $("#unifo_login_span_id").text("账户、密码非法字符");
            return true;
        }
        //没有雪花，所以这样防止重复提交
        if(!btnFlag){
            return;
        }

        //var password=$("#pwd_id").val();

        //重置提示信息
        $("#unifo_login_span_id").text(" ");
        //用户是否点亮 记住密码按钮

        if(btnFlag){
            btnFlag = false;
        }else{
            $.messager.progress('close');
            return;
        }
        var saveFlag = $('#remember_id').is(':checked');
        $("[name='rememberMe']").attr("value",saveFlag);
        $("[name='remember']").attr("value",saveFlag);
        $("#loginform").submit();
        return;

    }

</script>
</body>
</html>
