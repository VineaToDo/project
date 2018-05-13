<!DOCTYPE html>
<html lang="en" style="height: 100%">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Title</title>
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
<div id="cc" class="easyui-layout" style="width: 100%;height: 90%">
    <#--<div region="north" title="后台管理系统" split="true" style="height:100px;"></div>-->
    <div region="south" title="状态栏" split="true" style="height:100px;"></div>
    <div region="east" iconCls="icon-reload" title="操作中心" split="true" style="width:10%;"></div>
    <div region="west" title="功能导航" style="width:10%;padding: 5px;">
        <div class="panel-group table-responsive" fit="true" role="tablist">
            <div class="panel panel-primary leftMenu">
                <div class="panel-heading" id="userManageHeading" data-toggle="collapse" data-target="#userManage" role="tab">
                    <h4 class="panel-title">
                        <b class="glyphicon glyphicon-user"></b>用户管理
                        <span class="glyphicon glyphicon-chevron-up right"></span>
                    </h4>
                </div>
                <div id="userManage" class="panel-collapse collapse" role="tabpanel" aria-labelledby="userManageHeading">
                    <ul class="list-group">
                        <li class="list-group-item">
                            <button class="menu-item-left" title="/admin/relayUrl/personal_list">个人用户</button>
                        </li>
                        <li class="list-group-item">
                            <button class="menu-item-left" title="/admin/relayUrl/enterprise_list">企业用户</button>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="panel panel-primary leftMenu">
                <div class="panel-heading" id="positionManageHeading" data-toggle="collapse" data-target="#positionManage" role="tab">
                    <h4 class="panel-title">
                        <b class="glyphicon glyphicon-user"></b>职位管理
                        <span class="glyphicon glyphicon-chevron-up right"></span>
                    </h4>
                </div>
                <div id="positionManage" class="panel-collapse collapse" role="tabpanel" aria-labelledby="positionManageHeading">
                    <ul class="list-group">
                        <li class="list-group-item">
                            <button class="menu-item-left" data-target="">职位列表</button>
                        </li>
                        <li class="list-group-item">
                            <button class="menu-item-left" title="/admin/relayUrl/positionType_list">职位类别</button>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="panel panel-primary leftMenu">
                <div class="panel-heading" id="deliverManageHeading" data-toggle="collapse" data-target="#deliverManage" role="tab">
                    <h4 class="panel-title">
                        <b class="glyphicon glyphicon-user"></b>投递管理
                        <span class="glyphicon glyphicon-chevron-up right"></span>
                    </h4>
                </div>
                <div id="deliverManage" class="panel-collapse collapse" role="tabpanel" aria-labelledby="deliverManageHeading">
                    <ul class="list-group">
                        <li class="list-group-item">
                            <button class="menu-item-left" data-target="">投递列表</button>
                        </li>
                        <li class="list-group-item">
                            <button class="menu-item-left" data-target="">投递统计</button>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div region="center" title="主页面" style="padding:5px;background:#eee;">
        <div id="mainFrame" class="easyui-tabs" fit="true">

        </div>
    </div>
</div>


<!--JQuey库 (必须)-->
<script type="text/javascript" src="/insdep/jquery.min.js"></script>
<!--JQuey EasyUI库 (必须)-->
<script type="text/javascript" src="/insdep/jquery.easyui.min.js"></script>
<!--
    Insdep For EasyUI 增强配置文件 (必须)   说明：该文件用于配置语言包、表单高度、按钮高度及相关兼容性内容等可配置文件项。
-->
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
            var title = $(this).html();
            if($('#mainFrame').tabs('exists',title)){
                $('#mainFrame').tabs('select',title);
            }else {
                $('#mainFrame').tabs('add',{
                    title:title,
                    content:'<div class="embed-responsive embed-responsive-16by9"><iframe class="embed-responsive-item" src="' + src + '"></iframe></div>',
                    closable:true
                });
            }
        });

    });
</script>
</body>
</html>