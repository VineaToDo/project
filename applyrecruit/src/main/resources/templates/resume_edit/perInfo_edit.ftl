<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Title</title>
    <style>
        .outer_box{
            width: 960px;
            height: auto;
            padding-top: 8em;
            text-align: left;
            margin-left: auto;
            margin-right: auto;
            clear: both;
        }
    </style>
</head>
<body>
    <#include "../header.ftl">

    <section class="outer_box">
        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title">编辑基本信息</h3>
            </div>
            <div class="panel-body">
                <form action="/resume/updatePersonal" class="form-horizontal" role="form" method="post">
                    <div class="form-group">
                        <label for="phone" class="col-md-offset-2 col-md-2 control-label">手机</label>
                        <div class="col-md-5"><input type="text" class="form-control" id="phone" placeholder="请输入手机号" name="phone" <#if personalInfo??> value="${personalInfo.phone}" </#if>></div>
                    </div>
                    <div class="form-group">
                        <label for="email" class="col-md-offset-2 col-md-2 control-label">邮箱</label>
                        <div class="col-md-5"><input type="email" class="form-control" id="email" placeholder="请输入邮箱" name="email" <#if personalInfo??> value="${personalInfo.email}" </#if>></div>
                    </div>
                    <div class="form-group">
                        <label for="name" class="col-md-offset-2 col-md-2 control-label">真实姓名</label>
                        <div class="col-md-5"><input type="text" class="form-control" id="name" placeholder="请输入真实姓名" name="name" <#if personalInfo??> value="${personalInfo.name}" </#if>></div>
                    </div>
                    <div class="form-group">
                        <label for="gender" class="col-md-offset-2 col-md-2 control-label">性别</label>
                        <div class="col-md-5" id="genderDiv"></div>
                    </div>
                    <div class="form-group">
                        <label for="address" class="col-md-offset-2 col-md-2 control-label">所在地</label>
                        <div class="col-md-5">
                            <div class="bs-chinese-region flat dropdown" data-min-level="1" data-max-level="3" data-def-val="[name=address]">
                                <input type="text" class="form-control" id="address" placeholder="请选择所在地" data-toggle="dropdown" readonly="">
                                <input type="hidden" class="form-control" name="address" <#if personalInfo?? && personalInfo.address??>value="${personalInfo.address}" </#if>>
                                <div class="dropdown-menu" role="menu" aria-labelledby="dLabel">
                                    <div>
                                        <ul class="nav nav-tabs" role="tablist">
                                            <li role="presentation" class="active"><a href="#province" data-next="city" role="tab" data-toggle="tab">省份</a></li>
                                            <li role="presentation"><a href="#city" data-next="district" role="tab" data-toggle="tab">城市</a></li>
                                            <li role="presentation"><a href="#district" data-next="street" role="tab" data-toggle="tab">县区</a></li>
                                        </ul>
                                        <div class="tab-content">
                                            <div role="tabpanel" class="tab-pane active" id="province">--</div>
                                            <div role="tabpanel" class="tab-pane" id="city">--</div>
                                            <div role="tabpanel" class="tab-pane" id="district">--</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="birthday" class="col-md-offset-2 col-md-2 control-label">出生日期</label>
                        <div class="col-md-5"><div class="input-group date" id="birthdaypicker">
                                <input type="text" class="form-control" id="birthday" name="birthday" <#if personalInfo?? && personalInfo.birthday??>value="${personalInfo.birthday?string("yyyy-MM-dd")}" </#if>readonly>
                                <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span><span class="input-group-addon"><i class="glyphicon glyphicon-remove"></i></span>
                        </div></div>
                    </div>
                    <div class="form-group">
                        <label for="workYear" class="col-md-offset-2 col-md-2 control-label">工作年份</label>
                        <div class="col-md-5"><div class="input-group date" id="workYearpicker">
                                <input type="text" class="form-control" id="workYear" name="workYear" <#if personalInfo?? && personalInfo.workYear??>value="${personalInfo.workYear?string("yyyy-MM")}" </#if> readonly>
                                <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span><span class="input-group-addon"><i class="glyphicon glyphicon-remove"></i></span>
                        </div></div>
                    </div>
                    <div class="form-group">
                        <label for="politics" class="col-md-offset-2 col-md-2 control-label">政治面貌</label>
                        <div class="col-md-5" id="politicsDiv">
                            <#--<label class="radio-inline">-->
                                <#--<input type="radio" id="politics1" name="politics" value="中共党员(含预备党员)" checked>中共党员(含预备党员)-->
                            <#--</label>-->
                            <#--<label class="radio-inline">-->
                                <#--<input type="radio" id="politics2" name="politics" value="团员">团员-->
                            <#--</label>-->
                            <#--<label class="radio-inline">-->
                                <#--<input type="radio" id="politics3" name="politics" value="群众">群众-->
                            <#--</label>-->
                            <#--<label class="radio-inline">-->
                                <#--<input type="radio" id="politics4" name="politics" value="民主党派">民主党派-->
                            <#--</label>-->
                            <#--<label class="radio-inline">-->
                                <#--<input type="radio" id="politics5" name="politics" value="其他">其他-->
                            <#--</label>-->
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="marital" class="col-md-offset-2 col-md-2 control-label">婚姻状况</label>
                        <div class="col-md-5" id="maritalDiv">
                            <#--<label class="radio-inline">-->
                                <#--<input type="radio" id="marital1" name="marital" value="未婚" checked>未婚-->
                            <#--</label>-->
                            <#--<label class="radio-inline">-->
                                <#--<input type="radio" id="marital2" name="marital" value="已婚">已婚-->
                            <#--</label>-->
                            <#--<label class="radio-inline">-->
                                <#--<input type="radio" id="marital3" name="marital" value="离异">离异-->
                            <#--</label>-->
                        </div>
                    </div>
                    <input type="hidden" name="id" value="${personalInfo.id}">
                    <div class="form-group">
                        <div class="col-md-push-7 col-md-9">
                            <button type="submit" class="btn btn-primary">保存</button>
                            <a href="javascript:history.back()" class="btn btn-warning">取消</a>
                        </div>
                    </div>
                </form>
        </div>
    </section>
<script>
    $('#birthdaypicker').datetimepicker({
        language: 'zh-CN',
        todayHighlight: true,
        // todayBtn: true.toSource
        format:'yyyy-mm-dd',
        weekStart: 0, /*以星期一为一星期开始*/
        autoclose: 1,
        minView:'month', /*精确到天*/
        pickerPosition: "bottom-left"
    }).on("changeDate",function (ev) {

    });
    $('#workYearpicker').datetimepicker({
        language: 'zh-CN',
        todayHighlight: true,
        // todayBtn: true.toSource
        format:'yyyy-mm-dd',
        weekStart: 0, /*以星期一为一星期开始*/
        autoclose: 1,
        startView: 'year',
        minView:'year', /*精确到月*/
        pickerPosition: "bottom-left"
    });


    $('#degreeSelect').selectpicker({
        noneSelectedText : '请选择'//默认显示内容
    });

    $.getJSON('/json/sql_areas.json',function(data){
        for (var i = 0; i < data.length; i++) {
            var area = {id:data[i].id,name:data[i].cname,level:data[i].level,parentId:data[i].upid};
            data[i] = area;
        }
        $('.bs-chinese-region').chineseRegion('source',data).on('completed.bs.chinese-region',function(e,areas){
            $(this).find('[name=address]').val(areas[areas.length-1].id);
        });
    });

    $.getJSON('/json/gender.json',function (data) {
        var $div = $('#genderDiv');
        initRadio($div,data,"gender");
        <#if personalInfo?? && personalInfo.gender??>
            $("input[name=gender][value=${personalInfo.gender}]").attr("checked",true);
        </#if>
    });
    $.getJSON('/json/politics.json',function (data) {
        var $div = $('#politicsDiv');
        initRadio($div,data,"politics");
        <#if personalInfo?? && personalInfo.politics??>
            $("input[name=politics][value=${personalInfo.politics}]").attr("checked",true);
        </#if>
    });
    $.getJSON('/json/marital.json',function (data) {
        var $div = $('#maritalDiv');
        initRadio($div,data,"marital");
        <#if personalInfo?? && personalInfo.marital??>
            $("input[name=marital][value=${personalInfo.marital}]").attr("checked",true);
        </#if>
    });

    function initRadio(parent,data,radioName) {
        for (var i = 0;i < data.length;i++) {
            var labelInput = $("<label class='radio-inline'></label>");
            var radioInput = $("<input type='radio' name='"+radioName+"'>");
            radioInput.attr('value',data[i].value);
            $(labelInput).append(radioInput).append(data[i].name).appendTo(parent);
        }
    }

</script>

</body>
</html>