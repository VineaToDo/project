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
            <div class="panel-heading"><h2 class="panel-title">职位列表</h2>
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
    <script src="/bootstrap/bootstrap-table.js"></script>
    <script src="/bootstrap/bootstrap-table-zh-CN.js"></script>
<script>
    $('#positionTable').bootstrapTable({
        method: 'post',
        contentType: "application/x-www-form-urlencoded",
        url:"/position/positionManage",
        striped: true, //是否显示行间隔色
        cache:false,
        pageNumber: 1, //初始化加载第一页，默认第一页
        pagination:true,//是否分页
        queryParams:queryParams,
        queryParamsType:'undefined',
        sidePagination:'server',
        pageSize:2,//单页记录数
        pageList:[2,5,10],//分页步进值
        // search:true,
        showRefresh:true,//刷新按钮
        showColumns:true,
        clickToSelect: true,//是否启用点击选中行
        toolbarAlign:'right',
        buttonsAlign:'right',//按钮对齐方式
        toolbar:'#toolbar',//指定工作栏
        columns:[
            {
                title:'全选',
                field:'select',
                checkbox:true,
                width:25,
                align:'center',
                valign:'middle'
            },
            {
                title:'ID',
                field:'id',
                visible:false
            },
            {
                title:'职位名',
                field:'name',
                sortable:true
            },
            {
                title:'招聘人数',
                field:'recruitNum'
            },
            {
                title:'工作经验',
                field:'experience'
            },
            {
                title:'职位类型',
                field:'type'
            }
        ]
        // locale:'zh-CN'//中文支持,
    })
    //请求服务数据时所传参数
    function queryParams(params){
        return{
            pageSize: params.pageSize,
            pageNumber:params.pageNumber
            // Name:$('#search_name').val(),
            // Tel:$('#search_tel').val()
        }
    };




</script>
</body>
</html>