<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <title>企业用户</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" type="text/css" href="/bootstrap/fileinput.min.css">
</head>
<body>
    <!-- 导航条 -->
    <#include "header.ftl">
    <div style="padding-top: 70px"></div>
    <!-- HOME -->
    <section class="container">
        <div class="panel panel-primary">
            <div class="panel-heading"><h2 class="panel-title"><#if company??>修改<#else>编辑</#if>公司信息</h2></div>
            <div class="panel-body ">
                <div class="row">
                    <form action="/company/saveCompany" class="form-horizontal col-md-9" role="form" method="post">
                        <div class="form-group">
                            <label for="name" class="col-md-offset-2 col-md-2 control-label">公司名称</label>
                            <div class="col-md-5"><input type="text" class="form-control" id="name" placeholder="" name="name" value="<#if company??>${company.name}</#if>"></div>
                        </div>
                        <div class="form-group">
                            <label for="dimensions" class="col-md-offset-2 col-md-2 control-label">公司规模</label>
                            <div class="col-md-5" id="dimensionsDiv">
                                <select class="selectpicker" multiple data-max-options='1' id='dimensionsSelect' name='dimensionsCode'>
                                    <#list dimensionsDict?values as dimensionsOpt>
                                        <option value="${dimensionsOpt.code}">${dimensionsOpt.value}</option>
                                    </#list>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="propertyCode" class="col-md-offset-2 col-md-2 control-label">公司性质</label>
                            <div class="col-md-5" id="propertyDiv">
                                <select class='selectpicker' multiple data-max-options='1' id='propertySelect' name='propertyCode'>
                                    <#list propertyDict?values as propertyOpt>
                                        <option value="${propertyOpt.code}">${propertyOpt.value}</option>
                                    </#list>
                                </select>
                            </div>
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
                        <#if Session.user.companyInfo??>
                            <input type="hidden" name="id" value="${Session.user.companyInfo.id}">
                        </#if>
                        <div class="form-group">
                            <div class="col-md-push-7 col-md-9">
                                <button type="submit" class="btn btn-primary">保存</button>
                                <a href="javascript:history.back()" class="btn btn-warning">取消</a>
                            </div>
                        </div>
                    </form>
                    <div class="col-md-3">
                        <div class="thumbnail" data-toggle="modal" data-target="#myModal" style="cursor: pointer;">
                            <img src="<#if company?? && company.brandIcon??>${company.brandIcon}<#else>/images/defaultIcon.png</#if>" alt="修改商标">
                            <div class="caption text-center"><i class="fa fa-edit"></i> 修改商标</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </section>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">请选择图片文件</h4>
                </div>
                <div class="modal-body">
                    <input type="file" name="file" id="file" class="file-loading" />
                </div></div>
        </div>
    </div>
    <script src="/bootstrap/fileinput.min.js"></script>
    <script src="/bootstrap/zh.js"></script>

<script>
    $(function () {
        var oFileInput = new FileInput();
        oFileInput.Init("file", "/file/uploadImage");

        $.getJSON('/json/sql_areas.json',function(data){
            for (var i = 0; i < data.length; i++) {
                var area = {id:data[i].id,name:data[i].cname,level:data[i].level,parentId:data[i].upid};
                data[i] = area;
            }
            $('.bs-chinese-region').chineseRegion('source',data).on('completed.bs.chinese-region',function(e,areas){
                $(this).find('[name=address]').val(areas[areas.length-1].id);
            });
        });

        $('#propertySelect,#dimensionsSelect').selectpicker({
            noneSelectedText : '请选择'//默认显示内容
        });
        <#if company?? && company.propertyCode??>
            $('#propertySelect').selectpicker('val',${company.propertyCode});
        </#if>
        <#if company?? && company.dimensionsCode??>
            $('#dimensionsSelect').selectpicker('val',${company.dimensionsCode});
        </#if>
    });

    //初始化fileinput
    var FileInput = function () {
        var oFile = new Object();
        //初始化fileinput控件（第一次初始化）
        oFile.Init = function(ctrlName, uploadUrl) {
            var control = $('#' + ctrlName);
            //初始化上传控件的样式
            control.fileinput({
                language: 'zh', //设置语言
                uploadUrl: uploadUrl, //上传的地址
                allowedFileTypes: ['image'],
                allowedFileExtensions: ['jpg', 'jpeg', 'png'],//接收的文件后缀
                allowedPreviewTypes : [ 'image' ],
                showUpload: true, //是否显示上传按钮
                showCaption: false,//是否显示标题
                browseClass: "btn btn-primary", //按钮样式
                uploadClass: "btn btn-success",//设置上传按钮样式
                dropZoneEnabled: false,//是否显示拖拽区域
                //minImageWidth: 50, //图片的最小宽度
                //minImageHeight: 50,//图片的最小高度
                //maxImageWidth: 1000,//图片的最大宽度
                //maxImageHeight: 1000,//图片的最大高度
                maxFileSize: 2048,//单位为kb，如果为0表示不限制文件大小
                minFileCount: 1,
                layoutTemplates:{
                    actionDelete:'', //去除上传预览的缩略图中的删除图标
                    // actionUpload: '',//去除上传预览缩略图中的上传图片；
                },
                // maxFileCount: 10, //表示允许同时上传的最大文件个数
                enctype: 'multipart/form-data',
                validateInitialCount:true,
                previewFileIcon: "<i class='glyphicon glyphicon-king'></i>"
                // msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！"
            });

            //导入文件上传完成之后的事件
            control.on("fileuploaded", function (event, data, previewId, index) {
                $("#myModal").modal("toggle");
                if (data.response.code == 200){
                    alert('上传成功!');
                    window.location.reload(true);
                }else {
                    alert(data.msg);
                }
                // toastr.error('文件格式类型不正确');
            });
        }
        return oFile;
    };

</script>
</body>
</html>