<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <title>招聘首页</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <style>
        #myTabContent a{
            font-size: 14px;
        }
    </style>

</head>
<body>
    <!-- PRE LOADER -->
    <section class="preloader">
        <div class="spinner">
            <span class="spinner-rotate"></span>
        </div>
    </section>
    <!-- 导航条 -->
    <#include "header.ftl">
    <!-- HOME -->
    <section id="home" data-stellar-background-ratio="0.5">
        <div class="overlay" style="top: 7em;">
        <div class="container">
            <div class="row">
                <div class="col-md-5 col-sm-12">
                    <div class="home-info">
                        <h1>Find the best Job!</h1>
                    </div>
                </div>
                <div class="col-md-7 col-sm-12">
                    <div class="panel panel-info">
                        <div class="panel-heading"><h4 class="panel-title">热门职位</h4></div>
                        <div class="list-group">
                            <#if topPositions?? && topPositions?size != 0>
                            <#list topPositions as position>
                                <a href="/position/positionDetail?positionId=${position.id}" class="list-group-item list-group-item-warning">${position.name}<span class="badge">${position.createdTime?string("yyyy-MM-dd")}</span></a>
                            </#list>
                            </#if>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading" style="z-index: 1000;"><h4 class="panel-title">职位分类</h4></div>
                <div class="row panel-body">
                    <div class="col-md-2">
                        <div id="myTab" class="nav nav-tabs nav-stacked list-group">
                        <#list jobTypes as jobType>
                            <a href="#tab${jobType.id}" data-toggle="tab" class="list-group-item list-group-item-info<#if jobType_index == 0> active</#if>">${jobType.name} <span class="glyphicon glyphicon-chevron-right"></span><span class="badge">${jobType.jobCount}</span></a>
                        </#list>
                        </div>
                    </div>
                    <div class="col-md-10">
                        <div id="myTabContent" class="tab-content" >
                        <#list jobTypes as jobType>
                            <div class="tab-pane fade<#if jobType_index == 0> in active</#if>" id="tab${jobType.id}">
                                <#list jobType.childrens as child>
                                    <a class="label label-danger" href="/index/getPositionsByType?typeId=${child.id}">${child.name}<span class="badge">${child.jobCount}</span></a>
                                </#list>
                            </div>
                        </#list>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div>
    </section>
    <#include "footer.ftl">
    <script src="/js/jquery.stellar.min.js"></script>
    <script src="/js/jquery.magnific-popup.min.js"></script>
    <script src="/js/custom.js"></script>
    <script>
        $(function () {
            $('#myTab a').on('mouseover',function(){
                var thisA = $(this);
                $('#myTab a').removeClass('active');
                thisA.addClass('active');
                thisA.tab('show');
            });
            $('#myTab a').on('show.bs.tab',function (e) {
                // var id = $(e.target).attr('href').substr(1);
                $('#myTabContent div').removeClass('in active');
                // $('#myTabContent div').not('#' + id).removeClass('in active');
                // $("#"+id).removeClass('in active');
            });
        });
    </script>
</body>
</html>