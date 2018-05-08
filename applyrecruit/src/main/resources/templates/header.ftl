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
    <#--<link rel="stylesheet" type="text/css" href="/bootstrap/bootstrap-combined.css">-->
    <#--<link href="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.1.1/css/bootstrap-combined.min.css" rel="stylesheet">-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="/css/magnific-popup.css">
    <link rel="stylesheet" type="text/css" href="/css/templatemo-style.css">
    <link rel="stylesheet" type="text/css" href="/css/style.css">

</head>
<body>

<!-- MENU -->
<section class="navbar custom-navbar navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="overlay"></div>
        <div class="navbar-header">
            <button class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">切换导航</span>
                <span class="icon icon-bar"></span>
                <span class="icon icon-bar"></span>
                <span class="icon icon-bar"></span>
            </button>

            <!-- lOGO TEXT HERE -->
            <a href="/" class="navbar-brand" style="color: #0b0b0b">Apply</a>
        </div>

        <!-- MENU LINKS -->
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav navbar-nav-first" id="navbar-collapse">
                <li><a href="/" class="smoothScroll">首页</a></li>
                <li class="dropdown">
                    <a href="#" style="background: transparent" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="100">职位列表<b class="caret"></b></a>
                    <ul class="dropdown-menu" style="background-color: #1e1e1c">
                        <li><a href="/position/position_review/全职">全职</a></li>
                        <li><a href="/position/position_review/兼职">兼职</a></li>
                        <li><a href="/position/position_review/实习">实习</a></li>
                    </ul>
                </li>
                <li><a href="/resume/getResume" class="smoothScroll">简历中心</a></li>
                <li><a href="#" class="smoothScroll">职位收藏</a></li>
                <li><a href="/resume/jsonInfo" class="smoothScroll">问题反馈</a></li>
            </ul>

            <#if Session.user??>

            <ul class="nav navbar-nav navbar-right">
                <li><a><span class="glyphicon glyphicon-envelope"></span></a></li>
                <li class="dropdown">
                    <a class="dropdown-toggle" style="background: transparent" data-toggle="dropdown" data-hover="dropdown" data-delay="100"><span class="glyphicon glyphicon-user"></span><span class="glyphicon glyphicon-th-list"></span></a>
                    <ul class="dropdown-menu" style="background-color: #1e1e1c">
                        <li><a href="/user/logout"><span class="glyphicon glyphicon-off"></span>注销</a></li>
                    </ul>
                </li>
            </ul>

            <#else>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#"><i class="fa fa-facebook-square"></i></a></li>
                <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                <li><a href="#"><i class="fa fa-instagram"></i></a></li>
                <li class="section-btn"><a href="#" data-toggle="modal" data-target="#modal-form"><span class="glyphicon glyphicon-user"></span>Sign in / up</a></li>
            </ul>
            </#if>
        </div>

    </div>
</section>

<!-- MODAL -->
<section class="modal fade" id="modal-form" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content modal-popup">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">

                        <div class="col-md-12 col-sm-12">
                            <div class="modal-title">
                                <h2>Apply</h2>
                            </div>

                            <!-- NAV TABS -->
                            <ul class="nav nav-tabs" role="tablist">
                                <li class="active"><a href="#sign_in" aria-controls="sign_in" role="tab" data-toggle="tab">登录</a></li>
                                <li><a href="#sign_up" aria-controls="sign_up" role="tab" data-toggle="tab">注册</a></li>
                            </ul>

                            <!-- TAB PANES -->
                            <div class="tab-content">
                                <div role="tabpanel" class="tab-pane fade in active" id="sign_in">
                                    <form action="/user/login" method="post">
                                        <input type="text" class="form-control" name="userName" placeholder="UserName" required>
                                        <input type="password" class="form-control" name="password" placeholder="Password" required>
                                        <input type="submit" class="form-control" name="submit" value="确认">
                                        <a href="#">忘记密码?</a>
                                    </form>
                                </div>
                                <div role="tabpanel" class="tab-pane fade in" id="sign_up">
                                    <form action="#" method="post">
                                        <input type="text" class="form-control" name="name" placeholder="Name" required>
                                        <input type="telephone" class="form-control" name="telephone" placeholder="Telephone" required>
                                        <input type="email" class="form-control" name="email" placeholder="Email" required>
                                        <input type="password" class="form-control" name="password" placeholder="Password" required>
                                        <input type="submit" class="form-control" name="submit" value="确认">
                                    </form>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
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
</body>
</html>