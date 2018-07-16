<html>
<head>
    <title>简历信息</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
</head>
<body>
    <section id="recruit">
        <div class="container">
            <div class="panel panel-danger">
                <div class="panel-heading"><h3>应聘职位：${position.name}</h3>
                <#if available == 2><label class="panel-title label label-success">已邀请面试</label>
                <#elseif available == 3><label class="panel-title label label-warning">正在进一步沟通</label>
                <#elseif available == 4><label class="panel-title label label-danger">已拒绝</label>
                </#if></div>
                <div class="panel-body">
                    <div class="list-group">
                    <#if personalInfo??>
                    <div class="list-group-item list-group-item-info">
                        <h3 class="list-group-item-heading">${personalInfo.name}</h3>
                        <div class="media list-group-item-text">
                            <div class="media-body">
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
                            </div>
                        </div>
                    </div>
                    </#if>
                    <#if educationList??&& educationList?size != 0>
                    <div class="list-group-item">
                        <h3 class="list-group-item-heading">教育背景</h3>
                        <#list educationList as edu>
                                    <dl class="dl-horizontal list-group-item-text">
                                        <dt>${edu.beginDate?string("yyyy.MM")}&ensp;--&ensp;${edu.endDate?string("yyyy.MM")}</dt>
                                        <dd><p>${edu.school}&emsp;|&emsp;${edu.major}&emsp;|&emsp;${edu.degreeValue}&emsp;|&emsp;<#if edu.single=0>非</#if>统招</p></dd>
                                    </dl>
                        </#list>
                    </div>
                    </#if>
                    <#if workList??&& workList?size != 0>
                    <div class="list-group-item">
                        <h3 class="list-group-item-heading">工作经历</h3>
                        <#list workList as work>
                                    <dl class="dl-horizontal list-group-item-text">
                                        <dt>${work.beginDate?string("yyyy.MM")}&ensp;--&ensp;${work.endDate?string("yyyy.MM")}</dt>
                                        <dd><p>${work.companyName}&emsp;|&emsp;${work.position}&emsp;|&emsp;${work.trade}&emsp;|&emsp;${work.propertyValue}&emsp;|&emsp;规模：${work.dimensionsValue}&emsp;|&emsp;月薪：${work.salaryValue}<br>
                                            <pre>${work.description}</pre>
                                            </p></dd>
                                    </dl>
                        </#list>
                    </div>
                    </#if>
                    <#if internshipList??&& internshipList?size != 0>
                    <div class="list-group-item">
                        <h3 class="list-group-item-heading">实习经历</h3>
                        <#list internshipList as work>
                                    <dl class="dl-horizontal">
                                        <dt>${work.beginDate?string("yyyy.MM")}&ensp;--&ensp;${work.endDate?string("yyyy.MM")}</dt>
                                        <dd><p>${work.companyName}&emsp;|&emsp;${work.position}&emsp;|&emsp;${work.trade}&emsp;|&emsp;${work.propertyValue}&emsp;|&emsp;规模：${work.dimensionsValue}&emsp;|&emsp;月薪：${work.salaryValue}<br>
                                            <pre>${work.description}</pre>
                                            </p></dd>
                                    </dl>
                        </#list>
                    </div>
                    </#if>
                    <#if trainingList??&& trainingList?size != 0>
                    <div class="list-group-item">
                        <h3 class="list-group-item-heading">培训经历</h3>
                        <#list trainingList as training>
                                    <dl class="dl-horizontal">
                                        <dt>${training.beginDate?string("yyyy.MM")}&ensp;--&ensp;${training.endDate?string("yyyy.MM")}</dt>
                                        <dd><p>培训名称：${training.name}&emsp;|&emsp;培训机构：${training.name}<br>
                                            培训内容：${training.content}
                                        </p></dd>
                                    </dl>
                        </#list>
                    </div>
                    </#if>
                    <#if languageList??>
                    <div class="list-group-item">
                        <h3 class="list-group-item-heading">语言能力</h3>
                        <#list languageList as language>
                                    <dl class="dl-horizontal">
                                        <dt>${language.nameValue}:</dt>
                                        <dd><p>读写能力-${language.literacy}&emsp;|&emsp;听说能力-${language.speak}</p></dd>
                                    </dl>
                        </#list>
                    </div>
                    </#if>
                    <#if credentialList??&& credentialList?size != 0>
                    <div class="list-group-item">
                        <h3 class="list-group-item-heading">证书</h3>
                        <#list credentialList as credential>
                                    <dl class="dl-horizontal">
                                        <dt>${credential.obtainTime?string("yyyy.MM")}</dt>
                                        <dd><p>${credential.name}</p></dd>
                                    </dl>
                        </#list>
                    </div>
                    </#if>
                    <#if skillList??&& skillList?size != 0>
                    <div class="list-group-item">
                        <h3 class="list-group-item-heading">专业技能</h3>
                        <#list skillList as skill>
                                    <dl class="dl-horizontal">
                                        <dt>${skill.name}</dt>
                                        <dd><p>掌握程度-${skill.master}</p></dd>
                                    </dl>
                        </#list>
                    </div>
                    </#if>
                    <#if projectList??&& projectList?size != 0>
                    <div class="list-group-item">
                        <h3 class="list-group-item-heading">项目经历</h3>
                        <#list projectList as projectEx>
                                    <dl class="dl-horizontal">
                                        <dt>${projectEx.beginDate?string("yyyy.MM")}&ensp;--&ensp;${projectEx.endDate?string("yyyy.MM")}</dt>
                                        <dd><p>${projectEx.name}&emsp;|&emsp;规模：${projectEx.dimensions}<br>
                                            项目职责:<pre>${projectEx.duty}</pre>项目描述:<pre>${projectEx.description}</pre></p></dd>
                                    </dl>
                        </#list>
                    </div>
                    </#if>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
</html>