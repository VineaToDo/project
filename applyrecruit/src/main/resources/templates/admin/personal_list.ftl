<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>个人用户管理</title>
    <link rel="stylesheet" type="text/css" href="/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/bootstrap/bootstrap-table.css">
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css">
</head>
<body>
    <section class="container-fluid">
        <ul class="nav nav-tabs">
            <li class="active"><a href="#informList" data-toggle="tab">举报投诉列表</a></li>
            <li><a id="perTab" href="#persList" data-toggle="tab">个人用户列表</a></li>
        </ul>
        <div class="tab-content">
            <div id="informList" class="tab-pane fade in active">
                <table id="informTable"></table>
            </div>
            <div id="persList" class="tab-pane fade">
                <table id="personalTable"></table>
                <div class="row">
                    <div id="toolbar" class="btn-group hidden" style="margin-left: 10px;">
                        <div class="form-inline">
                            <button id="btn_reset" type="button" class="btn btn-success" title="返回"><i class="fa fa-reply"></i></button>
                            <label class="control-label">查找用户</label>
                            <p id="toolText" class="form-control-static" title=""></p>
                        </div>
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
    $(function () {
        $('#informTable').bootstrapTable({
            method: 'post',
            contentType: "application/x-www-form-urlencoded",
            url:"/admin/informDeliverList",
            striped: true, //是否显示行间隔色
            cache:false,
            pageNumber: 1, //初始化加载第一页，默认第一页
            pagination:true,//是否分页
            queryParams:function (params) {
                return {
                    pageSize: params.pageSize,
                    pageNumber:params.pageNumber,
                    sortName:params.sortName,
                    sortOrder:params.sortOrder,
                    informed:true
                }
            },
            queryParamsType:'undefined',
            sidePagination:'server',
            sortable:true,
            sortName:'updatedTime',
            pageSize:2,//单页记录数
            pageList:[2,5],//分页步进值
            showRefresh:true,//刷新按钮
            buttonsAlign:'right',//按钮对齐方式
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
                    title:'真实姓名',
                    field:'resumeInfo.personalInfo.name',
                    sortable:true
                },
                {
                    title:'应聘职位',
                    field:'position.name',
                    sortable:true
                },
                {
                    title:'举报公司',
                    field:'position.companyInfo.name',
                    sortable:true
                },
                {
                    title:'举报人',
                    field:'contactName',
                    sortable:true
                },
                {
                    title:'联系方式',
                    field:'contactPhone'
                },
                {
                    title:'举报日期',
                    field:'updatedTime',
                    sortable:true
                },
                {
                    title:'查找',
                    field:'search',
                    align:'center',
                    width:80,
                    formatter:searchFormatter,
                    events:searchEvents
                }
            ]
        });

        $('#personalTable').bootstrapTable({
            method: 'post',
            contentType: "application/x-www-form-urlencoded",
            url:"/admin/userList",
            striped: true, //是否显示行间隔色
            cache:false,
            pageNumber: 1, //初始化加载第一页，默认第一页
            pagination:true,//是否分页
            queryParams:queryParams,
            queryParamsType:'undefined',
            sidePagination:'server',
            sortStable:true,
            sortable:true,
            sortOrder:'desc',
            sortName:'createdTime',
            pageSize:5,//单页记录数
            pageList:[5,10],//分页步进值
            showRefresh:true,//刷新按钮
            showColumns:true,
            toolbarAlign:'left',
            buttonsAlign:'right',//按钮对齐方式
            toolbar:'#toolbar',//指定工作栏
            columns:[{
                    title:'全选',
                    field:'select',
                    checkbox:true,
                    width:25,
                    align:'center',
                    valign:'middle'
                }, {
                    title:'ID',
                    field:'id',
                    visible:false
                }, {
                    title:'用户名',
                    field:'userName',
                    sortable:true
                }, {
                    title:'锁定状态',
                    field:'isLocked',
                    align:'center',
                    width:80,
                    sortable:true,
                    formatter:function (value, row, index) {
                        if(value) return '<i class="fa fa-lock"></i>';
                        else  return '<i class="fa fa-unlock"></i>';
                    }
                }, {
                    title:'注册日期',
                    field:'createdTime',
                    sortable:true
                }, {
                    title:'锁定/解锁',
                    field:'lock',
                    align:'center',
                    width:80,
                    formatter:lockFormatter,
                    events:lockEvents
                }
            ]
        })

        $('#btn_reset').click(function () {
            $('#toolText').prop('title','');
            $('#toolbar').addClass('hidden');
            $('#personalTable').bootstrapTable('refresh');
        });
    });

    function searchFormatter(value, row, index) {
        return '<button id="btn_search" type="button" class="btn btn-info" title="查找"><i class="fa fa-search"></i></button>';
    }

    function lockFormatter(value, row, index) {
        if(!row.isLocked) return '<button id="btn_lock" type="button" class="btn btn-danger" title="锁定"><i class="fa fa-lock"></i></button>';
        else return '<button id="btn_lock" type="button" class="btn btn-success" title="解锁"><i class="fa fa-unlock"></i></button>';
    }

    window.searchEvents = {
        "click #btn_search": function (e, value, row, index) {
            $('#toolText').text(row.resumeInfo.personalInfo.name).prop('title',row.resumeInfo.id);
            $('#personalTable').bootstrapTable('refresh');
            $('#toolbar').removeClass('hidden');
            $('#perTab').tab('show');
        }
    };
    window.lockEvents = {
        "click #btn_lock": function (e, value, row, index) {
            $.ajax({
                url:'/admin/lockUser',
                type:'POST',
                contentType:'application/x-www-form-urlencoded',
                data:{userId:row.id},
                success:function(data){
                    if(data.code != -1){
                        hint({ data:data.msg,type:"success"});
                        $('#personalTable').bootstrapTable('refresh');
                    }
                    console.log(data.msg);
                }
            });
        }
    };

    function hint(data) {
        window.parent.hintData(data);
    }

    //请求服务数据时所传参数
    function queryParams(params){
        return{
            pageSize: params.pageSize,
            pageNumber:params.pageNumber,
            sortName:params.sortName,
            sortOrder:params.sortOrder,
            resumeId:$('#toolText').prop('title'),
            roleName:"apply"
        }
    };

</script>
</body>
</html>