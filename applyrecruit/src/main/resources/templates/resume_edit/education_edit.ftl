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
                <h3 class="panel-title">编辑教育背景</h3>
            </div>
            <div class="panel-body">
                <form action="/resume/addEducation" class="form-horizontal" role="form" method="post">
                    <div class="form-group">
                        <label for="phone" class="col-md-offset-2 col-md-2 control-label">学校名称</label>
                        <div class="col-md-5"><input type="text" class="form-control" id="school" placeholder="" name="school" value="<#if education??>${education.school}</#if>"></div>
                    </div>
                    <div class="form-group">
                        <label for="major" class="col-md-offset-2 col-md-2 control-label">专业名称</label>
                        <div class="col-md-5"><input type="text" class="form-control" id="major" placeholder="" name="major" value="<#if education??&& education.major??>${education.major}</#if>"></div>
                    </div>
                    <div class="form-group">
                        <label for="single" class="col-md-offset-2 col-md-2 control-label">是否统招</label>
                        <div class="col-md-5">
                            <label class="radio--inline"><input type="radio" id="yes" name="single" value="1" checked>是</label>
                            <label class="radio--inline"><input type="radio" id="no" value="0" name="single" <#if education?? && education.single?? && education.single == 0> checked</#if>>否</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-offset-2 col-md-2 control-label">就读时间</label>
                        <div class="col-md-6" style="font-size: 8px" id="studyTime"><div class="input-group"><div class="input-group date" id="beginDatepicker">
                            <input type="text" class="form-control" id="beginDateInput" name="beginDate" value="<#if education??>${education.beginDate?string("yyyy-MM")}</#if>" readonly>
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span><span class="input-group-addon"><i class="glyphicon glyphicon-remove"></i></span>
                        </div><label class="input-group-addon" style="background-color: #ffffff;border: none;width: 20px">至</label>
                        <div class="input-group date" id="endDatepicker">
                            <input type="text" class="form-control" id="endDateInput" name="endDate" value="<#if education??>${education.endDate?string("yyyy-MM")}</#if>" readonly>
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span><span class="input-group-addon"><i class="glyphicon glyphicon-remove"></i></span>
                        </div></div></div>
                    </div>
                    <div class="form-group">
                        <label for="degree" class="col-md-offset-2 col-md-2 control-label">学历</label>
                        <div class="col-md-5"><select class="selectpicker" id="degreeSelect"  name="degree">
                            <#list eduEnum as enum>
                                <option value="${enum.code}" <#if education?? && education.degree == enum.code>selected</#if>>${enum.message}</option>
                            </#list>
                        </select></div>
                    </div>
                    <#if education??><input name="id" type="hidden" value="${id}"></#if>
                    <div class="form-group">
                        <div class="col-md-push-7 col-md-9">
                            <button type="submit" class="btn btn-primary">保存</button>
                            <a href="javascript:history.back()" class="btn btn-warning">取消</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </section>
<script>
    $('#degreeSelect').selectpicker({
        noneSelectedText : '请选择'//默认显示内容
    });

    $('#beginDatepicker').datetimepicker({
        language:  'zh-CN',
        format:'yyyy-mm',
        weekStart: 0, /*以星期一为一星期开始*/
        todayBtn:  1,
        autoclose: 1,
        startView: 'year',
        minView:'year', /*精确到月*/
        pickerPosition: "bottom-left"
    }).on("changeDate",function(ev){  //值改变事件
        //选择的日期不能大于第二个日期控件的日期
        if(ev.date){
            $("#endDatepicker").datetimepicker('setStartDate', new Date(ev.date.valueOf()));
        }else{
            $("#endDatepicker").datetimepicker('setStartDate',null);
        }
    });
    $('#endDatepicker').datetimepicker({
        language:  'zh-CN',
        format:'yyyy-mm',
        weekStart: 0, /*以星期一为一星期开始*/
        todayBtn:  1,
        autoclose: 1,
        startView: 'year',
        minView:'year', /*精确到月*/
        pickerPosition: "bottom-left"
    }).on("changeDate",function(ev){
        //选择的日期不能小于第一个日期控件的日期
        if(ev.date){
            $("#beginDatepicker").datetimepicker('setEndDate', new Date(ev.date.valueOf()));
        }else{
            $("#beginDatepicker").datetimepicker('setEndDate',new Date());
        }
    });
</script>
</body>
</html>