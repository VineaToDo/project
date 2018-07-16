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
        <div class="row">
        <div class="col-md-6 panel panel-default">
            <div class="panel-heading">
                <h2 class="panel-title">职位最新动态</h2>
            </div>
            <div class="panel-body-noborder">
                <div class="list-group">
                    <#if newest?? && newest?size != 0>
                        <#list newest as deliver>
                        <a href="/deliver/getDeliver?deliverId=${deliver.id}" class="list-group-item list-group-item-info" target="_blank"><label class="label label-danger" style="font-size: 100%;cursor: pointer;">${deliver.resumeInfo.personalInfo.name}</label>&nbsp;投递了&nbsp;<label class="label label-info" style="font-size: 100%;">${deliver.position.name}</label>&nbsp;职位<span class="badge">${deliver.createdTime}</span></a>
                        </#list>
                    <#else>
                        <div class="list-group-item">
                            <h4 class="list-group-item-heading">暂无动态信息</h4>
                            <p class="list-group-item-text"><ul class="list-inline">
                            <li><a href="/company/editCompanyInfo">完善公司信息</a></li>
                            <li><a href="/company/deptPage">设置部门结构</a></li>
                        </ul></p>
                        </div>
                    </#if>
                </div>
            </div>
        </div>

        <div class="col-md-6 panel panel-default">
            <div class="panel-heading">
                <h2 class="panel-title">功能快速导航</h2>
            </div>
            <div class="panel-body-noborder">
                <div class="list-group">
                    <div class="list-group-item">
                        <h4 class="list-group-item-heading">职位管理</h4>
                        <p class="list-group-item-text">
                            <ul class="list-inline">
                                <li><a href="/position/editPosition">发布新职位</a></li>
                                <li><a href="/position/getPosition">职位列表</a></li>
                            </ul>
                        </p>
                    </div>
                    <div class="list-group-item">
                        <h4 class="list-group-item-heading">简历管理</h4>
                        <p class="list-group-item-text">
                            <ul class="list-inline">
                                <li><a href="/deliver/goDeliverList">收件箱</a></li>
                                <li><a href="/deliver/goCollectionList">收藏夹</a></li>
                            </ul>
                        </p>
                    </div>
                    <div class="list-group-item">
                        <h4 class="list-group-item-heading">控制面板</h4>
                        <p class="list-group-item-text">
                            <ul class="list-inline">
                                <li><a href="/index/setting">修改用户信息和密码</a></li>
                                <li><a href="/company/editCompanyInfo">修改公司信息</a></li>
                                <li><a href="/company/deptPage">设置部门结构</a></li>
                            </ul>
                        </p>
                    </div>

                </div>
            </div>
        </div>
        </div>
    </section>
    <#include "../footer.ftl">
</body>
</html>