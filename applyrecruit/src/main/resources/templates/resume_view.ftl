<html>
<head>
    <title>首页</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <style>
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
    </style>
<body>

    <#include "header.ftl">
    <section id="recruit" data-stellar-background-ratio="0.5">
        <div class="container">
            <div class="row">
                <div class="col-md-3 col-sm-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4>简历导航</h4>
                        </div>
                        <div class="panel-body">
                            <div class="well">
                                <ul class="list-group">
                                    <li class="list-group-item"><a href="#">基本信息</a></li>
                                    <li class="list-group-item"><a href="#">教育背景</a></li>
                                    <li class="list-group-item"><a href="#">工作经历</a></li>
                                    <li class="list-group-item"><a href="#">实习经历</a></li>
                                    <li class="list-group-item"><a href="#training" class="smoothScroll">培训经历</a></li>
                                    <li class="list-group-item"><a href="#">语言能力</a></li>
                                    <li class="list-group-item"><a href="#">证书</a></li>
                                    <li class="list-group-item"><a href="#">专业技能</a></li>
                                    <li class="list-group-item"><a href="#">项目经历</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-9 col-sm-6" style="padding-left: 2px">
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="media">
                                <div class="media-body">
                                    <h2 class="media-heading">${personalInfo.name}</h2><br>
                                    <p>性别：${personalInfo.gender}</p>
                                </div>
                                <a class="media-right media-middle" href="#">
                                    <img src="/images/photoDefault.jpg" class="img-rounded" alt="修改头像">
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    <h3 class="panel-title">基本信息</h3>
                                </div>
                                <div class="panel-body">
                                    <#if personalInfo??>
                                    <dl class="dl-horizontal">
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
                                            <dd>${personalInfo.marital}</dd>
                                        </#if>
                                        <#if personalInfo.politics??>
                                            <dt>政治面貌</dt>
                                            <dd>${personalInfo.politics}</dd>
                                        </#if>
                                    </dl>
                                    </#if>
                                </div>
                                <div class="panel-footer">
                                    <a href="/resume/edit/perInfo?id=${personalInfo.id}" class="btn btn-info btn-xs">编辑</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    <h3 class="panel-title">教育背景</h3>
                                </div>
                                <div class="panel-body">
                                    <#if educationList??>
                                    <#list educationList as edu>
                                    <dl class="dl-horizontal">
                                        <dt>${edu.beginDate?string("yyyy.MM")}&ensp;--&ensp;${edu.endDate?string("yyyy.MM")}</dt>
                                        <dd><p>${edu.school}&emsp;|&emsp;${edu.major}&emsp;|&emsp;${edu.degree}&emsp;|${edu.single}<#--${edu.getEduDgreeEnum().message}-->
                                            <a href="/resume/edit/education?id=${edu_index}"><b>修改</b></a>
                                            <a href="/resume/delete/education?id=${edu_index}"><b>删除</b></a>
                                        </p></dd>
                                    </dl>
                                    </#list>
                                    <#else >
                                        <p><b><a href="/resume/edit">请添加</a></b></p>
                                    </#if>
                                </div>
                            </div>
                        </div>
                    </div>
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
                                        <dd><p>${work.companyName}&emsp;|&emsp;${work.position}&emsp;|&emsp;${work.trade}&emsp;|&emsp;${work.property}&emsp;|&emsp;规模：${work.dimensions}&emsp;|&emsp;${work.salary}<br>
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
                                        <dd><p>${work.companyName}&emsp;|&emsp;${work.position}&emsp;|&emsp;${work.trade}&emsp;|&emsp;${work.property}&emsp;|&emsp;规模：${work.dimensions}&emsp;|&emsp;${work.salary}<br>
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
                    <div class="row" id="training">
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
                                        <dt>${language.name}:</dt>
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
                    <div class="row">
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
</body>
</html>