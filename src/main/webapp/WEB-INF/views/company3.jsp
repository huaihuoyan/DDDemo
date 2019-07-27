<%--
  Created by IntelliJ IDEA.
  @Author: laiyunjing
  @Date: 2019/7/22 0022 09:55
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
    <script type="text/javascript" src="<%=path %>/huai/common/tool.js"></script>
    <link rel="stylesheet" href="<%=path%>/huai/layui2.45/css/layui.css">
    <title>公司的分页插件表格</title>
</head>
<body>
<form class="layui-form" onsubmit="return false;">
    <div class="layui-form-item">
        <div class="layui-inline" style="">
            <label class="layui-form-label">创建日期</label>
            <div class="layui-input-inline" style="margin-left: 0px;">
                <input name="daWritingdate" id="dawrit_id" lay-verify="date"  autocomplete="off" class="layui-input" type="text" >
            </div>
        </div>
        <div class="layui-inline" style="">
            <label class="layui-form-label">至</label>
            <div class="layui-input-inline" style="margin-left: 0px;">
                <input name="daWritingdate" id="dateeat_id" lay-verify="date"  autocomplete="off" class="layui-input" type="text" >
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-btn-group demoTable" >
            <button class="layui-btn  layui-btn-radius" id="add_id"  data-type="addAll" style="border-radius: 100px;">新增</button>
            <button class="layui-btn  layui-btn-normal  layui-btn-radius" data-type="reload" style="border-radius: 100px;">查询</button>
            <button class="layui-btn  layui-btn-normal  layui-btn-radius" data-type="import" style="border-radius: 100px;">导出</button>
            <button class="layui-btn  layui-btn-normal  layui-btn-radius" data-type="delAll" style="border-radius: 100px;">批量删除</button>
        </div>
    </div>
</form>
<table id="company"  class="layui-table" lay-filter="company"></table>
<script type="text/html" id="oper-col">

    <a class="layui-btn layui-btn layui-btn-xs" lay-event="edit">修改</a>
    <a class="layui-btn  layui-btn-danger layui-btn-xs" lay-event="del">删除</a>

    <%--{{#if (d.fwZystate == 1) { }}--%>
    <%--<a class="layui-btn  layui-btn-danger layui-btn-xs" lay-event="zuyong">已转让</a>--%>
    <%--{{# }else if(d.fwZystate == 0){ }}--%>
    <%--<a class="layui-btn  layui-btn-danger layui-btn-xs" lay-event="weiyong">未转让</a>--%>
    <%--{{# } }}--%>

</script>
<script>

    //设置时间为当月第一天
    function getCurrentMonthFirst(){
        var date = new Date();
        date.setDate(1);
        var month = parseInt(date.getMonth()+1);
        var day = date.getDate();
        if (month < 10) {
            month = '0' + month
        }
        if (day < 10) {
            day = '0' + day
        }
        return date.getFullYear() + '-' + month + '-' + day;
    };

    /*表格*/
    layui.use(['form','table','layer','element', 'layedit','laydate'], function() {
        var form = layui.form;
        var layer = layui.layer;
        var table = layui.table;
        var laydate = layui.laydate;
        var $ = layui.jquery;
        form.render('select'); //刷新select选择框渲染

        laydate.render({
            elem: '#starttime',
            value: getCurrentMonthFirst(),
            done: function (value, date) {
            }
        });

        //后面的时间
        laydate.render({
            elem: '#endtime',
            value: new Date(),
            done: function (value, date) {
            }

        });

        var starttime = $("#starttime").val();
        var endtime = $("#endtime").val();
        var wjtype = $("#wjtype").val();

        var index = layer.load(2, {time: 10*1000});
        table.render({
            elem: '#company',
            url: '<%=path%>/gs/selectP',
            page: true,
            toolbar: '#toolbarDemo',
            height: 'full-157',
            limit: 90,
            request: {     //用于对分页请求的参数：page、limit重新设定名称
                pageName: 'curr',    //页码的参数名称，默认：page
                limitName: 'limit'    //每页数据的参数名，默认：limit
            },
            where: {

            },

            cols: [[
                {type:'checkbox'},
                {field: 'id', title: 'ID',width:100},
                {field:'title',title:'名字',width:100},
                {field:'parentId',title:'父ID',width:100},
                {field:'level',title:'等级',width:100},

            ]],
            /*返回数据执行回调函数*/
            done:function (res) {
                /*返回数据关闭loading*/
                layer.close(index);

            }

        });
        clickOnRows();

        //头工具栏事件
        table.on('toolbar(table1)', function(obj){

        });

        /*顶部栏增加 , 删除 , 查询*/
        var $ = layui.jquery, active = {
            /*查询*/
            reload:function () {

            },


        };
        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
    })
</script>
</body>
</html>
