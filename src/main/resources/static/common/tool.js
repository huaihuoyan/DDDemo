/*
////
    特别声明：此工具类中的大部分方法都需要在layui框架环境中使用，并且为了不影响使用，请统一使用如下初始化命名
            var form = layui.form
            ,layer = layui.layer
            ,laydate = layui.laydate
            ,laytpl = layui.laytpl
            ,$lay = layui.jquery
            ,layedit = layui.layedit
            ,upload = layui.upload;

            var active = {
                reload: function(){
                }
            }
////
 */

/**
 * 后台工具统一ajax错误处理
 */
//ajax异常统一处理
$.ajaxSetup({
    type : 'POST',
    error : function(XMLHttpRequest, textStatus, errorThrown) {
        var result = JSON.parse(XMLHttpRequest.responseText);

        console.log(result);
        if(!isEmpty(result.msg))
        {
            toolLayMsg(result.msg)
        }

    }
});

/**
 *后台处理ajax的方法
 */
function ajaxs(url,type,data,dataType) {
    $.ajax({
        url:url,
        data:data,
        type:type,
        dataType:dataType,
        success:function (obj) {
            if(obj.code==200){
                layer.msg(obj.msg);
            }else {
                layer.msg(obj.msg);
            }
        }
    })

}


/*
                        弹窗相关通用方法
-----------------------------------------------------------------
 */
///////////////提示部分
//添加遮罩层
function toolAddLoading() {
    layer.open({
        type: 3
        ,offset: 'auto'
        ,id: 'loading_id'
    });
}
//添加吸附式提示框
function toolAddRemindMsg(msg,id) {
    layer.open({
        type: 4,
        content: [msg, id], //数组第二项即吸附元素选择器或者DOM
        success: function(layero, index){
            setTimeout(function(){
                layer.closeAll('tips');
            },1000);
        }
    });
}
//添加弹窗（重提示框）
function toolLayMsg(str) {
    var yesFun = arguments[1];

    if(isEmpty(str))
    {
        str='后台处理数据异常';
    }

    layer.closeAll();
    layer.open({
        type: 1
        ,offset: 'auto'
        ,id: 'layerMsg_id'
        ,content: '<div style="padding: 20px 100px;">'+ str +'</div>'
        ,btn: '确定'
        ,btnAlign: 'c' //按钮居中
        ,shade: 0.3
        ,btn: ['确定','取消']
        ,yes: function(){

            if(!isEmpty(yesFun))
            {

                yesFun();
            }else{
                layer.closeAll();
            }
        }
        ,btn2: function(){
            layer.closeAll();
        }
    });
}
function toolLayMsg2(str) {
    layer.closeAll('loading');
    var thisWindows = layer.open({
        type: 1
        ,offset: 'auto'
        ,id: 'layerMsg_id'
        ,content: '<div style="padding: 20px 100px;">'+ str +'</div>'
        ,btn: '确定'
        ,btnAlign: 'c' //按钮居中
        ,shade: 0.3
        ,yes: function(){
            layer.close(thisWindows);
        }
    });
}
//轻提示--用于成功提醒
function toolMsgAndClose(msg) {
    if(isEmpty(msg))
    {
        msg = "成功";
    }
    layer.closeAll();
    layer.msg(msg, {icon: 1});
}
//轻提示--用于失败提醒
function toolErrorAndClose(msg) {
    if(isEmpty(msg))
    {
        msg = "失败";
    }
    layer.closeAll();
    layer.msg(msg, {icon: 2});
}
///////////////其他
function toolSaveSuccessReload(msg) {
    toolMsgAndClose(msg);
    if(active)
    {
        setTimeout(function(){
            //刷新
            active.reload();
        },1000);
    }

}
/*
-----------------------------------------------------------------
 */


/*
 *字符长度
 */
function getStrByte(str){
    var len = 0;
    if(str == null || str == '' || str == undefined || str == 'undefined')
    {
        return len;
    }

    for (var i=0; i<str.length; i++) {
        var c = str.charCodeAt(i);
        //单字节加1
        if ((c >= 0x0001 && c <= 0x007e) || (0xff60<=c && c<=0xff9f)) {
            len++;
        }
        else {
            len+=2;
        }
    }
    return len;
}
function getBytesLength(str) {
    // 在GBK编码里，除了ASCII字符，其它都占两个字符宽
    return str.replace(/[^\x00-\xff]/g, 'xx').length;
}


/*
 * 判断是否为空
 */
function isEmpty(obj){

    if(obj == null ||  obj == undefined )
    {
        return true;
    }
    //当传入为字符串时使用此方法
    if(Object.prototype.toString.call(obj) === "[object String]")
    {
        if(obj == '' || obj == 'undefined' || obj == 'null')
        {
            return true;
        }
    }

    return false;
}

/*
 * 对象复制方法
 */
function dataClone(data){

    var str = JSON.stringify(data);

    var cloneData = $.parseJSON(str);

    return cloneData;
}

/*
 * 删除指定位置元素
 */
function toolRemoveListAt(index,_list){
    if (index < _list.length) {
        var i;
        var arr = new Array();
        for (i = 0; i < _list.length; i++) {
            if (i != index) {
                arr.push(_list[i]);
            }
        }
        _list = arr;
        return _list;
    }
    return _list;
}

/*
格式化输出
 */
function strPrintf(str) {
    if(str == null || str == '' || str == undefined || str == 'undefined')
    {
        return '';
    }
    return str;
}


/*
 *  移除富文本内容
 */
function toolRemoveHtml(description){
    description = description.replace(/(\n)/g, "");
    description = description.replace(/(\t)/g, "");
    description = description.replace(/(\r)/g, "");
    description = description.replace(/<\/?[^>]*>/g, "");
    description = description.replace(/\s*/g, "");

    return description;
}


/*
 *  特殊字符校验
 */
function toolMsgRegExp(value){
    if(!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)){
        return true;
    }
    return false;
}

/*
判断网址
 */
function IsURL(str_url){
    var strRegex = "^((https|http|ftp|rtsp|mms)?://)"
        + "?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?" //ftp的user@
        + "(([0-9]{1,3}\.){3}[0-9]{1,3}" // IP形式的URL- 199.194.52.184
        + "|" // 允许IP和DOMAIN（域名）
        + "([0-9a-z_!~*'()-]+\.)*" // 域名- www.
        + "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\." // 二级域名
        + "[a-z]{2,6})" // first level domain- .com or .museum
        + "(:[0-9]{1,4})?" // 端口- :80
        + "((/?)|" // a slash isn't required if there is no file name
        + "(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$";
    var re=new RegExp(strRegex);
    //re.test()
    if (re.test(str_url)){
        return (true);
    }else{
        return (false);
    }
}

/**
 * layui 添加行单选事件
 */
function checkoutRows(){

    $(document).on("click",".layui-table-body table.layui-table tbody tr", function () {
        var index = $(this).attr('data-index');
        var tableBox = $(this).parents('.layui-table-box');
        //存在固定列
        if (tableBox.find(".layui-table-fixed.layui-table-fixed-l").length>0) {
            tableDiv = tableBox.find(".layui-table-fixed.layui-table-fixed-l");
        } else {
            tableDiv = tableBox.find(".layui-table-body.layui-table-main");
        }
        //获取已选中列并取消选中
        var trs = tableDiv.find(".layui-unselect.layui-form-checkbox.layui-form-checked").parent().parent().parent();
        for(var i = 0;i<trs.length;i++){
            var ind = $(trs[i]).attr("data-index");
            if(ind!=index){
                var checkCell = tableDiv.find("tr[data-index=" + ind + "]").find("td div.laytable-cell-checkbox div.layui-form-checkbox I");
                if (checkCell.length>0) {
                    checkCell.click();
                }
            }
        }
        //选中单击行
        var checkCell = tableDiv.find("tr[data-index=" + index + "]").find("td div.laytable-cell-checkbox div.layui-form-checkbox I");
        if (checkCell.length > 0) {
            checkCell.click();
        }
    });
    $(document).on("click", "td div.laytable-cell-checkbox div.layui-form-checkbox", function (e) {
        e.stopPropagation();
    });


}



/*
 *  为layui添加行选中事件
 */
function clickOnRows(){
    $(document).on("click",".layui-table-body table.layui-table tbody tr", function () {
        var index = $(this).attr('data-index');
        var tableBox = $(this).parents('.layui-table-box');
        //存在固定列
        if (tableBox.find(".layui-table-fixed.layui-table-fixed-l").length>0) {
            tableDiv = tableBox.find(".layui-table-fixed.layui-table-fixed-l");
        } else {
            tableDiv = tableBox.find(".layui-table-body.layui-table-main");
        }
        var checkCell = tableDiv.find("tr[data-index=" + index + "]").find("td div.laytable-cell-checkbox div.layui-form-checkbox I");
        if (checkCell.length>0) {
            checkCell.click();
        }
    });

    $(document).on("click", "td div.laytable-cell-checkbox div.layui-form-checkbox", function (e) {
        e.stopPropagation();
    });


}

/*提交*/
function wzsummit(url,data,demo) {
    var index = layer.open({
        type: 3
    });
    console.log(data);
    console.log(data.assignUser);

    $.ajax({
        url: url,
        data: {
            assignUser:data.assignUser,
            fu: demo
        },
        type: "POST",
        dataType: "json",
        success: function (obj) {
            if (obj .code == 200) {
                toolMsgAndClose(obj.data);
                brush();
            } else {
                toolErrorAndClose(obj.data);
                brush();
            }
        },
        error:function (obj) {
            toolErrorAndClose(obj.data);
            brush();
        }
    })
}

/*审核*/
function wzaudit(url,data,demo) {
    var index = layer.open({
        type: 3
    });
    console.log(demo.fid);
    console.log(demo[0].fid);
    console.log(data);
    $.ajax({
        url: url,
        data: {
            suggest:data.suggest,
            massge: data.massge,
            assignUser:data.assignUser,
            fu: demo
        },
        type: "POST",
        dataType: "json",
        success: function (obj) {
            console.log(data);
            if (obj .code == 200) {
                toolMsgAndClose(obj.data);
                brush();
            } else {
                toolErrorAndClose(obj.data);
                brush();
            }
        },
        error:function (obj) {
            toolErrorAndClose(obj.data);
            brush();
        }
    })
}

/*反审核*/
function wznaudit(url,data){
    var index = layer.open({
        type: 3
    });
    $.ajax({
        url: url,
        data: data,
        type: "POST",
        dataType: "json",
        success: function (obj) {
            console.log(data);
            if (obj .code == 200) {
                toolMsgAndClose(obj.data);
                brush();
            } else {
                toolErrorAndClose(obj.data);
                brush();
            }
        },
        error:function (obj) {
            toolErrorAndClose(obj.data);
            brush();
        }
    })
}



