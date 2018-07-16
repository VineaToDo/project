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
    <section class="jumbotron">
        <div class="container">
            <h2>${resultMsg}</h2>
            <#if flag = 1>
                <p><ul class="list-inline">
                    <li><a href="/company/editCompanyInfo">完善公司信息</a></li>
                    <li><a href="/company/deptPage">设置部门结构</a></li>
                </ul></p>
            </#if>
        </div>
    </section>
    <#include "../footer.ftl">
</body>
</html>