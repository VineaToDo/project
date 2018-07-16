<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <title>职位详情</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <style>
        #collect{
            margin-top: 28px;
            text-align: right;
            font-size: 16px;
        }
        #collectClick{
            cursor: pointer;
        }
        .collected span:before{
            content: "\2605";
            color: gold;
            /*font-size: 20px;*/
        }
        .collected span:after{
            content: "已";
        }
    </style>
</head>
<body>
    <!-- 导航条 -->
    <#include "header.ftl">
    <div style="padding-top: 70px"></div>
    <!-- HOME -->
    <div class="container" style="padding-top: 60px;">
        <div class="row">
            <div class="col-md-8">
                    <div class="panel panel-info">
                        <div class="row panel-heading">
                            <div class="col-md-3"><h3>${position.name}</h3></div>
                            <div id="collect" class="col-md-2 col-md-offset-5"><a id="collectClick"><span class="glyphicon glyphicon-star-empty"></span>收藏</a></div>
                            <div class="col-md-2" style="margin-top: 20px;"><button id="btn_deliver_01" class="btn btn-primary" >投递职位</button></div>
                        </div>
                        <div class="panel-body">
                            <div class="row"><dl class="col-md-6 dl-horizontal">
                                <dt>职位月薪：</dt>
                                <dd>${position.salaryStr}</dd>
                            </dl><dl class="col-md-6 dl-horizontal">
                                <dt>工作地点：</dt>
                                <dd id="place"></dd>
                            </dl></div>
                            <div class="row"><dl class="col-md-6 dl-horizontal">
                                <dt>发布日期：</dt>
                                <dd>${position.updatedTime?string("yyyy-MM-dd")}</dd>
                            </dl><dl class="col-md-6 dl-horizontal">
                                <dt>工作性质：</dt>
                                <dd>${position.property}</dd>
                            </div>
                            <div class="row"><dl class="col-md-6 dl-horizontal">
                                <dt>工作经验：</dt>
                                <dd>${position.experience}</dd>
                            </dl><dl class="col-md-6 dl-horizontal">
                                <dt>最低学历：</dt>
                                <dd>${position.degreeStr}</dd>
                            </dl></div>
                            <div class="row"><dl class="col-md-6 dl-horizontal">
                                <dt>招聘人数：</dt>
                                <dd>${position.recruitNum}</dd>
                            </dl><dl class="col-md-6 dl-horizontal">
                                <dt>职位类别：</dt>
                                <dd>${position.jobType.name}</dd>
                            </dl></div>

                        </div>
                        <div class="panel-footer">
                            <div class="panel panel-default">
                                <div class="panel-heading"><h4 class="panel-title">职位描述</h4></div>
                                <div class="panel-body">
                                    <pre>${position.description}</pre>
                                </div>
                                <div class="panel-footer">
                                    <button id="btn_deliver_02" class="btn btn-lg btn-primary">投递职位</button>
                                    <button id="btn_inform" class="btn btn-warning pull-right" data-toggle="modal" data-target="#informModal"><i class="fa fa-warning"></i>&nbsp;举报</button>
                                </div>
                            </div>
                        </div>
                    </div>
                <#--</div>-->
            </div>
            <div class="col-md-4">
                <div class="thumbnail">
                <#assign company=position.companyInfo/>
                    <img src="<#if company.brandIcon??>${company.brandIcon}
                    <#else>/images/defaultIcon.jpg
                    </#if>">

                    <div class="caption">
                        <h3>${company.name}</h3>
                        <ul class="list-group">
                            <li class="list-group-item list-group-item-warning">公司规模：${company.dimensions}</li>
                            <li class="list-group-item list-group-item-warning">公司性质：${company.property}</li>
                            <li class="list-group-item list-group-item-warning">公司行业：${company.trade}</li>
                            <li class="list-group-item list-group-item-warning">公司简介：${company.introduction}</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <section class="modal fade" id="informModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content modal-popup">
                <div class="modal-header">
                    <h2 class="modal-title" id="myModalLabel">请输入举报理由</h2>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <form id="informForm" class="form-horizontal" role="form">
                            <div class="form-group">
                                <div class="col-md-6 col-md-offset-3">
                                    <input type="text" class="form-control" name="reason" id="reason">
                                </div>
                            </div>
                            <input type="hidden" name="positionId" id="positionId" value="${position.id}">
                        </form>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" id="btn_cancel" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="btn_save">提交</button>
                </div>
            </div>
        </div>
    </section>
<script>
    $(function () {
        var $collectClick = $('#collectClick'),$inform = $('#btn_inform'),$save = $('#btn_save');
        <#if Session.user??>
            <#if isDelivered == true>
                $('#btn_deliver_01,#btn_deliver_02').prop('disabled',true).html("已投递");
            </#if>
            $collectClick.toggleClass('collected',${isCollected?c});
        </#if>

        $.getJSON('/json/sql_areas.json',function(data){
            for (var i = 0; i < data.length; i++) {
                if(data[i].id == ${position.workplace}){
                    $('#place').text(data[i].cname);
                }
            }
        });

        $('#btn_deliver_01,#btn_deliver_02').click(function () {
            <#if Session.user??>
                <#if Session.user.resumeInfo?? && Session.user.resumeInfo.personalInfo??>
                    $.ajax({
                        url:'/deliver/pushResume?positionId=${position.id}',
                        type:'POST',
                        success:function (data) {
                            if(data.code != 0){
                                toastr.success(data.msg);
                                $('#btn_deliver_01,#btn_deliver_02').prop('disabled',true).html("已投递");
                            }else {
                                toastr.error(data.msg);
                            }
                            console.log(data.msg);
                        }
                    });
                <#else>
                window.location.href = "/resume/getResume";
                </#if>
            <#else>
            window.location.href = "/user/getLogin";
            </#if>

        });

        $('#collectClick').click(function () {
            <#if Session.user??>
                $.ajax({
                    url:'/index/collectPosition?positionId=${position.id}',
                    type:'POST',
                    success:function (data) {
                        if(data.code == 1){
                            toastr.success(data.msg);
                            $collectClick.toggleClass('collected',true);
                        }else if(data.code == 2){
                            toastr.warning(data.msg);
                            $collectClick.toggleClass('collected',false);
                        }
                    }
                });
            <#else >
            window.location.href = "/user/getLogin";
            </#if>
        });
        $inform.click(function () {
            <#if Session.user??>
                return true;
            <#else >
            window.location.href = "/user/getLogin";
            </#if>
        });

        $save.click(function () {
            var data = $('#informForm').serialize();
            $.ajax({
                url:'/index/informPosition',
                type:'POST',
                data:data,
                success:function (data) {
                    if (data.code == 1) {
                        toastr.success(data.msg);
                    }else {
                        toastr.error(data.msg);
                    }
                    console.log(data.msg);
                    setTimeout(function () {
                        window.location.reload(true);
                    },2000);

                }
            });
        });
    });
    /* center modal */
    function centerModals() {
        $('#informModal').each(function(i) {
            var $clone = $(this).clone().css('display', 'block').appendTo('body');
            var top = Math.round(($clone.height() - $clone.find('.modal-content').height()) / 2);
            top = top > 0 ? top : 0;
            $clone.remove();
            $(this).find('.modal-content').css("margin-top", top);
        });
    }
    $('#informModal').on('show.bs.modal', centerModals);
    $(window).on('resize', centerModals);
</script>
</body>
</html>