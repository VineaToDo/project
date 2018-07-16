<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <title>企业用户</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" type="text/css" href="/bootstrap/bootstrapValidator.css">
    <style>
        #registerDiv
        {
            background: url('/images/register-bg.jpg') no-repeat;
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
        #registerDiv .panel{
            width: 500px;
            opacity: 0.8;
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
    <!-- 导航条 -->
    <#include "header.ftl">
    <div id="registerDiv">
        <div class="overLay">
            <div class="container">
                <div class="panel center-block">
                    <div class="panel-heading"><h3 class="panel-title">
                                普通用户注册<span id="tipText" class="pull-right"></span>
                    </h3></div>
                    <div class="panel-body">
                        <form id="registerForm" class="form-horizontal" role="form">
                            <div class="form-group">
                                <label class="control-label col-md-3 col-md-offset-1" for="userName">用户名：</label>
                                <div class="col-md-6"><input id="userName" type="text" class="form-control " name="userName" placeholder="输入用户名"></div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-3 col-md-offset-1" for="password">密码：</label>
                                <div class="col-md-6"><input id="password" type="password" class="form-control " name="password" placeholder="输入密码"></div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-3 col-md-offset-1" for="rePassword">确认密码：</label>
                                <div class="col-md-6"><input id="rePassword" type="password" class="form-control " name="rePassword" placeholder="确认密码"></div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-3 col-md-offset-1" for="phone">手机号：</label>
                                <div class="col-md-6"><input id="phone" type="text" class="form-control" name="phone" placeholder="输入手机号"></div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-3 col-md-offset-1" for="email">邮箱：</label>
                                <div class="col-md-6"><input id="email" type="email" class="form-control" name="email" placeholder="输入邮箱"></div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-3 col-md-offset-1">用户类型</label>
                                <div class="col-md-6">
                                    <label class="radio-inline"><input type="radio" name="roleId" value="1" checked>&nbsp;个人用户</label>
                                    <label class="radio-inline"><input type="radio" name="roleId" value="2">&nbsp;企业用户</label>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-5 col-md-offset-2">
                                    <button id="register" type="button" class="btn btn-success" style="width: 100%;">注册</button>
                                </div>
                                <div class="col-md-3" style="padding-left: 0;">
                                    <button type="reset" class="btn btn-danger" style="width: 100%;">重置</button>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-8 col-md-offset-2">
                                    <a href="/user/getLogin" type="button" class="btn btn-primary" style="width: 100%;">已有账号？立即登录</a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="resultModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content modal-popup">
                <div class="modal-header">
                    <h2 class="modal-title" id="myModalLabel">注册成功！</h2>
                </div>
                <div class="modal-footer">
                    <a href="/user/getLogin" type="button" class="btn btn-danger">立即登录</a>
                    <a href="/index/" type="button" class="btn btn-primary">返回首页</a>
                </div>
            </div>
        </div>
    </div>
    <script src="/bootstrap/bootstrapValidator.min.js"></script>
<script>

    $(function () {
        $('#registerForm').bootstrapValidator({
            message: '填写值无效',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields:{
                userName:{
                    message:'用户名无效',
                    validators:{
                        notEmpty:{message:'用户名不能为空'},
                        stringLength:{min:5,max:16,message:'用户名长度必须在5-16之间'},
                        regexp: {
                            regexp: /^[a-zA-Z0-9_]+$/,
                            message: '用户名由数字、字母和下划线组成'
                        },
                        remote:{
                            url:'/user/checkUsername',
                            message:'用户名已被注册',
                            delay:2000,
                            type:'POST'
                        }
                    }
                },
                password:{
                    validators:{
                        notEmpty:{message:'密码不能为空'},
                        stringLength:{min:6,max:16,message:'密码长度必须在6-16之间'},
                        identical:{field:'rePassword',message:'两次密码不一致'}
                    }
                },
                rePassword:{
                    validators:{
                        notEmpty:{message:'密码不能为空'},
                        identical:{field:'password',message:'两次密码不一致'}
                    }
                },
                phone:{
                    validators:{
                        notEmpty:{message:'手机号不能为空'},
                        regexp:{regexp:/^1[3|4|7|5|8][0-9]\d{4,8}$/,message:'不是合法的手机号'}
                    }
                },
                email:{
                    validators:{
                        notEmpty:{message:'邮箱不能为空'},
                        emailAddress:{message:'email格式不正确'}
                    }
                }
            }
        });

        $('#register').click(function () {
            var formValidate = $('#registerForm').data('bootstrapValidator');
            formValidate.validate();

            if(formValidate.isValid()){
                var data = $('#registerForm').serialize();
                $.ajax({
                    url:'/user/register',
                    type:'post',
                    data:data,
                    success:function (data) {
                        if(data.code == 200){
                            $('#resultModal').modal('toggle');
                        }else {
                            $('#tipText').text(data.msg);
                        }
                    }
                });

            }
        });
        $('#resultModal').on('show.bs.modal', centerModals);
        $(window).on('resize', centerModals);
    });
    /* center modal */
    function centerModals() {
        $('#resultModal').each(function(i) {
            var $clone = $(this).clone().css('display', 'block').appendTo('body');
            var top = Math.round(($clone.height() - $clone.find('.modal-content').height()) / 2);
            top = top > 0 ? top : 0;
            $clone.remove();
            $(this).find('.modal-content').css("margin-top", top);
        });
    }


</script>

</body>
</html>