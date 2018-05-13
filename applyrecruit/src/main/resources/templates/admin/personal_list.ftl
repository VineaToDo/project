<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>个人用户</title>
    <link rel="stylesheet" type="text/css" href="/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/bootstrap/bootstrap-table.css">
</head>
<body>
    <section class="container-fluid">
        <div class="panel panel-primary">
            <div class="panel-heading"><h2 class="panel-title">个人用户列表</h2>
            </div>
            <div class="panel-body">
                <table id="personalTable"></table>
                <div class="row">
                    <div id="toolbar" class="btn-group pull-right" style="margin-right: 20px;">
                        <div class="form-inline"></div>
                    </div>
                </div>
            </div>
        </div>

    </section>
    <script src="/js/jquery.min.js"></script>
    <script src="/bootstrap/bootstrap.min.js"></script>
    <script src="/bootstrap/bootstrap-table.js"></script>
    <script src="/bootstrap/bootstrap-table-zh-CN.js"></script>
<script>
    $('#personalTable').bootstrapTable({
        method: 'post',
        contentType: "application/x-www-form-urlencoded",
        url:"/admin/personalList",
        striped: true, //是否显示行间隔色
        cache:false,
        pageNumber: 1, //初始化加载第一页，默认第一页
        pagination:true,//是否分页
        queryParams:queryParams,
        queryParamsType:'undefined',
        sidePagination:'server',
        pageSize:1,//单页记录数
        pageList:[1,2,3],//分页步进值
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
                title:'用户名',
                field:'userName',
                sortable:true
            },
            {
                title:'是否锁定',
                field:'isLocked',
                sortable:true
            },
            {
                title:'创建日期',
                field:'createdTime',
                sortable:true
            }
        ]
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