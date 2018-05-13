<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <title>企业用户</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

</head>
<body>
    <!-- 导航条 -->
    <#include "header.ftl">
    <div style="padding-top: 70px"></div>
    <!-- HOME -->
    <section class="container">
        <div class="panel panel-primary">
            <div class="panel-heading"><h2 class="panel-title"><#if company??>修改<#else>编辑</#if>公司信息</h2></div>
            <div class="panel-body">
                <form action="/company/saveCompany" class="form-horizontal" role="form" method="post">
                    <div class="form-group">
                        <label for="name" class="col-md-offset-2 col-md-2 control-label">公司名称</label>
                        <div class="col-md-5"><input type="text" class="form-control" id="name" placeholder="" name="name" value="<#if company??>${company.name}</#if>"></div>
                    </div>
                    <div class="form-group">
                        <label for="dimensions" class="col-md-offset-2 col-md-2 control-label">公司规模</label>
                        <div class="col-md-5" id="dimensionsDiv"></div>
                    </div>
                    <div class="form-group">
                        <label for="property" class="col-md-offset-2 col-md-2 control-label">公司性质</label>
                        <div class="col-md-5" id="propertyDiv"></div>
                    </div>
                    <div class="form-group">
                        <label for="trade" class="col-md-offset-2 col-md-2 control-label">所属行业</label>
                        <div class="col-md-5">
                            <input type="text" class="form-control" id="trade" placeholder="" name="trade" value="<#if company??&& company.trade??>${company.trade}</#if>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="workplace" class="col-md-offset-2 col-md-2 control-label">公司地点</label>
                        <div class="col-md-5">
                            <div class="bs-chinese-region flat dropdown" data-min-level="1" data-max-level="3" data-def-val="[name=address]">
                                <input type="text" class="form-control" id="address" placeholder="请选择所在地" data-toggle="dropdown" readonly="">
                                <input type="hidden" class="form-control" name="address" <#if company?? && company.address??>value="${company.address}" </#if>>
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
                        <label for="description" class="col-md-offset-2 col-md-2 control-label">公司简介</label>
                        <div class="col-md-5"><textarea class="form-control" name="introduction" rows="3"><#if company??>${company.introduction}</#if></textarea></div>
                    </div>

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

    <script src="/js/custom.js"></script>

<script>

    $.getJSON('/json/sql_areas.json',function(data){
        for (var i = 0; i < data.length; i++) {
            var area = {id:data[i].id,name:data[i].cname,level:data[i].level,parentId:data[i].upid};
            data[i] = area;
        }
        $('.bs-chinese-region').chineseRegion('source',data).on('completed.bs.chinese-region',function(e,areas){
            $(this).find('[name=address]').val(areas[areas.length-1].id);
        });
    });
    $.getJSON('/json/property.json',function (data) {
        var $div = $('#propertyDiv');
        initSelect($div,data,"property");
        <#if company?? && company.property??>
            $('#propertySelect').selectpicker('val',"${company.property}");
        </#if>
        $('#propertySelect').selectpicker({
            noneSelectedText : '请选择'//默认显示内容

        });
        $('#propertySelect').selectpicker('refresh');
    });
    $.getJSON('/json/dimensions.json',function (data) {
        var $div = $('#dimensionsDiv');
        initSelect($div,data,"dimensions");
        <#if company?? && company.dimensions??>
            $('#dimensionsSelect').selectpicker('val',${company.dimensions});
        </#if>
        $('#dimensionsSelect').selectpicker({
            noneSelectedText : '请选择'//默认显示内容
        });
        $('#dimensionsSelect').selectpicker('refresh');
    });


    // $.ajaxSettings.async = true;
    function initSelect(parent,data,selectName) {
        var select = $("<select class='selectpicker' multiple data-max-options='1' id='" + selectName + "Select' name='" + selectName + "'></select>");
        for (var i = 0;i < data.length;i++){
            var option = $("<option value='"+ data[i].value +"'>" + data[i].name +"</option>");
            $(select).append(option).appendTo(parent);
        }
    }
</script>
</body>
</html>