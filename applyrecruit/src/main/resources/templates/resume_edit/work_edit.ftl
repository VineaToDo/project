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
            <h3 class="panel-title">编辑<#if internship??>实习经历<#else>工作经历</#if></h3>
        </div>
        <div class="panel-body">
            <form action="/resume/updateWork" class="form-horizontal" role="form" method="post">
                <div class="form-group">
                    <label for="companyName" class="col-md-offset-2 col-md-2 control-label">公司名称</label>
                    <div class="col-md-5"><input type="text" class="form-control" id="companyName" placeholder="" name="companyName" value="<#if work??>${work.companyName}</#if>" required="required"></div>
                </div>

                <div class="form-group">
                    <label for="property" class="col-md-offset-2 col-md-2 control-label">公司性质</label>
                    <div class="col-md-5" id="propertyDiv"></div>
                </div>
                <div class="form-group">
                    <label for="dimensions" class="col-md-offset-2 col-md-2 control-label">公司规模</label>
                    <div class="col-md-5" id="dimensionsDiv"></div>
                </div>
                <div class="form-group">
                    <label for="trade" class="col-md-offset-2 col-md-2 control-label">所属行业</label>
                    <div class="col-md-5"><input type="text" class="form-control" id="trade" placeholder="" name="trade" value="<#if work??&& work.trade??>${work.trade}</#if>"></div>
                </div>
                <div class="form-group">
                    <label for="position" class="col-md-offset-2 col-md-2 control-label">职位名称</label>
                    <div class="col-md-5"><input type="text" class="form-control" id="position" placeholder="" name="position" value="<#if work??&& work.position??>${work.position}</#if>"></div>
                </div>
                <div class="form-group">
                    <label for="type" class="col-md-offset-2 col-md-2 control-label">职位类别</label>
                    <div class="col-md-5"><input type="text" class="form-control" id="type" placeholder="" name="type" value="<#if work??&& work.type??>${work.type}</#if>"></div>
                </div>
                <div class="form-group">
                    <label for="salary" class="col-md-offset-2 col-md-2 control-label">税前月薪</label>
                    <div class="col-md-5" id="salaryDiv"></div>
                </div>
                <div class="form-group">
                    <label class="col-md-offset-2 col-md-2 control-label">在职时间</label>
                    <div class="col-md-5" style="font-size: 8px" id="studyTime"><div class="input-group"><div class="input-group date" id="beginDatepicker">
                        <input type="text" class="form-control" id="beginDateInput" name="beginDate" value="<#if work??>${work.beginDate?string("yyyy-MM")}</#if>" readonly>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span><span class="input-group-addon"><i class="glyphicon glyphicon-remove"></i></span>
                    </div><label class="input-group-addon" style="background-color: #ffffff;border: none;width: 20px">至</label>
                        <div class="input-group date" id="endDatepicker">
                            <input type="text" class="form-control" id="endDateInput" name="endDate" value="<#if work??>${work.endDate?string("yyyy-MM")}</#if>" readonly>
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span><span class="input-group-addon"><i class="glyphicon glyphicon-remove"></i></span>
                        </div></div></div>
                </div>
                <div class="form-group">
                    <label for="description" class="col-md-offset-2 col-md-2 control-label">经历描述</label>
                    <div class="col-md-5"><textarea class="form-control" id="description" name="description" rows="3"><#if work??&& work.description??>${work.description}</#if></textarea></div>
                </div>
                    <#if work??><input name="id" type="hidden" value="${id}"></#if>
                    <#if internship??><input name="isInternship" type="hidden" value="1"></#if>
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

    // $.ajaxSettings.async = false;
    $.getJSON('/json/property.json',function (data) {
        var $div = $('#propertyDiv');
        initSelect($div,data,"property");
        <#if work?? && work.property??>
            $('#propertySelect').selectpicker('val',${work.property});
        </#if>
        $('#propertySelect').selectpicker({
            noneSelectedText : '请选择'//默认显示内容

        });
        $('#propertySelect').selectpicker('refresh');
    });
    $.getJSON('/json/dimensions.json',function (data) {
        var $div = $('#dimensionsDiv');
        initSelect($div,data,"dimensions");
        <#if work?? && work.dimensions??>
            $('#dimensionsSelect').selectpicker('val',${work.dimensions});
        </#if>
        $('#dimensionsSelect').selectpicker({
            noneSelectedText : '请选择'//默认显示内容
        });
        $('#dimensionsSelect').selectpicker('refresh');
    });
    $.getJSON('/json/salary.json',function (data) {
        var $div = $('#salaryDiv');
        initSelect($div,data,"salary");
        <#if work?? && work.salary??>
            $('#salarySelect').selectpicker('val',${work.salary});
        </#if>
        $('#salarySelect').selectpicker({
            noneSelectedText : '请选择'//默认显示内容

        });
        $('#salarySelect').selectpicker('refresh');
    });

    // $.ajaxSettings.async = true;
    function initSelect(parent,data,selectName) {
        var select = $("<select class='selectpicker form-control' multiple data-max-options='1' id='" + selectName + "Select' name='" + selectName + "'></select>");
        for (var i = 0;i < data.length;i++){
            var option = $("<option value='"+ data[i].value +"'>" + data[i].name +"</option>");
            $(select).append(option).appendTo(parent);
        }
    }


</script>
</body>
</html>