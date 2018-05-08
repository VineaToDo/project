<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>编辑专业技能</title>
    <style>

    </style>

</head>
<body>
    <#include "../header.ftl">

    <section class="outer_box">
        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title">编辑专业技能</h3>
            </div>
            <div class="panel-body">
                <form action="/resume/updateSkill" class="form-horizontal" role="form" method="post">
                    <div class="form-group">
                        <label for="name" class="col-md-offset-2 col-md-2 control-label">专业技能</label>
                        <div class="col-md-5" id="nameDiv"><input type="text" class="form-control" name="name" required="required" value="<#if skill??>${skill.name}</#if>"></div>
                    </div>
                    <div class="form-group">
                        <label for="masterSelect" class="col-md-offset-2 col-md-2 control-label">掌握程度</label>
                        <div class="col-md-5"><select class="selectpicker form-control" name="master" id="masterSelect">
                            <option value="一般">一般</option>
                            <option value="良好">良好</option>
                            <option value="熟练">熟练</option>
                            <option value="精通">精通</option>
                        </select></div>
                    </div>
                    <#if skill??><input name="id" type="hidden" value="${id}"></#if>
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

    $('#masterSelect').selectpicker({
        noneSelectedText : '请选择'//默认显示内容
    });
    $(function () {
        <#if skill?? && skill.master??>
            $('#masterSelect').selectpicker('val',"${skill.master}");
        </#if>
    });

</script>
</body>
</html>