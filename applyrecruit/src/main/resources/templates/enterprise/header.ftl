<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" type="text/css" href="/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/bootstrap/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" type="text/css" href="/bootstrap/bootstrap-select.min.css">
    <link rel="stylesheet" type="text/css" href="/bootstrap/bootstrap-chinese-region.css">
    <link rel="stylesheet" type="text/css" href="/bootstrap/bootstrap-table.css">
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="/css/style.css">
    <#--<link rel="stylesheet"type="text/css" href="/css/templatemo-style.css">-->

</head>
<body>

<!-- MENU -->
<section class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <#--<div class="overlay"></div>-->
        <div class="navbar-header">
            <button class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">切换导航</span>
                <span class="icon icon-bar"></span>
                <span class="icon icon-bar"></span>
                <span class="icon icon-bar"></span>
            </button>

            <!-- lOGO TEXT HERE -->
            <a href="/user/recruit" class="navbar-brand">Recruit</a>
        </div>

        <!-- MENU LINKS -->
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav" id="navbar-collapse">
                <li><a href="/user/recruit" class="smoothScroll">首页</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="100">职位管理<b class="caret"></b></a>
                    <ul class="dropdown-menu" style="background-color: #797977">
                        <li><a href="/position/editPosition">发布新职位</a></li>
                        <li><a href="/position/getPosition">管理职位列表</a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="100">简历管理<b class="caret"></b></a>
                    <ul class="dropdown-menu" style="background-color: #797977">
                        <li><a href="#">收件箱</a></li>
                        <li><a href="#">收藏夹</a></li>
                    </ul>
                </li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="100">控制面板</a>
                    <ul class="dropdown-menu" style="background-color: #797977">
                        <li><a href="#">修改用户信息和密码</a></li>
                        <li><a href="/company/editCompanyInfo">修改公司信息</a></li>
                        <li><a href="/company/deptPage">设置部门结构</a></li>
                    </ul>
                </li>

                <#if Session.user??>
                    <li><a><span class="glyphicon glyphicon-envelope"></span></a></li>
                    <li class="dropdown">
                        <a class="dropdown-toggle" style="background: transparent" data-toggle="dropdown" data-hover="dropdown" data-delay="100"><span class="glyphicon glyphicon-user"></span><span class="glyphicon glyphicon-th-list"></span></a>
                        <ul class="dropdown-menu" style="background-color: #797977">
                            <li><a href="/user/logout"><span class="glyphicon glyphicon-off"></span>注销</a></li>
                        </ul>
                    </li>
                </#if>
            </ul>
        </div>

    </div>
</section>

<script src="/js/jquery.min.js"></script>
<script src="/bootstrap/bootstrap.min.js"></script>
<script src="/bootstrap/bootstrap-datetimepicker.min.js"></script>
<script src="/bootstrap/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="/bootstrap/bootstrap-select.min.js"></script>
<script src="/bootstrap/bootstrap-chinese-region.js"></script>
<script src="/bootstrap/defaults-zh_CN.js"></script>
<script src="/bootstrap/bootstrap-hover-dropdown.min.js"></script>
<script src="/js/smoothscroll.js"></script>
<script src="/js/custom.js"></script>
</body>
</html>