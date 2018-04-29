<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>首页</title>
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
                    <p>简历导航</p>
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
                                    <a href="/resume/edit/perInfo?id=${personalInfo.id}" class="btn btn-success btn-xs">编辑</a>
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
                                        <dt>时间：${edu.beginDate?string("yyyy-MM")}至${edu.endDate?string("yyyy-MM")}</dt>
                                        <dd><p>   学校：${edu.school}    学位：${edu.getEduDgreeEnum().message}
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
                </div>
            </div>
        </div>
    </section>
</body>
</html>