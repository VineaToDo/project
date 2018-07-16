<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>编辑语言能力</title>
    <style>

    </style>

</head>
<body>
    <#include "../header.ftl">

    <section class="outer_box">
        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title">编辑语言能力</h3>
            </div>
            <div class="panel-body">
                <form action="/resume/updateLanguage" class="form-horizontal" role="form" method="post">
                    <div class="form-group">
                        <label for="name" class="col-md-offset-2 col-md-2 control-label">语种</label>
                        <div class="col-md-5" id="nameDiv">
                            <select class="selectpicker" multiple data-max-options='1' id='nameSelect' name='name'>
                                <#list languageDict?values as languageOpt>
                                    <option value="${languageOpt.code}">${languageOpt.value}</option>
                                </#list>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="org" class="col-md-offset-2 col-md-2 control-label">读写能力</label>
                        <div class="col-md-5"><select class="selectpicker form-control" name="literacy" id="literacySelect" multiple data-max-options="1">
                            <option value="一般">一般</option>
                            <option value="良好">良好</option>
                            <option value="熟练">熟练</option>
                            <option value="精通">精通</option>
                        </select></div>
                    </div>
                    <div class="form-group">
                        <label for="org" class="col-md-offset-2 col-md-2 control-label">听说能力</label>
                        <div class="col-md-5"><select class="selectpicker form-control" name="speak" id="speakSelect" multiple data-max-options="1">
                            <option value="一般">一般</option>
                            <option value="良好">良好</option>
                            <option value="熟练">熟练</option>
                            <option value="精通">精通</option>
                        </select></div>
                    </div>
                    <#if language??><input name="id" type="hidden" value="${id}"></#if>
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

    $('#literacySelect').selectpicker({
        noneSelectedText : '请选择'//默认显示内容
    });
    $('#speakSelect').selectpicker({
        noneSelectedText : '请选择'//默认显示内容
    });
    $(function () {
        <#if language?? && language.literacy??>
            $('#literacySelect').selectpicker('val',"${language.literacy}");
        </#if>
        <#if language?? && language.literacy??>
            $('#speakSelect').selectpicker('val',"${language.speak}");
        </#if>
    });

    <#if language?? && language.name??>
            $('#nameSelect').selectpicker('val',${language.name});
    </#if>
    $('#nameSelect').selectpicker({
        noneSelectedText : '请选择'//默认显示内容
    });


</script>
</body>
</html>