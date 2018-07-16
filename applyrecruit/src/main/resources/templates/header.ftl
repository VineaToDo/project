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
    <link rel="stylesheet" type="text/css" href="/css/magnific-popup.css">
    <link rel="stylesheet" type="text/css" href="/css/templatemo-style.css">
    <link rel="stylesheet" type="text/css" href="/css/style.css">
    <link rel="stylesheet" type="text/css" href="/css/toastr.css">

</head>
<body>

<!-- MENU -->
<section class="navbar custom-navbar navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="overlay"  style="z-index: -1;"></div>
        <div class="navbar-header">
            <button class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">切换导航</span>
                <span class="icon icon-bar"></span>
                <span class="icon icon-bar"></span>
                <span class="icon icon-bar"></span>
            </button>

            <!-- lOGO TEXT HERE -->
            <a href="/index/" class="navbar-brand" style="color: #0b0b0b">Apply</a>
        </div>
        <!-- MENU LINKS -->
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav navbar-nav-first" id="navbar-collapse">
                <li><a href="/index/">首页</a></li>
                <li class="dropdown">
                    <a href="#" style="background: transparent" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="100">职位列表<b class="caret"></b></a>
                    <ul class="dropdown-menu" style="background-color: #1e1e1c">
                        <li><a href="/position/position_review?property=全职">全职</a></li>
                        <li><a href="/position/position_review?property=兼职">兼职</a></li>
                        <li><a href="/position/position_review?property=实习">实习</a></li>
                    </ul>
                </li>
                <li><a href="/resume/getResume">简历中心</a></li>
                <li><a href="/index/getCollectPosition">职位收藏</a></li>
                <li><a href="#">问题反馈</a></li>
            </ul>
            <#if Session.user??>

            <ul class="nav navbar-nav navbar-right">
                <li><a href="/index/getReply"><span class="glyphicon glyphicon-envelope"></span>&nbsp;<span class="badge"><#if count?? && count != 0>${count}</#if></span></a></li>
                <li class="dropdown">
                    <a href="" class="dropdown-toggle" style="background: transparent" data-toggle="dropdown" data-hover="dropdown" data-delay="100"><span class="glyphicon glyphicon-user"></span><span class="glyphicon glyphicon-th-list"></span></a>
                    <ul class="dropdown-menu" style="background-color: #1e1e1c">
                        <li><a href="/index/setting"><span class="fa fa-gear"></span> 账号设置</a></li>
                        <li><a href="/user/logout"><span class="fa fa-sign-out"></span> 注销</a></li>

                    </ul>
                </li>
            </ul>

            <#else>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="/user/getLogin" title="登录"><i class="fa fa-sign-in fa-lg"></i></a></li>
                <li><a href="/user/getRegister" title="注册"><i class="fa fa-edit fa-lg"></i></a></li>
            </ul>
            </#if>
            <form id="searchForm" action="/index/searchPosition" class="navbar-form navbar-right" role="search" target="_blank" method="post">
                <div class="form-group">
                    <input class="form-control" type="text" name="key" placeholder="搜索职位关键词">
                </div>
                <button type="submit" class="btn btn-default" target="_blank">查找</button>
            </form>
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
<script src="/js/jquery.stellar.min.js"></script>
<script src="/js/jquery.magnific-popup.min.js"></script>
<script src="/js/smoothscroll.js"></script>
<script src="/js/custom.js"></script>
<script src="/js/toastr.min.js"></script>
<script>
    toastr.options.positionClass = 'toast-center-center';
</script>

</body>
</html>