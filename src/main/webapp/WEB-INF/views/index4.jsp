<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>物业管理系统</title>
    <script type="text/javascript" src="<%=path%>/huai/Jquery/jquery.min.js"></script>
    <link rel="stylesheet" href="<%=path%>/huai/layui2.45/css/layui.css">
</head>
<style>
    .layui-tab ul.layui-tab-title li:nth-child(1) i {
        display: none;
    }

    /**右键菜单*/
    .rightmenu {
        position: absolute;
        width: 110px;
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
        height: 30px;
        line-height: 32px;
    }

    .rightmenu li:hover {
        background-color: #666;
        color: #fff;
    }

    /*.layui-body{overflow-y: scroll;}*/

</style>
<body class="layui-layout-body">
<ul class="rightmenu">
    <li data-type="closethis">关闭当前</li>
    <li data-type="closeall">关闭所有</li>
</ul>
<%--顶部菜单--%>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header" >
        <div class="layui-logo" style="font-size: 20px;font-weight: bold;color: #0ec07a;letter-spacing: 8px;">物业管理系统</div>


        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item"><a href="#;" style="color: #ffffff;">${UserName},欢迎您！</a></li>

            <li class="layui-nav-item layui-hide-xs"  lay-unselect="">
                <a style="color: #ffffff;" href="#;" data-url="<%=path%>/message/look.action" class="site-demo-active"
                   data-id="messageid" onclick="clickMenu(this)" data-title="消息中心">消息中心<span id ="message_id" class="layui-badge-dot" style="margin-top: -5px;"></span></a>
            </li>

            <li class="layui-nav-item">
                <a href="javascript:;"style="color: #ffffff;"><i class="layui-icon-set layui-icon"> </i><b >设置</b>
                </a>
                <dl class="layui-nav-child" style="background-color: #090723;" >
                    <dd><a onclick="clickMenu(this)" href="#;" data-id="toSetPassword" class="site-demo-active"
                           data-title="修改密码"data-url="<%=path%>/toSetPassword.action" style="color: #ffffff;opacity: 0.6;">修改密码</a></dd>
                    <dd><a href="<%=path%>/logout" style="color: #ffffff;opacity: 0.6">退出系统</a></dd>

                </dl>
            </li>
        </ul>
    </div>



    <div class="layui-side layui-bg-black ">
        <div class="layui-side-scroll">
            <!-- 左侧垂直导航区域-->
            <ul class="layui-nav layui-nav-tree" lay-filter="test">
                <li class="layui-nav-item">
                    <a class="" href="javascript:;">闲置资产</a>
                    <dl class="layui-nav-child ">
                            <dd><a href="#;" data-id="xzwz" data-title="闲置物资" onclick="clickMenu(this)"
                                   data-url="<%=path%>/rich/goodslook" class="site-demo-active"data-type="taAdd" >闲置物资</a></dd>
                        <dd><a href="#;" data-id="xzfc" data-title="闲置房产" onclick="clickMenu(this)"
                               data-url="<%=path%>/house/xzfwlook" class="site-demo-active"data-type="taAdd" >闲置房产</a></dd>

                    </dl>
                </li>

            </ul>
        </div>
    </div>



    <!--tab标签-->

    <div class="layui-tab layui-tab-brief" lay-filter="demo"  lay-allowclose="true" style="margin-left: 200px;">
        <ul class="layui-tab-title" >
            <li class="layui-icon " data-id="homePage" href="backManage/home.jsp">&#xe68e;</li>
        </ul>
        <div class="layui-tab-content" style="width: 99%;overflow-y: hidden;">
            <%--下面这个div为主页区域--%>
            <div class="layui-tab-item layui-show" data-url="<%=path%>/manage/wxmenu/look.action">
            </div>
        </div>
    </div>


    底部区域
    <div class="layui-footer" id="admin" style="height: 30px;">
        <div class="layui-layout-right"  style="height: 30px;">
            <b style="margin-right: 50px;cursor: pointer;font-size: 15px;margin-bottom: 5px">
                <%--<img src="<%=path%>\hongji\layUI\layui-v2.3.0-rc1\images\zuzhi.png" style="height:15px;margin-bottom:3px">--%>
                <label class="layuilabel"  style="color:#000;cursor: pointer;opacity: 0.6">组织：</label>
                <span  class="layuilabel" id="companyID_id" style="color:#000;opacity: 0.6">${sessionScope.CompanyName}</span>
            </b>
        </div>
    </div>
</div>


<script>


    layui.use(['element', 'layer', 'jquery'], function () {
        var element = layui.element;
        var layer = layui.layer;
        var $lay = layui.$;


        // 配置tab实践在下面无法获取到菜单元素
        $lay('.site-demo-active').on('click', function () {
            var dataid = $lay(this);
            //这时会判断右侧.layui-tab-title属性下的有lay-id属性的li的数目，即已经打开的tab项数目
            if ($lay(".layui-tab-title li[lay-id]").length <= 0) {
                //如果比零小，则直接打开新的tab项
                active.tabAdd(dataid.attr("data-url"), dataid.attr("data-id"), dataid.attr("data-title"));
            } else {
                //否则判断该tab项是否以及存在
                var isData = false; //初始化一个标志，为false说明未打开该tab项 为true则说明已有
                $lay.each($lay(".layui-tab-title li[lay-id]"), function () {
                    //如果点击左侧菜单栏所传入的id 在右侧tab项中的lay-id属性可以找到，则说明该tab项已经打开
                    if ($lay(this).attr("lay-id") == dataid.attr("data-id")) {
                        isData = true;
                    }
                })
                if (isData == false) {
                    //标志为false 新增一个tab项
                    active.tabAdd(dataid.attr("data-url"), dataid.attr("data-id"), dataid.attr("data-title"));
                }
            }
            //最后不管是否新增tab，最后都转到要打开的选项页面上
            active.tabChange(dataid.attr("data-id"));
        });

        var active = {
            //在这里给active绑定几项事件，后面可通过active调用这些事件
            tabAdd: function (url, id, name) {
                //新增一个Tab项 传入三个参数，分别对应其标题，tab页面的地址，还有一个规定的id，是标签中data-id的属性值
                //关于tabAdd的方法所传入的参数可看layui的开发文档中基础方法部分
                element.tabAdd('demo', {
                    title: name,
                    content: '<iframe data-frameid="' + id + '" scrolling="auto" frameborder="0" src="' + url + '" style="width:100%;"></iframe>',
                    id: id //规定好的id
                })
                FrameWH();  //计算ifram层的大小
            },
            tabChange: function (id) {
                //切换到指定Tab项
                element.tabChange('demo', id); //根据传入的id传入到指定的tab项
            },
            tabDelete: function (id) {
                element.tabDelete("demo", id);//删除
            }
        };
        function FrameWH() {
            var h = $lay(window).height()-100;
            $lay("iframe").css("height",h+"px");
        }

        /*element.on('nav(demo)', function(elem){
            console.log(elem); //得到当前点击的DOM对象
        });*/
        <%--//默认打开文件管理的tab--%>
         <%--$(document).ready(function(){--%>
              <%--active.tabAdd('<%=path%>/major/mainlook','mainlook','文件管理');--%>
            <%--active.tabChange('mainlook');--%>
        <%--})--%>
    });

    //点击菜单刷新右侧iframe
    function clickMenu(elem) {
        var $elem = $(elem);
        var data = $elem[0].dataset;

        var aa = $elem[0];
        var rightUrl = $elem[0].dataset.url;//点击菜单的url
        var iframeId = $elem[0].dataset.id;//点击菜单的id

        console.log(rightUrl);
        console.log(iframeId);
        var $rightIframe = $('iframe[data-frameid="'+iframeId+'"]');//iframe元素
        $rightIframe.attr("src",rightUrl).ready();//重新设置ifram的url为本身的url
        //rightIframe.src = rightUrl; dom.src = url 通过替换iframe的src实现局部刷新

    }

    /*var tabDelete = function (id) {
        console.log("删除的TabID："+id)
        element.tabDelete("你的Tab选项卡ID", id);//删除
    }*/
    var tabDeleteAll = function (ids) {

    }


    /*官网的*/
    /*layui.use(['element', 'layer', 'jquery'], function(){
        var $ = jQuery = layui.jquery;
        var element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块
        var layer = layui.layer;
        //触发事件
        var active = {
            tabAdd: function(url, id, name){
                debugger
                //新增一个Tab项
                element.tabAdd('demo', {
                    title: name, //用于演示
                    content: '<iframe data-frameid="' + id + '" scrolling="auto" frameborder="0" src="' + url + '" style="width:100%;height:99%;"></iframe>',
                    id: id //实际使用一般是规定好的id，这里以时间戳模拟下
                })
            }
            ,tabDelete: function(othis){
                //删除指定Tab项
                element.tabDelete('demo', '44'); //删除：“商品管理”


                othis.addClass('layui-btn-disabled');
            }
            ,tabChange: function(){
                //切换到指定Tab项
                element.tabChange('demo', '22'); //切换到：用户管理
            }
        };

        $('.site-demo-active').on('click', function(){
            var othis = $(this), type = othis.data('type');
            active[type] ? active[type].call(this, othis) : '';
        });

        //Hash地址的定位
        var layid = location.hash.replace(/^#test=/, '');
        element.tabChange('test', layid);

        element.on('tab(test)', function(elem){
            location.hash = 'test='+ $(this).attr('lay-id');
        });

    });*/

</script>

</body>
</html>