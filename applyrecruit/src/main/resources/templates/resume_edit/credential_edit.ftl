<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>编辑证书</title>
    <style>

    </style>

</head>
<body>
    <#include "../header.ftl">

    <section class="outer_box">
        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title">编辑证书</h3>
            </div>
            <div class="panel-body">
                <form action="/resume/updateCredential" class="form-horizontal" role="form" method="post">
                    <div class="form-group">
                        <label for="name" class="col-md-offset-2 col-md-2 control-label">证书名称</label>
                        <div class="col-md-5"><input type="text" name="name" class="form-control" value="<#if credential??>${credential.name}</#if>"></div>
                    </div>
                    <div class="form-group">
                        <label for="obtainTime" class="col-md-offset-2 col-md-2 control-label">获得时间</label>
                        <div class="col-md-5"><div class="input-group date" id="obtainTimepicker">
                            <input type="text" class="form-control" id="obtainTime" name="obtainTime" <#if credential?? && credential.obtainTime??>value="${credential.obtainTime?string("yyyy-MM")}" </#if>readonly>
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span><span class="input-group-addon"><i class="glyphicon glyphicon-remove"></i></span>
                        </div></div>
                    </div>
                    <#if credential??><input name="id" type="hidden" value="${id}"></#if>
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

    $('#obtainTimepicker').datetimepicker({
        language: 'zh-CN',
        todayHighlight: true,
        // todayBtn: true.toSource
        format:'yyyy-mm',
        weekStart: 0, /*以星期一为一星期开始*/
        autoclose: 1,
        startView: 'year',
        minView:'year', /*精确到天*/
        pickerPosition: "bottom-left"
    }).on("changeDate",function (ev) {

    });

</script>
</body>
</html>