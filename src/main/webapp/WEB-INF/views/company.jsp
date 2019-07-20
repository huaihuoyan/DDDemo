<%--
  Created by IntelliJ IDEA.
  @Author: laiyunjing
  @Date: 2019/7/17 0017 17:27
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
    <link rel="stylesheet" href="<%=path%>/huai/layui2.45/dtree/dtree.css">
    <link rel="stylesheet" href="<%=path%>/huai/layui2.45/dtree/font/dtreefont.css">
    <title>公司的Dtree</title>
</head>

<body>
<div id="searchCondition">
    <div class="layui-input-block layui-col-xs5">
        <input type="text" name="condition" class="layui-input" placeholder="请输入组织名称">
    </div>
    <span class="layui-btn" id="searchBtn">查　询</span>
</div>

<ul id="demoTree" class="dtree" data-id="null"></ul>
<script>
    layui.config({
        base: '<%=path%>/huai/layui2.45/dtree/'
    }).extend({
        dtree: 'dtree'
    });

    layui.use('dtree', function () {
        var dtree = layui.dtree;
        var layer = layui.layer;

        /*var nodeIconArray = {
            "1": {"open": "icon icon-gongsi", "close": "icon icon-gongsi1"}
        };*/

        var DTree = dtree.render({
            elem: "#demoTree",
            // title: "切换公司组织",
            url: "<%=path%>/gs/companylist",
            dataStyle: "layuiStyle",  //使用layui风格的数据格式
            dataFormat: "list",  //配置data的风格为list
            response:{message:"msg",statusCode:0},  //修改response中返回数据的定义
            type: "load",
            ficon: '0',//一级图标样式
            icon: "2",  //修改二级图标样式
            checkbar: "true",  //开启复选框
            checkbarLoad: "node",
            checkbarType:"only",
            load:true,
            line: true,
            // initLevel: "3",
            // async: false,
            // cache: false,
            // icon: ['-1', '2'],  //只显示叶子节点的图标
            // dot: false,
            // toolbar: true,     //是否可以编辑节点
            // menubar: false,      //是否开启菜单栏
            // firstIconArray: "1",
            // nodeIconArray: {"1": {"open": "iconfont icon-gongsi", "close": "iconfont icon-gongsi1"}},
            // firstIconArray: {"2": {"open": "iconfont icon-gongsi", "close": "iconfont icon-gongsi1"}},
            // icon: ['1', '5'],

            // done: function(data, obj){
            //
            //     $("#searchBtn").unbind("click");
            //     $("#searchBtn").click(function(){
            //         // DTree.menubarMethod().refreshTree();
            //         var value = $("input[name='condition']").val();
            //         if(value){
            //             // var flag = DTree.prototype.queryListTreeByPid(value)
            //             var flag = DTree.searchNode(value); // 内置方法查找节点
            //             // console.log(flag);
            //             if (!flag) {layer.msg("该名称节点不存在！", {icon:5});}
            //         } else {
            //             DTree.menubarMethod().refreshTree(); // 内置方法刷新树
            //         }
            //     });
            // }
        });

        <%--dtree.on("node('demoTree')", function (obj) {--%>
            <%--// layer.msg(JSON.stringify(obj.param.nodeId));--%>
            <%--// console.log(obj.param);--%>
            <%--layer.confirm("是否切换到" + obj.param.context, {title: "是否切换组织"}--%>
                <%--, function () {--%>
                    <%--// layer.msg(JSON.stringify(obj.param.nodeId));--%>

                    <%--$.ajax({--%>
                        <%--type: "head",--%>
                        <%--url:"${baseurl}/switchOrganization/changeOrganization",--%>
                        <%--data: {--%>
                            <%--id: obj.param.nodeId,--%>
                            <%--title: obj.param.context--%>
                        <%--},--%>
                        <%--complete: function () {--%>
                            <%--// window.parent.app.organizationName = obj.param.context;--%>
                            <%--// closeLayer();--%>
                            <%--window.parent.location.reload();--%>
                        <%--}--%>
                    <%--})--%>
                <%--});--%>
        <%--})--%>
    })
</script>
</body>
</html>
