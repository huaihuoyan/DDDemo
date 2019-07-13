
//const Str_Msg_
layui.define(['layer', 'table','element'], function (exports) {
    var $_ = layui.jquery;
    var layer = layui.layer,
        table = layui.table,
        element = layui.element
    ;
    //静态变量
    const $_Str_Msg_MaxOut = '文件超过规定大小';
    const $_Default_chunkSize = 2 * 1024 * 1024;//每片大小
    const $_Default_fileMaxSize = 50 * 1024 * 1024;//最大50M
    const $_Default_fileListMaxSize =200 * 1024 * 1024;//一次性上传文件最大数量
    const $_Default_threads = 5;//线程数

    const $_Default_btn = '#ctlBtn';
    const $_Default_list = '#thelist';
    const $_Default_div = "#picker";
    const $_Default_fileSizeDiv = '#fileSizeInput';

    var uploadedList = [];//已经上传成功的文件（用于初始化代码）

    var uploader = null;
    var fileSizeNumDiv = null;
    var $_thelist = null;
    var webupload = {
        // 渲染树形表格
        render: function (param) {
            // 检查参数
            /*if (!webupload.checkParam(param)) {
                return;
            }*/
            // 初始化
            webupload.init(param, param.data);
        },
        //获取简易json
        esayFile:function (file) {
            return {'md5':file.md5,'type':file.type,'resName':file.name,'id':file.uid,'resSize':file.size};
        },
        //添加文件到队列
        addFilesToList:function (files) {
            //赋值
            uploadedList = files;
            var num = 0;
            for(var i = 0 ; i < files.length ;i++){
                var file = files[i];

                $_thelist.append('<fieldset class="layui-elem-field site-demo-button fileListClass uploaded" id="' + file.id + '" >'+
                    '<legend class="info">' + file.resName +
                    '<i class="layui-icon layui-icon-delete hand" style="font-size: 30px; color: #1E9FFF;"></i>  ' +
                    '</legend>' +
                    '<div class="listDivClass" style="width: 500px">' +
                    '<button class="layui-btn layui-btn-normal layui-btn-radius downloadBtn">下载</button>'+
                    //'<p class="state layui-badge successText">已上传</p>' +
                    '</div></fieldset>');
                //uploader.addFiles(file);
                num +=file.resSize;
            }
            var str = Calc.FileSizeByByte(num);

            $_(fileSizeNumDiv).val(str);
        },
        //失败时，将文件改为失败状态
        setErrorStates:function (file,msg) {
            file['myerror'] = true;
            file.setStatus('error',msg);
            $_('#' + file.uid).find('p.state').text('上传失败');
            $_('#' + file.uid).find('p.state').removeClass('layui-bg-blue');
        },
        //获取成功上传的文件组
        getFiles:function (data) {

            var list = [];
            var json = uploader.getFiles('complete');
            for(var i = 0 ; i < json.length ;i++){
                var now = {};
                if(!json[i].myerror)
                {
                    now['resSize'] = json[i].size;
                    now['resName'] = json[i].name;
                    now['type'] = json[i].type;
                    now['id'] = json[i].uid;
                    now['md5'] = json[i].md5;

                    list.push(now);
                }
                console.log(json[i].getStatus());
            }
            for( i = 0; i < uploadedList.length; i++) {
                var now = {};
                now['resSize'] = uploadedList[i].resSize;
                now['resName'] = uploadedList[i].resName;
                now['type'] = uploadedList[i].type;
                now['id'] = uploadedList[i].id;
                now['md5'] = uploadedList[i].md5;
                list.push(now);
            }
            return list;
        },
        getFilesSize:function () {
            var num = 0;
            var json = uploader.getFiles('complete');

            console.log(uploadedList);
            for(var i = 0 ; i < uploadedList.length ;i++){
                num += uploadedList[i].resSize;
            }

            for(var i = 0 ; i < json.length ;i++){
                if(!json[i].myerror)
                {
                    num += json[i].size;
                }
            }
            return num;
        },
        // 渲染表格
        init: function (param, data) {

            var $_fileMaxSize = isEmptyStr(param.fileMaxSize,$_Default_fileMaxSize);
            var $_btn = $_(isEmptyStr(param.ui.uploadBtn,$_Default_btn));
            $_thelist = $_(isEmptyStr(param.ui.uploadlistId,$_Default_list));
            var chunkSize =  isEmptyStr(param.uploadSet.chunkSize,$_Default_chunkSize);
            fileSizeNumDiv = isEmptyStr(param.ui.fileSizeInput,$_Default_fileSizeDiv);
            // HOOK 这个必须要再uploader实例化前面
            WebUploader.Uploader.register({
                'before-send-file': 'beforeSendFile',
                'before-send': 'beforeSend'
            }, {
                beforeSendFile: function (file) {
                    // Deferred对象在钩子回掉函数中经常要用到，用来处理需要等待的异步操作。
                    var task = new $_.Deferred();
                    // 根据文件内容来查询MD5
                    uploader.md5File(file).progress(function (percentage) {   // 及时显示进度
                        element.progress(file.id+'_filter', Calc.Per(Calc.Mul(percentage,0.3),1,2));
                    }).then(function (val) { // 完成
                        file.md5 = val;
                        // 模拟用户id
                        // file.uid = new Date().getTime() + "_" + Math.random() * 100;


                        // 进行md5判断
                        $_.post(param.Md5Url, webupload.esayFile(file),
                            function (data) {

                                var status = data.code;
                                task.resolve();

                                if (status == 701) {
                                    // 文件不存在，那就正常流程
                                } else if (status == 700) {
                                    // 忽略上传过程，直接标识上传成功；
                                    uploader.skipFile(file);
                                    element.progress(file.id+'_filter', '100%');
                                    file.pass = true;
                                } else if (status == 702) {
                                    // 部分已经上传到服务器了，但是差几个模块。
                                    file.missChunks = data.data;
                                } else if(status == 703){//失败

                                    webupload.setErrorStates(file,data.msg);
                                }
                            });
                    });
                    return $_.when(task);
                },
                beforeSend: function (block) {
                    var task = new $_.Deferred();
                    var file = block.file;
                    var missChunks = file.missChunks;
                    var blockChunk = block.chunk;
                    if (missChunks !== null && missChunks !== undefined && missChunks !== '') {
                        var flag = true;
                        for (var i = 0; i < missChunks.length; i++) {
                            if (blockChunk == missChunks[i]) {
                                console.log(file.name + ":" + blockChunk + ":还没上传，现在上传去吧。");
                                flag = false;
                                break;
                            }
                        }
                        if (flag) {
                            task.reject();
                        } else {
                            task.resolve();
                        }
                    } else {
                        task.resolve();
                    }
                    return $_.when(task);
                }
            });

            // 实例化
            uploader = WebUploader.create({
                pick: {
                    id:  isEmptyStr(param.ui.windowsId,$_Default_div),//绑定到指定选择器
                    label: '选择文件'
                },
                formData: {
                    uid: 0,
                    md5: '',
                    chunkSize: chunkSize
                },
                //dnd: '#dndArea',
                //paste: '#uploader',
                swf: 'js/Uploader.swf',
                chunked: true,
                chunkSize: chunkSize, // 字节 分块
                threads: isEmptyStr(param.uploadSet.threads,$_Default_threads),//上传并发数。允许同时最大上传进程数。
                server: param.uploadUrl,
                auto: false,

                // 禁掉全局的拖拽功能。这样不会出现图片拖进页面的时候，把图片打开。
                disableGlobalDnd: true,
                fileNumLimit: 1024,
                fileSizeLimit: isEmptyStr(param.uploadSet.fileListMaxSize,$_Default_fileListMaxSize),    // 200 M 文件组最大
                fileSingleSizeLimit: isEmptyStr(param.uploadSet.fileListMaxSize,$_Default_fileMaxSize)    // 50 M 单文件最大
            });


            // 当有文件被添加进队列之前触发
            uploader.on('beforeFileQueued', function (file) {
                if(file && file.size < $_fileMaxSize)
                {
                    return true;
                }
                layer.msg($_Str_Msg_MaxOut, {icon: 2});
                return false;
            });
            // 当有文件被添加进队列的时候
            uploader.on('fileQueued', function (file) {

                file.uid = WebUploader.Base.guid();

                $_thelist.append('<fieldset class="layui-elem-field site-demo-button fileListClass" uploadid="'+file.id+'" id="' + file.uid + '" >'+
                    '<legend class="info">' + file.name +
                    '<i class="layui-icon layui-icon-delete hand" style="font-size: 30px; color: #1E9FFF;"></i>  ' +
                    '</legend>' +
                    '<div class="listDivClass" style="width: 500px">' +
                    '<p class="state layui-badge layui-bg-blue">等待上传...</p>' +
                    '<div class="layui-progress layui-progress-big"id="'+file.id+'_filter" lay-filter="'+file.id
                    +'_filter"style="margin:10px 20px" lay-showPercent="true">' +
                    '<div class="layui-progress-bar" lay-percent="0%"></div>' +
                    '</div></div></fieldset>');
                //初始化进度条
                element.render('progress',file.id+'_filter');
            });


            //当某个文件的分块在发送前触发，主要用来询问是否要添加附带参数，大文件在开起分片上传的前提下此事件可能会触发多次。
            uploader.onUploadBeforeSend = function (obj, data) {
                var file = obj.file;
                data.md5 = file.md5 || '';
                data.uid = file.uid;
            };
            // 上传中
            uploader.on('uploadProgress', function (file, percentage) {
                element.progress(file.id+'_filter', Calc.Per(Calc.Add(Calc.Mul(percentage,0.7),0.3),1,2));
            });
            // 上传返回结果
            uploader.on('uploadSuccess', function (file) {
                var text = '已上传';
                /*if (file.pass) {
                    text = "文件秒传，文件已上传。"
                }*/
                if(file.myerror){

                }else {
                    $_('#' + file.uid).find('p.state').text(text);
                    $_('#' + file.uid).find('p.state').addClass('successText');
                    $_('#' + file.uid).find('p.state').removeClass('layui-bg-blue');
                    setFileSizeFun();//设置文件大小
                }

            });
            // 上传出错
            uploader.on('uploadError', function (file) {
                webupload.setErrorStates(file,"上传出错");
                $_('#' + file.uid).find('p.state').text('上传出错');
            });
            uploader.on('uploadComplete', function (file) {
                // 隐藏进度条
                fadeOutProgress(file);
            });
            // 文件上传
            $_btn.on('click', function () {
                uploader.upload();
            });

            //将文件从队列中移除
            $_thelist.on('click', '.layui-icon-delete', function() {
                //uploader.removeFile( uploader.getFile(file.id) );

                var id=$_(this).parents(".layui-elem-field").attr("id");


                if($_(this).parents(".layui-elem-field").hasClass('uploaded'))
                {
                    var jsonList = [];
                    for(var i = 0 ; i < uploadedList.length ;i++){
                        if(uploadedList[i].id != id)
                        {
                            jsonList.push(uploadedList[i]);
                        }
                    }
                    uploadedList = jsonList;
                    $_(this).parents(".layui-elem-field").remove();
                }else{
                    $_(this).parents(".layui-elem-field").remove();
                    uploader.removeFile(uploader.getFile(
                        $(this).parents(".layui-elem-field").attr('uploadid'),true));
                }

                setFileSizeFun();//重新计算文件总大小
                //map.remove(id);
            });

            //下载
            $_thelist.on('click', '.downloadBtn', function() {
                //uploader.removeFile( uploader.getFile(file.id) );

                var id=$_(this).parents(".layui-elem-field").attr("id");

                location.href = param.downLoadUrl+'?id='+id;

            });

            /**
             * 隐藏进度条
             * @param file 文件对象
             * @param id_Prefix id前缀
             */
            function fadeOutProgress(file) {
                console.log("隐藏进度条");
                $_('#' +file.id+'_filter').fadeOut();
            }

            /**
             * 设置文件大小框的内容
             */
            function setFileSizeFun() {
                var num = webupload.getFilesSize();

                var str = Calc.FileSizeByByte(num);

                $_(fileSizeNumDiv).val(str);
            }
        }
    };

    layui.link(layui.cache.base + 'webupload-lay/webupload.css');

    // 给图标列绑定事件
    /*$_('body').on('click', '.treeTable .treeTable-icon', function () {
        var treeLinkage = $_(this).parents('.treeTable').attr('treeLinkage');
        if ('true' == treeLinkage) {
            treetable.toggleRows($_(this), true);
        } else {
            treetable.toggleRows($_(this), false);
        }
    });*/

    exports('webupload', webupload);

    function isEmptyStr(data,defile) {
        if(data == null ||  data == undefined )
        {
            return defile;
        }
        //当传入为字符串时使用此方法
        if(Object.prototype.toString.call(data) === "[object String]")
        {
            if(data == '' || data == 'undefined' || data == 'null')
            {
                return defile;
            }
        }

        return data;
    }
});
