<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>Title</title>
    <style>
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
                        <div class="col-md-5" id="genderDiv">
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="1" checked>&nbsp;男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="0" <#if personalInfo?? && personalInfo.gender==0>checked</#if>>&nbsp;女
                            </label>
                        </div>
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
                        <div class="col-md-8" id="politicsDiv">
                            <#list politicsDict?values as politicsOpt>
                                <label class="radio-inline">
                                    <input type="radio" name="politics" value="${politicsOpt.code}">&nbsp;${politicsOpt.value}
                                </label>
                            </#list>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="marital" class="col-md-offset-2 col-md-2 control-label">婚姻状况</label>
                        <div class="col-md-5" id="maritalDiv">
                            <#list maritalDict?values as maritalOpt>
                                <label class="radio-inline">
                                    <input type="radio" name="marital" value="${maritalOpt.code}">&nbsp;${maritalOpt.value}
                                </label>
                            </#list>
                        </div>
                    </div>
                    <#if personalInfo??>
                        <input type="hidden" name="id" value="${personalInfo.id}">
                    </#if>
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
        format:'yyyy-mm',
        weekStart: 0, /*以星期一为一星期开始*/
        autoclose: 1,
        startView: 'year',
        minView:'year', /*精确到月*/
        pickerPosition: "bottom-left"
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

    <#if personalInfo?? && personalInfo.politics??>
            $('input[name=politics][value=${personalInfo.politics}]').attr("checked",true);
    </#if>
    <#if personalInfo?? && personalInfo.marital??>
            $('input[name=marital][value=${personalInfo.marital}]').attr("checked",true);
    </#if>

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