<%--
  Created by IntelliJ IDEA.
  @Author: laiyunjing
  @Date: 2019/7/13 0013 11:13
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
    <title>主页面</title>
</head>
<style>

    .rightmenu {
        position: absolute;
        width: 100px;
        z-index: 9999;
        display: none;
        background-color: #fff;
        padding: 2px;
        color: #333;
        border: 1px solid #eee;
        border-radius: 2px;
        cursor: pointer;
    }
    .rightmenu li {
        text-align: center;
        display: block;
        height: 35px;
        line-height: 35px;
    }
    .rightmenu li:hover {
        background-color: #666;
        color: #fff;
    }

</style>

<body class="layui-layout-body">

<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">layui 后台布局</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="">控制台</a></li>
            <li class="layui-nav-item"><a href="">商品管理</a></li>
            <li class="layui-nav-item"><a href="">用户</a></li>
            <li class="layui-nav-item">
                <a href="javascript:;">其它系统</a>
                <dl class="layui-nav-child">
                    <dd><a href="">邮件管理</a></dd>
                    <dd><a href="">消息管理</a></dd>
                    <dd><a href="">授权管理</a></dd>
                </dl>
            </li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
                    贤心
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="">基本资料</a></dd>
                    <dd><a href="">安全设置</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="">退了</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:;">所有商品</a>
                    <dl class="layui-nav-child">
                        <dd><a href="#;" data-id="look" data-title="档案类别"
                               data-url="<%=path%>/share/look" class="site-demo-active"data-type="taAdd" >档案类别</a></dd>
                        <dd><a href="#;" data-id="look3" data-title="档案类别"
                               data-url="<%=path%>/share/look3" class="site-demo-active"data-type="taAdd" >档案类别</a></dd>
                        <dd><a href="#;" data-id="look4" data-title="档案类别"
                               data-url="<%=path%>/share/look5" class="site-demo-active"data-type="taAdd" >测试</a></dd>
                        <dd><a href="#;" data-id="gs1" data-title="公司1"
                               data-url="<%=path%>/gs/look" class="site-demo-active"data-type="taAdd" >公司1</a></dd>
                        <dd><a href="#;" data-id="gs2" data-title="公司2"
                               data-url="<%=path%>/gs/look2" class="site-demo-active"data-type="taAdd" >公司2</a></dd>
                        <dd><a href="#;" data-id="gs3" data-title="公司3"
                               data-url="<%=path%>/gs/look3" class="site-demo-active"data-type="taAdd" >公司3</a></dd>
                    </dl>
                </li>
            </ul>


        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;">
            <div class="layui-tab" lay-filter="demo" lay-allowClose="true">
                <ul class="layui-tab-title">

                </ul>
                <!-- 以下鼠标右键功能 界面 -->
                <ul class="rightmenu" style="display: none;position: absolute;">
                    <li data-type="refresh">刷新</li>
                    <li data-type="closeOthers">关闭其他</li>
                    <li data-type="closeRight">关闭右边所有</li>
                    <li data-type="closeAll">关闭所有</li>
                </ul>


                <div class="layui-tab-content" style="min-height: 800px;border: none">


                </div>
            </div>

        </div>

    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © layui.com - 底部固定区域
    </div>
</div>
<script>
    layui.use(['element','layer', 'jquery' ],function() {
        var element = layui.element;
        var layer = layui.layer;
        var $lay = layui.$;

        //触发事件
        var active = {
            //在这里给active绑定几项事件，后面可通过active调用这些事件
            tabAdd: function(url,id,name) {
                //新增一个Tab项 传入三个参数，分别对应其标题，tab页面的地址，还有一个规定的id，是标签中data-id的属性值
                //关于tabAdd的方法所传入的参数可看layui的开发文档中基础方法部分
                element.tabAdd('demo', {
                    title: name,
                    content: '<iframe data-frameid="'+id+'" scrolling="auto" frameborder="0" src="'+url+'" style="width:100%;;height:99%;"></iframe>',
                    id: id //规定好的id
                })
                CustomRightClick(id); //给tab绑定右击事件
                FrameWH();  //计算ifram层的大小
            },
            tabChange: function(id) {
                //切换到指定Tab项
                element.tabChange('demo', id); //根据传入的id传入到指定的tab项
            },
            tabDelete: function (id) {
                element.tabDelete("demo", id);//删除
            },
            tabDeleteAll: function (ids) {//删除所有
                $.each(ids, function (i, item) {
                    element.tabDelete("demo", item); //ids是一个数组，里面存放了多个id，调用tabDelete方法分别删除
                })
            },
            tabRefresh: function (id) {//刷新页面
                    $("iframe[data-frameid='"+id+"']").attr("src",$("iframe[data-frameid='"+id+"']").attr("src"))//刷新框架
                },


        };

        //当点击有site-demo-active属性的标签时，即左侧菜单栏中内容 ，触发点击事件
        $('.site-demo-active').on('click', function() {
            var dataid = $(this);

            //这时会判断右侧.layui-tab-title属性下的有lay-id属性的li的数目，即已经打开的tab项数目
            if ($(".layui-tab-title li[lay-id]").length <= 0) {
                //如果比零小，则直接打开新的tab项
                active.tabAdd(dataid.attr("data-url"), dataid.attr("data-id"),dataid.attr("data-title"));
            } else {
                //否则判断该tab项是否以及存在

                var isData = false; //初始化一个标志，为false说明未打开该tab项 为true则说明已有
                $.each($(".layui-tab-title li[lay-id]"), function () {
                    //如果点击左侧菜单栏所传入的id 在右侧tab项中的lay-id属性可以找到，则说明该tab项已经打开
                    if ($(this).attr("lay-id") == dataid.attr("data-id")) {
                        isData = true;
                    }
                })
                if (isData == false) {
                    //标志为false 新增一个tab项
                    active.tabAdd(dataid.attr("data-url"), dataid.attr("data-id"),dataid.attr("data-title"));
                }
            }
            //最后不管是否新增tab，最后都转到要打开的选项页面上
            active.tabChange(dataid.attr("data-id"));
        });

        function CustomRightClick(id) {
            //取消右键  rightmenu属性开始是隐藏的 ，当右击的时候显示，左击的时候隐藏
            $('.layui-tab-title li').on('contextmenu', function () { return false; })
            $('.layui-tab-title,.layui-tab-title li').click(function () {
                $('.rightmenu').hide();
            });
            //桌面点击右击
            $('.layui-tab-title li').on('contextmenu', function (e) {
                var popupmenu = $(".rightmenu");
                popupmenu.find("li").attr("data-id",id); //在右键菜单中的标签绑定id属性

                //判断右侧菜单的位置
                l = ($(document).width() - e.clientX) < popupmenu.width() ? (e.clientX - popupmenu.width()) : e.clientX;
                t = ($(document).height() - e.clientY) < popupmenu.height() ? (e.clientY - popupmenu.height()) : e.clientY;
                popupmenu.css({ left: l, top: t }).show(); //进行绝对定位
                //alert("右键菜单")
                return false;

            });
        }

        $(".rightmenu li").click(function () {

            // //右键菜单中的选项被点击之后，判断type的类型，决定关闭所有还是关闭当前。
            // if ($(this).attr("data-type") == "closethis") {
            //     //如果关闭当前，即根据显示右键菜单时所绑定的id，执行tabDelete
            //     active.tabDelete($(this).attr("data-id"))
            // } else if ($(this).attr("data-type") == "closeall") {
            //     var tabtitle = $(".layui-tab-title li");
            //     var ids = new Array();
            //     $.each(tabtitle, function (i) {
            //         ids[i] = $(this).attr("lay-id");
            //     })
            //     //如果关闭所有 ，即将所有的lay-id放进数组，执行tabDeleteAll
            //     active.tabDeleteAll(ids);
            // }

            //当前的tabId
            var currentTabId = $(this).attr("data-id");

            if ($(this).attr("data-type") == "closeOthers") {//关闭其他
                var tabtitle = $(".layui-tab-title li");
                $.each(tabtitle, function (i) {
                    if($(this).attr("lay-id")!=currentTabId){
                        active.tabDelete($(this).attr("lay-id"))
                    }
                })
            } else if ($(this).attr("data-type") == "closeAll") {//关闭全部
                var tabtitle = $(".layui-tab-title li");
                $.each(tabtitle, function (i) {
                    active.tabDelete($(this).attr("lay-id"))
                })

            }else if ($(this).attr("data-type") == "refresh") {//刷新页面
                active.tabRefresh($(this).attr("data-id"));

            }else if ($(this).attr("data-type") == "closeRight") {//关闭右边所有
                //找到当前聚焦的li之后的所有li标签 然后遍历
                var tabtitle = $(".layui-tab-title li[lay-id="+currentTabId+"]~li");
                $.each(tabtitle, function (i) {
                    active.tabDelete($(this).attr("lay-id"))
                })
            }


            $('.rightmenu').hide(); //最后再隐藏右键菜单
        })
        function FrameWH() {
            var h = $(window).height() -41- 10 - 60 -10-44 -10;
            $("iframe").css("height",h+"px");
        }

        $(window).resize(function () {
            FrameWH();
        })


    })


    //点击菜单刷新右侧iframe
    // function clickMenu(elem) {
    //     var $elem = $(elem);
    //     var data = $elem[0].dataset;
    //     var aa = $elem[0];
    //     var rightUrl = $elem[0].dataset.url;//点击菜单的url
    //     var iframeId = $elem[0].dataset.id;//点击菜单的id
    //     var $rightIframe = $('iframe[data-frameid="'+iframeId+'"]');//iframe元素
    //     $rightIframe.attr("src",rightUrl).ready();//重新设置ifram的url为本身的url
    //     //rightIframe.src = rightUrl; dom.src = url 通过替换iframe的src实现局部刷新
    //
    // }

</script>

</body>
</html>
