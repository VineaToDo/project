<!DOCTYPE html>
<html lang="en" style="height: 100%">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>管理员</title>
    <!--Insdep For EasyUI 主样式表 (必须)-->
    <link href="/insdep/insdep.easyui.min.css" rel="stylesheet" type="text/css">
    <!--
        Insdep For EasyUI 主样式表 (可选)
        icon.css     美化后的EasyUI自带的图片图标
        iconfont.css 来自iconfont.cn的字体图标库 (默认情况下，Insdep提供了一些测试用的图标，可自行前往iconfont.cn选择自己的图标库并覆盖到insdep/iconfont目录内)
    -->
    <link href="/insdep/icon.css" rel="stylesheet" type="text/css">
    <link href="/insdep/iconfont/iconfont.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="/bootstrap/bootstrap.min.css">
    <style>
        .panel-group{max-height:770px;overflow: auto;}
        .leftMenu .panel-heading{font-size:14px;padding-left:20px;height:36px;line-height:36px;color:white;position:relative;cursor:pointer;}/*转成手形图标*/
        .leftMenu .panel-heading span{position:absolute;right:10px;top:12px;}
        .leftMenu .menu-item-left{padding: 2px; background: transparent; border:1px solid transparent;border-radius: 6px;}
        .leftMenu .menu-item-left:hover{background:#C4E3F3;border:1px solid #1E90FF;}
    </style>
</head>
<body style="height: 100%;">
<section class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <button class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">切换导航</span>
                <span class="icon icon-bar"></span>
            </button>
            <!-- lOGO TEXT HERE -->
            <a href="/user/recruit" class="navbar-brand">人才求职招聘后台管理系统</a>
        </div>

        <!-- MENU LINKS -->
        <div class="collapse navbar-collapse">

            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="100">控制面板</a>
                    <ul class="dropdown-menu" style="background-color: #797977">
                        <li><a href="#">修改用户信息和密码</a></li>
                    </ul>
                </li>

                <#--<#if Session.user??>-->
                    <li><a><span class="glyphicon glyphicon-envelope"></span></a></li>
                    <li class="dropdown">
                        <a class="dropdown-toggle" style="background: transparent" data-toggle="dropdown" data-hover="dropdown" data-delay="100"><span class="glyphicon glyphicon-user"></span><span class="glyphicon glyphicon-th-list"></span></a>
                        <ul class="dropdown-menu" style="background-color: #797977">
                            <li><a href="/user/logout"><span class="glyphicon glyphicon-off"></span>注销</a></li>
                        </ul>
                    </li>
                <#--</#if>-->
            </ul>
        </div>

    </div>
</section>
<div id="cc" class="easyui-layout" style="width: 100%;height: 92.5%">
    <#--<div region="north" title="后台管理系统" split="true" style="height:100px;"></div>-->
    <div region="south" iconCls="icon-reload" title="状态栏" split="true" style="height:200px;">
        <ul id="hintContainer" class="list-group"></ul>
    </div>
    <div region="west" title="功能导航" style="width:10%;padding: 5px;">
        <div class="panel-group table-responsive" fit="true" role="tablist">
            <div class="panel panel-primary leftMenu">
                <div class="panel-heading" id="userManageHeading" data-toggle="collapse" data-target="#userManage" role="tab">
                    <h4 class="panel-title">
                        <b class="glyphicon glyphicon-user"></b>&nbsp;用户管理
                        <span class="glyphicon glyphicon-chevron-up right"></span>
                    </h4>
                </div>
                <div id="userManage" class="panel-collapse collapse" role="tabpanel" aria-labelledby="userManageHeading">
                    <ul class="list-group">
                        <li class="list-group-item">
                            <button class="menu-item-left" title="/admin/relayUrl/personal_list">个人用户审核</button>
                        </li>
                        <li class="list-group-item">
                            <button class="menu-item-left" title="/admin/relayUrl/enterprise_list">企业用户审核</button>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="panel panel-primary leftMenu">
                <div class="panel-heading" id="positionManageHeading" data-toggle="collapse" data-target="#positionManage" role="tab">
                    <h4 class="panel-title">
                        <b class="glyphicon glyphicon-th"></b>&nbsp;职位管理
                        <span class="glyphicon glyphicon-chevron-up right"></span>
                    </h4>
                </div>
                <div id="positionManage" class="panel-collapse collapse" role="tabpanel" aria-labelledby="positionManageHeading">
                    <ul class="list-group">
                        <li class="list-group-item">
                            <button class="menu-item-left" title="/admin/relayUrl/positions_check">职位审核</button>
                        </li>
                        <li class="list-group-item">
                            <button class="menu-item-left" title="/admin/relayUrl/positionType_list">职位类别</button>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="panel panel-primary leftMenu">
                <div class="panel-heading" id="systemHeading" data-toggle="collapse" data-target="#systemSetting" role="tab">
                    <h4 class="panel-title">
                        <b class="glyphicon glyphicon-cog"></b>&nbsp;系统设置
                        <span class="glyphicon glyphicon-chevron-up right"></span>
                    </h4>
                </div>
                <div id="systemSetting" class="panel-collapse collapse" role="tabpanel" aria-labelledby="systemHeading">
                    <ul class="list-group">
                        <li class="list-group-item">
                            <button class="menu-item-left" title="/admin/relayUrl/dict_list">数据字典</button>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div region="center" title="主页面" style="padding:5px;background:#eee;">
        <div id="mainFrame" class="easyui-tabs" fit="true"></div>
    </div>
</div>


<!--JQuey库 (必须)-->
<script type="text/javascript" src="/insdep/jquery.min.js"></script>
<!--JQuey EasyUI库 (必须)-->
<script type="text/javascript" src="/insdep/jquery.easyui.min.js"></script>
<!--Insdep For EasyUI 增强配置文件 (必须)   说明：该文件用于配置语言包、表单高度、按钮高度及相关兼容性内容等可配置文件项。-->
<script type="text/javascript" src="/insdep/insdep.extend.min.js"></script>
<script src="/bootstrap/bootstrap.min.js"></script>
<script src="/bootstrap/bootstrap-hover-dropdown.min.js"></script>
<script>
    $(function(){
        $('.panel-heading').click(function(e){
            /*切换折叠指示图标*/
            $(this).find("span").toggleClass("glyphicon-chevron-down");
            $(this).find("span").toggleClass("glyphicon-chevron-up");
        });

        $('button[title]').click(function () {
            var src = $(this).attr('title');
            src = src + '?' + Math.floor(Math.random()*100000);
            var title = $(this).html();
            if($('#mainFrame').tabs('exists',title)){
                $('#mainFrame').tabs('select',title);
            }else {
                $('#mainFrame').tabs('add',{
                    title:title,
                    // content:'<div class="embed-responsive embed-responsive-16by9"><iframe class="embed-responsive-item" src="' + src + '"></iframe></div>',
                    content:'<iframe frameborder="0" style="width: 100%;height: 100%;" src="' + src + '"></iframe>',
                    closable:true
                });
            }
        });
    });
    function hintData(data) {
        var $hint = $('#hintContainer');
        $hint.append('<div id="myAlert" class="list-group-item list-group-item-'+ data.type  +' alert"><a href="#" class="close" data-dismiss="alert">&times;</a><strong>'+ data.data + '--' + (new Date()).Format('yyyy-MM-dd HH:mm:ss') + '</strong></div>');
    }

    // 对Date的扩展，将 Date 转化为指定格式的String
    // 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，
    // 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)
    Date.prototype.Format = function (fmt) { //author: meizz
        var o = {
            "M+": this.getMonth() + 1, //月份
            "d+": this.getDate(), //日
            "H+": this.getHours(), //小时
            "m+": this.getMinutes(), //分
            "s+": this.getSeconds(), //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }

</script>
</body>
</html>