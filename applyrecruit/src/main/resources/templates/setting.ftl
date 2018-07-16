<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" type="text/css" href="/bootstrap/bootstrapValidator.css">
    <title>账号设置</title>
    <style>
    </style>
</head>
<body>
<#if user.role.role == "apply">
    <#include "header.ftl">
<#else>
    <#include "./enterprise/header.ftl">
</#if>

    <section class="outer_box">
        <div class="row">
            <div class="col-md-2" style="padding-right: 0;">
                <ul class="nav nav-tabs nav-stacked">
                    <li class="active"><a href="#info" data-toggle="tab">账号信息设置</a></li>
                    <li><a href="#passwordTab" data-toggle="tab">修改密码</a></li>
                </ul>
            </div>
            <div class="col-md-9" style="padding-left: 0;">
                <div class="tab-content">
                    <div id="info" class="tab-pane fade active in">
                        <div class="panel panel-default">
                            <div class="panel-heading"><h4 class="panel-title">账号信息设置</h4></div>
                            <div class="panel-body">
                                <div class="container">
                                    <form id="infoForm" class="form-horizontal" role="form">
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">真实姓名：</label>
                                            <div class="col-md-3"><input id="name" name="name" type="text" class="form-control" value="<#if user.name??>${user.name}</#if>" required></div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">手机号：</label>
                                            <div class="col-md-3"><input id="phone" name="phone" type="text" class="form-control" value="<#if user.phone??>${user.phone}</#if>" required></div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">邮箱：</label>
                                            <div class="col-md-3"><input id="email" name="email" type="email" class="form-control" value="<#if user.email??>${user.email}</#if>" required></div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-md-3 col-md-offset-2">
                                                <button id="saveInfo" type="button" class="btn btn-success" style="width: 100%;">保存</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="passwordTab" class="tab-pane fade">
                        <div class="panel panel-default">
                            <div class="panel-heading"><h4 class="panel-title">修改密码</h4></div>
                            <div class="panel-body">
                                <form id="passwordForm" class="container form-horizontal" role="form">
                                    <div class="form-group">
                                        <label class="col-md-2 control-label">原密码</label>
                                        <div class="col-md-3"><input id="passwordOld" name="passwordOld" type="password" class="form-control"></div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-2 control-label">新密码</label>
                                        <div class="col-md-3"><input id="password" name="password" type="password" class="form-control"></div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-2 control-label">确认密码</label>
                                        <div class="col-md-3"><input id="rePassword" name="rePassword" type="password" class="form-control"></div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-md-3 col-md-offset-2">
                                            <button id="savePw" type="button" class="btn btn-info" style="width: 100%;">提交修改</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
<script src="/bootstrap/bootstrapValidator.min.js"></script>
<script>
    // toastr.options.positionClass = 'toast-center-center';
    $(function () {
        var $info = $('#infoForm'),$password = $('#passwordForm'),$saveInfo = $('#saveInfo'),$savePw = $('#savePw');
        $password.bootstrapValidator({
            live:'disabled',
            message:'填写值无效',
            feedbackIcons:{
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields:{
                passwordOld:{
                    validators:{
                        notEmpty:{message:'密码不能为空'},
                        remote:{
                            url:'/user/checkPassword',
                            message:'原密码不正确',
                            type:'POST'
                        }
                    }
                },
                password:{
                    validators:{
                        notEmpty:{message:'新密码不能为空'},
                        identical:{field:'rePassword',message:'两次密码不一致'}
                    }
                },
                rePassword:{
                    validators:{
                        notEmpty:{message:'该项不能为空'},
                        identical:{field:'password',message:'两次密码不一致'}
                    }
                }
            }
        }).on('success.form.bv',function (e) {
            $.ajax({
                url:'/user/updatePassword',
                data:{password:$('#password').val()},
                type:'post',
                success:function (data) {
                    if(data.code == 200){
                        toastr.success(data.msg);
                        $(e.target)[0].reset();
                        $(e.target).bootstrapValidator('resetForm');
                        // toastr.success('提示',data.msg);
                    }else {
                        toastr.error(data.msg);
                    }
                }
            })
        });

        $savePw.click(function () {
            var formValidate = $password.data('bootstrapValidator');
            formValidate.validate();
        });

        $saveInfo.click(function () {
            var data = $info.serialize();
            $.ajax({
                url:'/user/saveInfo',
                type:'post',
                data:data,
                success:function (data) {
                    if(data.code == 200){
                        toastr.success(data.msg);
                        setTimeout(function () {
                            window.location.reload(true);
                        },2000);

                    }
                }
            });
        });

    })
</script>

</body>
</html>