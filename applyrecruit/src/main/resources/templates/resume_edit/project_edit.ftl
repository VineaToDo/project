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
                <h3 class="panel-title">编辑项目经历</h3>
            </div>
            <div class="panel-body">
                <form action="/resume/updateProject" class="form-horizontal" role="form" method="post">
                    <div class="form-group">
                        <label for="name" class="col-md-offset-2 col-md-2 control-label">项目名称</label>
                        <div class="col-md-5"><input type="text" class="form-control" id="name" placeholder="" name="name" value="<#if projectEx??>${projectEx.name}</#if>"></div>
                    </div>
                    <div class="form-group">
                        <label for="dimensions" class="col-md-offset-2 col-md-2 control-label">团队规模</label>
                        <div class="col-md-5"><select class="selectpicker form-control" name="dimensions" id="dimensionsSelect" multiple data-max-options="1">
                            <option value="1-3人">1-3人</option>
                            <option value="4-7人">4-7人</option>
                            <option value="8-10人">8-10人</option>
                            <option value="11-20人">11-20人</option>
                            <option value="20人以上">20人以上</option>
                        </select></div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-offset-2 col-md-2 control-label">参与时间</label>
                        <div class="col-md-5"><div class="input-group"><div class="input-group date" id="beginDatepicker">
                            <input type="text" class="form-control" id="beginDateInput" name="beginDate" value="<#if projectEx??>${projectEx.beginDate?string("yyyy-MM")}</#if>" readonly>
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span><span class="input-group-addon"><i class="glyphicon glyphicon-remove"></i></span>
                        </div><label class="input-group-addon" style="background-color: #ffffff;border: none;width: 20px">至</label>
                        <div class="input-group date" id="endDatepicker">
                            <input type="text" class="form-control" id="endDateInput" name="endDate" value="<#if projectEx??>${projectEx.endDate?string("yyyy-MM")}</#if>" readonly>
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span><span class="input-group-addon"><i class="glyphicon glyphicon-remove"></i></span>
                        </div></div></div>
                    </div>
                    <div class="form-group">
                        <label for="duty" class="col-md-offset-2 col-md-2 control-label">项目职责</label>
                        <div class="col-md-5"><textarea class="form-control" name="duty" rows="3"><#if projectEx??>${projectEx.duty}</#if></textarea></div>
                    </div>
                    <div class="form-group">
                        <label for="description" class="col-md-offset-2 col-md-2 control-label">项目描述</label>
                        <div class="col-md-5"><textarea class="form-control" name="description" rows="3"><#if projectEx??>${projectEx.description}</#if></textarea></div>
                    </div>
                    <#if projectEx??><input name="id" type="hidden" value="${id}"></#if>
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
    $('#dimensionsSelect').selectpicker({
        noneSelectedText : '请选择'//默认显示内容

    });
    
    $(function () {
        <#if projectEx?? && projectEx.dimensions??>
            $('#dimensionsSelect').selectpicker('val',"${projectEx.dimensions}");
        </#if>
    });



</script>
</body>
</html>