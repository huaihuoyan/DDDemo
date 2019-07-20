<%--
  Created by IntelliJ IDEA.
  @Author: laiyunjing
  @Date: 2019/7/20 0020 09:56
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
    <title>公司的数据表格</title>
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
    /*表格*/
    layui.use(['form','table','layer','element', 'layedit','laydate'], function() {
        var form = layui.form;
        var layer = layui.layer;
        var table = layui.table;
        var laydate = layui.laydate;


        /*日期默认当前月份*/
        laydate.render({
            elem: '#dawrit_id',
            format:"yyyy-MM",
            type: 'month',
            value:new Date(),
            done: function(value, date){

            }
        });
        /*日期默认当前月份*/
        laydate.render({
            elem: '#dateeat_id',
            format:"yyyy-MM",
            type: 'month',
            value:new Date(),
            done: function(value, date){

            }
        });

        /*又换了种风格，并且设定最长等待5秒*/
        var index = layer.load(2, {time: 5*1000});
        /*方法渲染*/
        table.render({
            elem: '#company',
            url: '<%=path%>/gs/selectA',
            id: 'company',
            height:'full-140',
            toolbar: true,
            defaultToolbar: ['filter', 'print', 'exports'],
            page: true,
            limit:90,
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
                var that = this.elem.next();

                res.data.forEach(function (item, index) {
                    // if (item.fwZystate == 1) {
                    //     var tr = that.find(".layui-table-box tbody tr[data-index='" + index + "']").css("background-color", "#FF9E3F");
                    // }
                });

            }
        });
        /*点击就勾上复选框*/
        // clickOnRows();

        //行选择
        table.on('tool(rich_table)', function (obj) {


            var data = obj.data;
            var fid = data.fid;
            // console.log(data);
            var layEvent = obj.event;

            /*修改*/
            if (layEvent === 'edit') {
              alert("修改");


            }else if(layEvent  === 'del'){
                alert("删除");


            }


        });
        //双击事件
        table.on('rowDouble(rich_table)', function(obj){

        })

        /*顶部栏增加 , 删除 , 查询*/
        var $ = layui.jquery, active = {
            addAll:function () {
             alert("增加")


            },
            import:function(){
                alert("导入");

            },
            //查询
            reload: function () {
               alert("查询");

            },

        }
        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
    })



</script>
</body>
</html>
