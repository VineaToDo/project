<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <title>职位列表</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
</head>
<style>
    #positionTable thead{
        background-color: #cc5766;
        color: #ededed;
    }
</style>
<body>
    <!-- 导航条 -->
    <#include "header.ftl">
    <div style="padding-top: 70px"></div>
    <!-- HOME -->
    <section class="container">
        <div class="panel panel-primary">
            <div class="panel-heading"><h2 class="panel-title"><#if collect??>收藏<#else>职位</#if>列表<#if property??>(${property})</#if></h2>
            </div>
            <div class="panel-body">
                <table id="positionTable"></table>
                <div class="row">
                    <div id="toolbar" class="btn-group pull-right" style="margin-right: 20px;">
                    </div>
                </div>
            </div>
        </div>

    </section>
    <#include "footer.ftl">
    <script src="/bootstrap/bootstrap-table.js"></script>
    <script src="/bootstrap/bootstrap-table-zh-CN.js"></script>
<script>
    $('#positionTable').bootstrapTable({
        method: 'post',
        contentType: "application/x-www-form-urlencoded",
        url:"/position/positionList",
        striped: true, //是否显示行间隔色
        sortClass:'warning',
        // classes:'table-no-bordered',
        cache:false,
        pageNumber: 1, //初始化加载第一页，默认第一页
        pagination:true,//是否分页
        queryParams:queryParams,
        queryParamsType:'undefined',
        sortStable:true,
        sortable:true,
        sortOrder:'desc',
        sortName:'createdTime',
        sidePagination:'server',
        pageSize:2,//单页记录数
        pageList:[2,5,10],//分页步进值
        showRefresh:true,//刷新按钮
        toolbarAlign:'right',
        buttonsAlign:'right',//按钮对齐方式
        toolbar:'#toolbar',//指定工作栏
        rowStyle:function (row, index) {
            var classes = ['success', 'warning'];
            if (index % 2 === 0) {
                return {classes: classes[0]};
            }else {
                return {classes: classes[1]};
            }
        },
        columns:[
            {
                title:'序号',
                align:'center',
                formatter:function (value,row,index) {
                    var pageSize=$('#positionTable').bootstrapTable('getOptions').pageSize;//通过表的#id 可以得到每页多少条
                    var pageNumber=$('#positionTable').bootstrapTable('getOptions').pageNumber;//通过表的#id 可以得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;//返回每条的序号： 每页条数 * （当前页 - 1 ）+ 序号
                }
            },
            {
                title:'职位名',
                field:'name',
                align:'center',
                sortable:true,
                formatter:positionClick
            },
            {
                title:'学历要求',
                align:'center',
                field:'degree',
                sortable:true,
                formatter:function (value, row, index) {
                    return row.degreeStr;
                }
            },
            {
                title:'招聘人数',
                align:'center',
                sortable:true,
                field:'recruitNum'
            },
            {
                title:'工作经验',
                align:'center',
                sortable:true,
                field:'experience'
            },
            {
                title:'月薪',
                align:'center',
                field:'salary',
                sortable:true,
                formatter:function (value, row, index) {
                    return row.salaryStr;
                }
            },
            {
                title:'职位类型',
                align:'center',
                sortable:true,
                field:'jobType.name'
            },
            {
                title:'所属公司',
                align:'center',
                sortable:true,
                field:'companyInfo.name'
            },
            {
                title:'发布日期',
                align:'center',
                sortable:true,
                field:'createdTime'
            }
        ]
    })
    //请求服务数据时所传参数
    function queryParams(params){
        return{
        <#if property??>
            property:"${property}",
        </#if>
        <#if typeId??>
            typeId:${typeId},
        </#if>
        <#if collect??>
            collect:${collect?c},
        <#else>
            state:1,
        </#if>
        <#if key??>
            positionKey:"${key}",
        </#if>
            pageSize: params.pageSize,
            pageNumber:params.pageNumber,
            sortName:params.sortName,
            sortOrder:params.sortOrder
        }
    }
    
    function positionClick(value,row,index) {
        return '<a href="/position/positionDetail?positionId='+ row.id +'" target="_blank">'+ value +'</a>';
    }

</script>
</body>
</html>