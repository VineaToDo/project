<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <title>企业用户</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" type="text/css" href="/bootstrap/bootstrapValidator.css">
    <style>
        #loginDiv
        {
            background: url('/images/login-bg.jpg') no-repeat;
            background-size: cover;
            color: #fff;
            /*text-align: center;*/
            width: 100%;
            min-height: 100vh;
            padding-top: 10em;
            overflow: hidden;
            position: relative;
            color: black;
        }
        #loginDiv .panel{
            width: 500px;
            opacity: 0.9;
        }
        .overLay
        {
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.4);
            padding-top: 90px;
            padding-bottom: 90px;
            opacity: 0.7;
            top: 0;
            right: 0;
            left: 0;
        }
    </style>
</head>
<body>
    <!-- PRE LOADER -->
    <#--<section class="preloader">-->
        <#--<div class="spinner">-->
            <#--<span class="spinner-rotate"></span>-->
        <#--</div>-->
    <#--</section>-->
    <!-- 导航条 -->
    <#include "header.ftl">
    <div id="loginDiv">
        <div class="overLay">
            <div class="container">
                <div class="panel center-block" style="background-color: #f3f3f3;">
                    <div class="panel-heading"><h3 class="panel-title">系统登录</h3></div>
                    <div class="panel-body">
                        <form id="loginForm" class="form-horizontal" role="form">
                            <div class="form-group">
                                <div class="input-group col-md-6 col-md-offset-3">
                                    <span class="input-group-addon"><i class="fa fa-user fa-fw"></i></span><input id="userName" type="text" class="form-control" name="userName" placeholder="用户名">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group col-md-6 col-md-offset-3">
                                    <span class="input-group-addon"><i class="fa fa-key fa-fw"></i></span><input id="password" type="password" class="form-control" name="password" placeholder="密码">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-4 col-md-offset-3" style="padding: 0;">
                                    <img id="codeImg" src="/user/getGifCode">
                                </div>
                                <div class="col-md-2" style="padding: 0;">
                                    <input id="vCode" type="text" class="form-control" name="vCode" placeholder="验证码">
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-3 col-md-offset-3">
                                    <div class="checkbox" style="alignment: left;vertical-align: center;"><label><input id="rememberMe" type="checkbox" name="rememberMe">自动登录</label></div>
                                </div>
                                <div class="col-md-3">
                                    <span id="tipText"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-offset-3 col-md-6">
                                    <button id="login" type="button" class="btn btn-primary" style="width: 100%;">登录</button>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-offset-3 col-md-6">
                                    <a href="/user/getRegister" type="button" class="btn btn-success" style="width: 100%;">没有账号？立即注册</a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <script src="/bootstrap/bootstrapValidator.min.js"></script>
<script>

    $(function () {

        $('#codeImg').click(function () {
            var timestamp = new Date().getTime();
            $(this).attr('src',"/user/getGifCode?" + timestamp);
        });

        $('#loginForm').bootstrapValidator({
            message: '填写值无效',
            feedbackIcons: {
                // valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields:{
                userName:{
                    message:'用户名无效',
                    validators:{
                        notEmpty:{message:'用户名不能为空'},
                        // stringLength:{min:2,max:16,message:'用户名长度必须在6-16之间'},
                        regexp: {
                            regexp: /^[a-zA-Z0-9_]+$/,
                            message: '用户名由数字、字母和下划线组成'
                        }
                    }
                },
                password:{
                    validators:{
                        notEmpty:{message:'密码不能为空'}
                        // stringLength:{min:6,max:16,message:'用户名长度必须在6-16之间'}
                    }
                },
                vCode:{
                    validators:{
                        notEmpty:{message:'验证码不能为空'}
                    }
                }
            }
        });

        $('#login').click(function () {
            var formValidate = $('#loginForm').data('bootstrapValidator');
            formValidate.validate();

            if(formValidate.isValid()) {
                var data = {
                    userName: $('#userName').val(),
                    password: $('#password').val(),
                    rememberMe: $('#rememberMe').is(':checked'),
                    vCode: $('#vCode').val()
                };
                $.ajax({
                    url: '/user/login',
                    type: 'post',
                    data: data,
                    success: function (data) {
                        if (data.code == 200) {
                            window.location.href = data.data;
                        } else {
                            $('#tipText').text(data.msg);
                            var timestamp = new Date().getTime();
                            $('#codeImg').attr('src', "/user/getGifCode?" + timestamp);
                        }
                    }
                });
            }

        });
    })
</script>

</body>
</html>