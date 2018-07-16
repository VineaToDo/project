<html>
<head>
    <title>简历信息</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" type="text/css" href="/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/bootstrap/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" type="text/css" href="/css/toastr.css">
    <#--<link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css">-->
    <script src="/js/jquery.min.js"></script>
    <script src="/bootstrap/bootstrap.min.js"></script>
    <script src="/bootstrap/bootstrap-datetimepicker.min.js"></script>
    <script src="/bootstrap/bootstrap-datetimepicker.zh-CN.js"></script>
    <script src="/js/toastr.min.js"></script>
    <style>
        #float{position:fixed;top:300px;right:200px;width:40px;z-index:400;}
        #float li{height:50px;overflow:hidden;}
        #top,#download,#btn_collect,#btn_relay,#btn_invite,#btn_refuse,#btn_inform{display:block;width:40px;height:42px;overflow:hidden;}
        #top{background:url(/img/top.png) no-repeat;}
        #download{background: url(/img/download.png) no-repeat;}
        #btn_collect{background: url(/img/collect.png) no-repeat;}
        #btn_relay{background: url(/img/relay.png) no-repeat;}
        #btn_invite{background: url(/img/invite.png) no-repeat;}
        #btn_refuse{background: url(/img/refuse.png) no-repeat;}
        #btn_inform{background: url(/img/inform.png) no-repeat;}
        #top:hover{background:url(/img/toped.png) no-repeat;}
        #btn_collect:hover{background: url(/img/collected.png) no-repeat;}
    </style>
    <script>
        toastr.options.positionClass = 'toast-center-center';
        $(function () {
            var $download = $('#download'), $collect = $('#btn_collect'),$relay = $('#btn_relay'),$send = $('#btn_send'),$refuse = $('#btn_confirm'),$save = $('#btn_save');
            $(window).scroll(function() {
                if ($(window).scrollTop() > 300) {
                    $('#float li:eq(0)').fadeIn(800);
                } else {
                    $('#float li:eq(0)').fadeOut(800);
                }
            });

            $("#top").click(function() {
                $('body,html').animate({
                            scrollTop: 0
                        },
                        1000);
            });
            <#if collected>
                $collect.prop('style','background: url(/img/collected.png) no-repeat;');
                $collect.prop('title','取消收藏');
            </#if>

            $collect.click(function () {
                $.ajax({
                    url:'/deliver/collectDeliver',
                    type:'POST',
                    contentType:'application/x-www-form-urlencoded',
                    data:{deliverId:${deliverId}},
                    success:function(data){
                        if(data.code == 1){
                            toastr.success("操作成功");
                            setTimeout(function () {
                                window.location.reload(true);
                            },2000);
                        }else {
                            toastr.error("操作失败");
                        }
                        console.log(data.msg);
                    }
                });
            });
            $relay.click(function () {
                var data = {id:${deliverId},available:3};
                ajaxSubmit(data);
            });

            $('#interviewTimepicker').datetimepicker({
                language: 'zh-CN',
                todayHighlight: true,
                format:'yyyy-mm-dd hh:ii',
                weekStart: 0, /*以星期一为一星期开始*/
                startDate:new Date(),
                autoclose: 1,
                startView: 'year',
                zIndex:1600,
                minView:'hour', /*精确到分*/
                pickerPosition: "bottom-left"
            })

            $('#editModal').on('show.bs.modal',centerModals);
            $('#refuseModal').on('show.bs.modal',centerModals);
            $(window).on('resize', centerModals);

            $send.click(function () {
                var data = $('#editForm').serialize();
                ajaxSubmit(data);
            });
            $refuse.click(function () {
                var data = $('#refuseForm').serialize();
                ajaxSubmit(data);
            });
            $save.click(function () {
                var data = $('#informForm').serialize();
                $.ajax({
                    url:'/deliver/inform',
                    type:'POST',
                    contentType:'application/x-www-form-urlencoded',
                    data:data,
                    success:function(data){
                        console.log(data.msg);
                        if(data.code == 1){
                            toastr.success(data.msg);
                            window.location.reload(true);
                        }else {
                            toastr.error(data.msg);
                        }
                    }
                });
            });

            <#--$download.click(function () {-->
                <#--$.ajax({-->
                    <#--url:'/deliver/downloadDeliver',-->
                    <#--type:'POST',-->
                    <#--data:{deliverId:${deliverId}},-->
                    <#--contentType:'application/x-www-form-urlencoded',-->
                <#--})-->
            <#--});-->
        });

        /* center modal */
        function centerModals() {
            $('#editModal,#refuseModal').each(function(i) {
                var $clone = $(this).clone().css('display', 'block').appendTo('body');
                var top = Math.round(($clone.height() - $clone.find('.modal-content').height()) / 2);
                top = top > 0 ? top : 0;
                $clone.remove();
                $(this).find('.modal-content').css("margin-top", top);
            });
        }
        
        function ajaxSubmit(data) {
            $.ajax({
                url:'/deliver/feedback',
                type:'POST',
                contentType:'application/x-www-form-urlencoded',
                data:data,
                success:function(data){
                    console.log(data.msg);
                    if(data.code == 1){
                        toastr.success(data.msg);
                        setTimeout(function () {
                            window.location.reload(true);
                        },2000);
                    }else {
                        toastr.error(data.msg);
                    }
                }
            });
        }

    </script>
</head>
<body>
    <section id="recruit">
        <ul id="float" class="nav nav-tabs nav-stacked">
            <li style="display:none;"><button id="top" href="#top"></button></li>
            <li><a href="/deliver/downloadDeliver?deliverId=${deliverId}" id="download" class="btn btn-default" title="保存到本地"></a></li>
            <li><button id="btn_collect" class="btn btn-default" title="收藏"></button></li>
            <#if available == 0 || available == 1>
            <li><button id="btn_relay" class="btn btn-default" title="待沟通"></button></li>
            <li><button id="btn_invite" class="btn btn-default" data-toggle="modal" data-target="#editModal" title="面试邀请"></button></li>
            <li><button id="btn_refuse" class="btn btn-default" data-toggle="modal" data-target="#refuseModal" title="暂不合适"></button></li>
            </#if>
            <li><button id="btn_inform" class="btn btn-default" data-toggle="modal" data-target="#informModal" title="举报"></button></li>
        </ul>
        <div class="container">
            <div class="panel panel-danger">
                <div class="panel-heading"><h3>应聘职位：${position.name}</h3>
                <#if available == 2><label class="panel-title label label-success">已邀请面试</label>
                <#elseif available == 3><label class="panel-title label label-warning">正在进一步沟通</label>
                <#elseif available == 4><label class="panel-title label label-danger">已拒绝</label>
                </#if></div>
                <div class="panel-body">
                    <div class="list-group">
                    <#if personalInfo??>
                    <div class="list-group-item list-group-item-info">
                        <h3 class="list-group-item-heading">${personalInfo.name}</h3>
                        <div class="media list-group-item-text">
                            <div class="media-body">
                                <dl class="dl-horizontal">
                                    <dt>性别</dt>
                                    <dd><#if personalInfo.gender = 1>男<#else >女</#if></dd>
                                    <dt>手机</dt>
                                    <dd>${personalInfo.phone}</dd>
                                    <dt>邮箱</dt>
                                    <dd>${personalInfo.email}</dd>
                                    <dt>生日</dt>
                                    <dd>${personalInfo.birthday?string("yyyy-MM-dd")}</dd>
                                    <#if personalInfo.city??>
                                        <dt>所在地</dt>
                                        <dd>${personalInfo.city}</dd>
                                    </#if>
                                    <dt>工作时间</dt>
                                    <dd>${personalInfo.workYear?string("yyyy-MM")}</dd>
                                    <#if personalInfo.marital??>
                                        <dt>婚姻状况</dt>
                                        <dd>${personalInfo.maritalValue}</dd>
                                    </#if>
                                    <#if personalInfo.politics??>
                                        <dt>政治面貌</dt>
                                        <dd>${personalInfo.politicsValue}</dd>
                                    </#if>
                                </dl>
                            </div>
                            <li class="media-right media-middle" style="border: 1px solid" href="#">
                                <img src="/images/photoDefault.jpg" class="img-rounded" alt="">
                            </li>
                        </div>
                    </div>
                    </#if>
                    <#if educationList??&& educationList?size != 0>
                    <div class="list-group-item">
                        <h3 class="list-group-item-heading">教育背景</h3>
                        <#list educationList as edu>
                                    <dl class="dl-horizontal list-group-item-text">
                                        <dt>${edu.beginDate?string("yyyy.MM")}&ensp;--&ensp;${edu.endDate?string("yyyy.MM")}</dt>
                                        <dd><p>${edu.school}&emsp;|&emsp;${edu.major}&emsp;|&emsp;${edu.degreeValue}&emsp;|&emsp;<#if edu.single=0>非</#if>统招</p></dd>
                                    </dl>
                        </#list>
                    </div>
                    </#if>
                    <#if workList??&& workList?size != 0>
                    <div class="list-group-item">
                        <h3 class="list-group-item-heading">工作经历</h3>
                        <#list workList as work>
                                    <dl class="dl-horizontal list-group-item-text">
                                        <dt>${work.beginDate?string("yyyy.MM")}&ensp;--&ensp;${work.endDate?string("yyyy.MM")}</dt>
                                        <dd><p>${work.companyName}&emsp;|&emsp;${work.position}&emsp;|&emsp;${work.trade}&emsp;|&emsp;${work.propertyValue}&emsp;|&emsp;规模：${work.dimensionsValue}&emsp;|&emsp;月薪：${work.salaryValue}<br>
                                            <pre>${work.description}</pre>
                                            </p></dd>
                                    </dl>
                        </#list>
                    </div>
                    </#if>
                    <#if internshipList??&& internshipList?size != 0>
                    <div class="list-group-item">
                        <h3 class="list-group-item-heading">实习经历</h3>
                        <#list internshipList as work>
                                    <dl class="dl-horizontal">
                                        <dt>${work.beginDate?string("yyyy.MM")}&ensp;--&ensp;${work.endDate?string("yyyy.MM")}</dt>
                                        <dd><p>${work.companyName}&emsp;|&emsp;${work.position}&emsp;|&emsp;${work.trade}&emsp;|&emsp;${work.propertyValue}&emsp;|&emsp;规模：${work.dimensionsValue}&emsp;|&emsp;月薪：${work.salaryValue}<br>
                                            <pre>${work.description}</pre>
                                            </p></dd>
                                    </dl>
                        </#list>
                    </div>
                    </#if>
                    <#if trainingList??&& trainingList?size != 0>
                    <div class="list-group-item">
                        <h3 class="list-group-item-heading">培训经历</h3>
                        <#list trainingList as training>
                                    <dl class="dl-horizontal">
                                        <dt>${training.beginDate?string("yyyy.MM")}&ensp;--&ensp;${training.endDate?string("yyyy.MM")}</dt>
                                        <dd><p>培训名称：${training.name}&emsp;|&emsp;培训机构：${training.name}<br>
                                            培训内容：${training.content}
                                        </p></dd>
                                    </dl>
                        </#list>
                    </div>
                    </#if>
                    <#if languageList??>
                    <div class="list-group-item">
                        <h3 class="list-group-item-heading">语言能力</h3>
                        <#list languageList as language>
                                    <dl class="dl-horizontal">
                                        <dt>${language.nameValue}:</dt>
                                        <dd><p>读写能力-${language.literacy}&emsp;|&emsp;听说能力-${language.speak}</p></dd>
                                    </dl>
                        </#list>
                    </div>
                    </#if>
                    <#if credentialList??&& credentialList?size != 0>
                    <div class="list-group-item">
                        <h3 class="list-group-item-heading">证书</h3>
                        <#list credentialList as credential>
                                    <dl class="dl-horizontal">
                                        <dt>${credential.obtainTime?string("yyyy.MM")}</dt>
                                        <dd><p>${credential.name}</p></dd>
                                    </dl>
                        </#list>
                    </div>
                    </#if>
                    <#if skillList??&& skillList?size != 0>
                    <div class="list-group-item">
                        <h3 class="list-group-item-heading">专业技能</h3>
                        <#list skillList as skill>
                                    <dl class="dl-horizontal">
                                        <dt>${skill.name}</dt>
                                        <dd><p>掌握程度-${skill.master}</p></dd>
                                    </dl>
                        </#list>
                    </div>
                    </#if>
                    <#if projectList??&& projectList?size != 0>
                    <div class="list-group-item">
                        <h3 class="list-group-item-heading">项目经历</h3>
                        <#list projectList as projectEx>
                                    <dl class="dl-horizontal">
                                        <dt>${projectEx.beginDate?string("yyyy.MM")}&ensp;--&ensp;${projectEx.endDate?string("yyyy.MM")}</dt>
                                        <dd><p>${projectEx.name}&emsp;|&emsp;规模：${projectEx.dimensions}<br>
                                            项目职责:<pre>${projectEx.duty}</pre>项目描述:<pre>${projectEx.description}</pre></p></dd>
                                    </dl>
                        </#list>
                    </div>
                    </#if>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- MODAL -->
    <section class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content modal-popup">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h3 class="modal-title" id="myModalLabel1">面试邀请</h3>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <form id="editForm" class="form-horizontal" role="form">
                            <div class="form-group">
                                <label for="interviewTime" class="col-md-4 control-label">面试时间</label>
                                <div class="col-md-6">
                                    <div class="input-group date" id="interviewTimepicker">
                                        <input type="text" class="form-control" id="interviewTime" name="interviewTime" readonly>
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span><span class="input-group-addon"><i class="glyphicon glyphicon-remove"></i></span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="interviewAddr" class="col-md-4 control-label">面试地点</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="interviewAddr" id="interviewAddr">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="contactName" class="col-md-4 control-label">联系人</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="contactName" id="contactName">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="contactPhone" class="col-md-4 control-label">联系方式</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="contactPhone" id="contactPhone">
                                </div>
                            </div>
                            <input type="hidden" name="id" value="${deliverId}">
                            <input type="hidden" name="available" id="available" value="2">
                        </form>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" id="btn_cancel" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="btn_send">发送</button>
                </div>
            </div>
        </div>
    </section>
    <section class="modal fade" id="refuseModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content modal-popup">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h3 class="modal-title" id="myModalLabel2">不合适原因</h3>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <form id="refuseForm" class="form-horizontal" role="form">
                            <div class="form-group">
                                <div class="checkbox">
                                    <label class="checkbox-inline"><input type="checkbox" name="reason" value="专业不合适">专业不合适</label>
                                    <label class="checkbox-inline"><input type="checkbox" name="reason" value="工作履历不符">工作履历不符</label>
                                    <label class="checkbox-inline"><input type="checkbox" name="reason" value="薪资要求过高">薪资要求过高</label>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="checkbox">
                                    <label class="checkbox-inline"><input type="checkbox" name="reason" value="行业相差较大">行业相差较大</label>
                                    <label class="checkbox-inline"><input type="checkbox" name="reason" value="项目经验偏少">项目经验偏少</label>
                                    <label class="checkbox-inline"><input type="checkbox" name="reason" value="其他原因">其他原因</label>
                                </div>
                            </div>
                            <input type="hidden" name="id" value="${deliverId}">
                            <input type="hidden" name="available" id="available" value="4">
                        </form>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" id="btn_cancel_re" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="btn_confirm">确定</button>
                </div>
            </div>
        </div>
    </section>
    <section class="modal fade" id="informModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel3" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content modal-popup">
                <div class="modal-header">
                    <h2 class="modal-title" id="myModalLabel3">举报该简历</h2>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <form id="informForm" class="form-horizontal" role="form">
                            <div class="form-group">
                                <label for="contactName" class="col-md-4 control-label">举报理由</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="reason" id="reason">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="contactName" class="col-md-4 control-label">联系人</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="contactName" id="contactName">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="contactPhone" class="col-md-4 control-label">联系方式</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="contactPhone" id="contactPhone">
                                </div>
                            </div>
                            <input type="hidden" name="id" value="${deliverId}">
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
</body>
</html>