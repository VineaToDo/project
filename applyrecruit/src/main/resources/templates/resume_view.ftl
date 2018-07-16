<html>
<head>
    <title>首页</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" type="text/css" href="/bootstrap/fileinput.min.css">
    <style>
        body {
            position: relative;
        }
        #recruit{
            margin-top: 25px;
            text-align: left;
        }
        .container {
            margin-right: auto;
            margin-left: auto;
            padding-right: 15px;
            padding-left: 15px;
        }
        .panel-footer{
            text-align: right;
        }
        .show-grid [class *="col-"]{
            padding: 5px;
            /*border: 2px #2b2b2b solid;*/
        }

        ul.nav-tabs{
            width: 240px;
            border-radius: 4px;
            border: 1px solid #ddd;
            box-shadow: 0 1px 4px rgba(0, 0, 0, 0.067);
        }
        ul.nav-tabs li{
            margin: 0;
            border-top: 1px solid #ddd;
        }
        ul.nav-tabs li:first-child{
            border-top: none;
        }
        ul.nav-tabs li a{
            margin: 0;
            padding: 8px 16px;
            border-radius: 0;
        }
        ul.nav-tabs li.active a, ul.nav-tabs li.active a:hover{
            color: #fff;
            background: #0088cc;
            border: 1px solid #0088cc;
        }
        ul.nav-tabs li:first-child a{
            border-radius: 4px 4px 0 0;
        }
        ul.nav-tabs li:last-child a{
            border-radius: 0 0 4px 4px;
        }
        ul.nav-tabs.affix{
            top: 75px;
        }
    </style>
</head>
<body data-spy="scroll" data-target="#myScrollspy">
    <#include "header.ftl">
    <section id="recruit" data-stellar-background-ratio="0.5">
        <div class="container">
            <div class="row" >
                <div class="col-md-3" id="myScrollspy">
                    <div class="panel panel-default" data-spy="affix" data-offset-top="5">
                        <div class="panel-heading">
                            <h4>简历导航</h4>
                        </div>
                        <div class="panel-body" >
                                <ul class="nav nav-tabs nav-stacked">
                                    <li><a href="#basicInfo">基本信息</a></li>
                                    <li><a href="#education">教育背景</a></li>
                                    <li><a href="#work">工作经历</a></li>
                                    <li><a href="#internship">实习经历</a></li>
                                    <li><a href="#training" class="smoothScroll">培训经历</a></li>
                                    <li><a href="#language">语言能力</a></li>
                                    <li><a href="#credential">证书</a></li>
                                    <li><a href="#skill">专业技能</a></li>
                                    <li><a href="#project">项目经历</a></li>
                                </ul>
                        </div>
                        <div class="panel-footer">
                            <a href="/resume/downloadResume?resumeId=<#if Session.user.resumeInfo??>${Session.user.resumeInfo.id}</#if>" type="button" class="btn btn-danger" <#if !personalInfo??>disabled="true" onclick="return false;"</#if>>导出简历</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-9 col-sm-6" style="padding-left: 2px">
                    <span id="basicInfo"></span>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    <h3 class="panel-title">基本信息</h3>
                                </div>
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-md-9">
                                            <#if personalInfo??>
                                            <h2 >${personalInfo.name}</h2><br>
                                            <dl class="dl-horizontal">
                                                <dt>性别</dt>
                                                <dd><#if personalInfo.gender = 1>男<#else >女</#if></dd>
                                                <dt>手机</dt>
                                                <dd>${personalInfo.phone}</dd>
                                                <dt>邮箱</dt>
                                                <dd>${personalInfo.email}</dd>
                                                <dt>生日</dt>
                                                <dd>${personalInfo.birthday?string("yyyy-MM-dd")}</dd>
                                                <#if personalInfo.city??>
                                                    <dt>所在地</dt>
                                                    <dd>${personalInfo.city}</dd>
                                                </#if>
                                                        <dt>工作时间</dt>
                                                        <dd>${personalInfo.workYear?string("yyyy-MM")}</dd>
                                                <#if personalInfo.marital??>
                                                    <dt>婚姻状况</dt>
                                                    <dd>${personalInfo.maritalValue}</dd>
                                                </#if>
                                                <#if personalInfo.politics??>
                                                    <dt>政治面貌</dt>
                                                    <dd>${personalInfo.politicsValue}</dd>
                                                </#if>
                                            </dl>
                                            <#else>
                                                <div class="center-block"><label><a href="/resume/edit/perInfo">请先完善基本资料</a></label></div>
                                            </#if>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="thumbnail" data-toggle="modal" data-target="#myModal" style="cursor: pointer;">
                                                <img src="<#if Session.user.head??>${Session.user.head}<#else>/images/photoDefault.jpg</#if>" alt="修改头像">
                                                <div class="caption text-center"><i class="fa fa-edit"></i> 修改头像</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <#if personalInfo??>
                                <div class="panel-footer">
                                    <a href="/resume/edit/perInfo?id=${personalInfo.id}" class="btn btn-info btn-xs">编辑</a>
                                </div>
                                </#if>
                            </div>
                        </div>
                    </div>
                    <span id="education"></span>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    <div class="row">
                                        <h3 class="col-md-11 panel-title">教育背景</h3>
                                        <a href="/resume/edit/education" class="col-md-1 btn btn-success btn-xs">新增</a>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <#if educationList??>
                                    <#list educationList as edu>
                                    <dl class="dl-horizontal">
                                        <dt>${edu.beginDate?string("yyyy.MM")}&ensp;--&ensp;${edu.endDate?string("yyyy.MM")}</dt>
                                        <dd><p>${edu.school}&emsp;|&emsp;${edu.major}&emsp;|&emsp;${edu.degreeValue}&emsp;|&emsp;<#if edu.single=0>非</#if>统招
                                            <a href="/resume/edit/education?id=${edu_index}"><b>修改</b></a>
                                            <a href="/resume/delete/education?id=${edu_index}"><b>删除</b></a>
                                        </p></dd>
                                    </dl>
                                    </#list>
                                    <#else >
                                        <p><b><a href="/resume/edit/education">请添加</a></b></p>
                                    </#if>
                                </div>
                            </div>
                        </div>
                    </div>
                    <span id="work"></span>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    <div class="row">
                                    <h3 class="col-md-11 panel-title">工作经历</h3>

                                    <a href="/resume/edit/work" class="col-md-1 btn btn-success btn-xs">新增</a>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <#if workList??>
                                    <#list workList as work>
                                    <dl class="dl-horizontal">
                                        <dt>${work.beginDate?string("yyyy.MM")}&ensp;--&ensp;${work.endDate?string("yyyy.MM")}</dt>
                                        <dd><p>${work.companyName}&emsp;|&emsp;${work.position}&emsp;|&emsp;${work.trade}&emsp;|&emsp;${work.propertyValue}&emsp;|&emsp;规模：${work.dimensionsValue}&emsp;|&emsp;月薪：${work.salaryValue}<br>
                                            ${work.description}
                                            <a href="/resume/edit/work?id=${work_index}"><b>修改</b></a>
                                            <a href="/resume/delete/workExperience?id=${work_index}"><b>删除</b></a>
                                        </p></dd>
                                    </dl>
                                    </#list>
                                    <#else >
                                        <p><b><a href="/resume/edit/work">请添加</a></b></p>
                                    </#if>
                                </div>
                            </div>
                        </div>
                    </div>
                    <span id="internship"></span>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    <div class="row">
                                    <h3 class="col-md-11 panel-title">实习经历</h3>
                                    <a href="/resume/edit/internship" class="col-md-1 btn btn-success btn-xs">新增</a>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <#if internshipList??>
                                    <#list internshipList as work>
                                    <dl class="dl-horizontal">
                                        <dt>${work.beginDate?string("yyyy.MM")}&ensp;--&ensp;${work.endDate?string("yyyy.MM")}</dt>
                                        <dd><p>${work.companyName}&emsp;|&emsp;${work.position}&emsp;|&emsp;${work.trade}&emsp;|&emsp;${work.propertyValue}&emsp;|&emsp;规模：${work.dimensionsValue}&emsp;|&emsp;月薪：${work.salaryValue}<br>
                                            ${work.description}
                                            <a href="/resume/edit/internship?id=${work_index}"><b>修改</b></a>
                                            <a href="/resume/delete/internship?id=${work_index}"><b>删除</b></a>
                                        </p></dd>
                                    </dl>
                                    </#list>
                                    <#else >
                                        <p><b><a href="/resume/edit/internship">请添加</a></b></p>
                                    </#if>
                                </div>
                            </div>
                        </div>
                    </div>
                    <span id="training"></span>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    <div class="row">
                                    <h3 class="col-md-11 panel-title">培训经历</h3>
                                    <a href="/resume/edit/training" class="col-md-1 btn btn-success btn-xs">新增</a>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <#if trainingList??>
                                    <#list trainingList as training>
                                    <dl class="dl-horizontal">
                                        <dt>${training.beginDate?string("yyyy.MM")}&ensp;--&ensp;${training.endDate?string("yyyy.MM")}</dt>
                                        <dd><p>培训名称：${training.name}&emsp;|&emsp;培训机构：${training.name}<br>
                                            培训内容：${training.content}
                                            <a href="/resume/edit/training?id=${training_index}"><b>修改</b></a>
                                            <a href="/resume/delete/training?id=${training_index}"><b>删除</b></a>
                                        </p></dd>
                                    </dl>
                                    </#list>
                                    <#else >
                                        <p><b><a href="/resume/edit/training">请添加</a></b></p>
                                    </#if>
                                </div>
                            </div>
                        </div>
                    </div>
                    <span id="language"></span>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    <div class="row">
                                    <h3 class="col-md-11 panel-title">语言能力</h3>
                                    <a href="/resume/edit/language" class="col-md-1 btn btn-success btn-xs">新增</a>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <#if languageList??>
                                    <#list languageList as language>
                                    <dl class="dl-horizontal">
                                        <dt>${language.nameValue}:</dt>
                                        <dd><p>读写能力${language.literacy}&emsp;|&emsp;听说能力${language.speak}
                                            <a href="/resume/edit/language?id=${language_index}"><b>修改</b></a>
                                            <a href="/resume/delete/language?id=${language_index}"><b>删除</b></a>
                                        </p></dd>
                                    </dl>
                                    </#list>
                                    <#else >
                                        <p><b><a href="/resume/edit/language">请添加</a></b></p>
                                    </#if>
                                </div>
                            </div>
                        </div>
                    </div>
                    <span id="credential"></span>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    <div class="row">
                                    <h3 class="col-md-11 panel-title">证书</h3>
                                    <a href="/resume/edit/credential" class="col-md-1 btn btn-success btn-xs">新增</a>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <#if credentialList??>
                                    <#list credentialList as credential>
                                    <dl class="dl-horizontal">
                                        <dt>${credential.obtainTime?string("yyyy.MM")}</dt>
                                        <dd><p>${credential.name}
                                            <a href="/resume/edit/credential?id=${credential_index}"><b>修改</b></a>
                                            <a href="/resume/delete/credential?id=${credential_index}"><b>删除</b></a>
                                        </p></dd>
                                    </dl>
                                    </#list>
                                    <#else >
                                        <p><b><a href="/resume/edit/credential">请添加</a></b></p>
                                    </#if>
                                </div>
                            </div>
                        </div>
                    </div>
                    <span id="skill"></span>
                    <div class="row" >
                        <div class="col-md-12 col-sm-12">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    <div class="row">
                                    <h3 class="col-md-11 panel-title">专业技能</h3>
                                    <a href="/resume/edit/skill" class="col-md-1 btn btn-success btn-xs">新增</a>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <#if skillList??>
                                    <#list skillList as skill>
                                    <dl class="dl-horizontal">
                                        <dt>${skill.name}</dt>
                                        <dd><p>掌握程度${skill.master}
                                            <a href="/resume/edit/skill?id=${skill_index}"><b>修改</b></a>
                                            <a href="/resume/delete/skill?id=${skill_index}"><b>删除</b></a>
                                        </p></dd>
                                    </dl>
                                    </#list>
                                    <#else >
                                        <p><b><a href="/resume/edit/skill">请添加</a></b></p>
                                    </#if>
                                </div>
                            </div>
                        </div>
                    </div>
                    <span id="project"></span>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    <div class="row">
                                        <h3 class="col-md-11 panel-title">项目经历</h3>
                                        <a href="/resume/edit/project" class="col-md-1 btn btn-success btn-xs">新增</a>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <#if projectList??>
                                    <#list projectList as projectEx>
                                    <dl class="dl-horizontal">
                                        <dt>${projectEx.beginDate?string("yyyy.MM")}&ensp;--&ensp;${projectEx.endDate?string("yyyy.MM")}</dt>
                                        <dd><p>${projectEx.name}&emsp;|&emsp;规模：${projectEx.dimensions}<br>
                                            项目职责:${projectEx.duty}<br>项目描述:${projectEx.description}
                                            <a href="/resume/edit/project?id=${projectEx_index}"><b>修改</b></a>
                                            <a href="/resume/delete/project?id=${projectEx_index}"><b>删除</b></a>
                                        </p></dd>
                                    </dl>
                                    </#list>
                                    <#else >
                                        <p><b><a href="/resume/edit/project">请添加</a></b></p>
                                    </#if>
                                </div>
                            </div>
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
                    <input type="file" name="file" id="file" class="file-loading" accept="image/*" />
                </div></div>
        </div>
    </div>
<script src="/bootstrap/fileinput.min.js"></script>
<script src="/bootstrap/zh.js"></script>
<script>
    $(function () {
        var oFileInput = new FileInput();
        oFileInput.Init("file", "/file/uploadImage");
    })
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
                showCancel:false,
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
                    toastr.success("上传成功！")
                    // alert('上传成功!');
                    window.location.reload(true);
                }else {
                    toastr.error(data.msg);
                    // alert(data.msg);
                }
                // toastr.error('文件格式类型不正确');
            });
        }
        return oFile;
    };
</script>
</body>
</html>