<%--
  Created by IntelliJ IDEA.
  @Author: laiyunjing
  @Date: 2019/7/16 0016 16:35
  @Version 1.0
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <script type="text/javascript" src="<%=path%>/huai/Jquery/jquery.min.js"></script>
    <script type="text/javascript" src="<%=path%>/huai/layui2.45/layui.all.js"></script>
    <script type="text/javascript" src="<%=path%>/huai/layui2.45/layui.js"></script>
    <link rel="stylesheet" href="<%=path%>/huai/layui2.45/css/layui.css">
    <title>共享文件页面</title>
</head>
<body>
<div class="layui-btn-group demoTable" >
    <button class="layui-btn  layui-btn-radius"   data-type="addAll" style="border-radius: 100px;">通告</button>
    <button class="layui-btn  layui-btn-radius"  data-type="huoqu" style="border-radius: 100px;">流程</button>
</div>
<script>
    /*表格*/
    layui.use(['form','table','layer','element', 'layedit','laydate'], function() {
        var form = layui.form;
        var layer = layui.layer;
        var table = layui.table;
        var laydate = layui.laydate;
        /*顶部栏增加 , 删除 , 查询*/
        var $ = layui.jquery, active = {
            /*新增*/
            addAll:function () {
                $.ajax({
                    url: "<%=path%>/share/sharedown",
                    data: {},
                    type: "POST",
                    dataType: "json",
                    success:function (obj) {

                        // if (obj .code == 200) {
                        //     toolMsgAndClose(obj.data);
                        //
                        // } else {
                        //     toolErrorAndClose(obj.data);
                        //
                        // }

                    },
                    error:function (obj) {
                        // toolErrorAndClose(obj.data);

                    }


                })
            },
            huoqu:function () {
                $.ajax({
                    url: "<%=path%>/share/shareAdd",
                    data: {},
                    type: "POST",
                    dataType: "json",
                    success:function (obj) {

                        if (obj .code == 200) {
                            toolMsgAndClose(obj.data);

                        } else {
                            toolErrorAndClose(obj.data);

                        }

                    },
                    error:function (obj) {
                        toolErrorAndClose(obj.data);

                    }


                })
            }
        };
        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
    })
</script>
</body>
</html>
