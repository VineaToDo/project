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
            <li><a id="perTab" href="#positionList" data-toggle="tab">职位列表</a></li>
        </ul>
        <div class="tab-content">
            <div id="informList" class="tab-pane fade in active">
                <table id="informTable"></table>
            </div>
            <div id="positionList" class="tab-pane fade">
                <table id="positionTable"></table>
                <div class="row">
                    <div id="toolbar" class="form-inline" style="margin-left: 10px;">
                        <input type="text" id="nameKey" name="nameKey" class="form-control" placeholder="职位名关键字">
                        <input type="hidden" id="positionId">
                        <button id="btn_search" type="button" class="btn btn-info" title="查找"><i class="fa fa-search"></i></button>
                        <button id="btn_reset" type="button" class="btn btn-warning" title="重置"><i class="fa fa-repeat"></i></button>
                        <button id="btn_downAll" type="button" class="btn btn-danger">一键下线所有过期职位</button>
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
        var $search = $('#btn_search'),$reset = $('#btn_reset'),$downAll = $('#btn_downAll');
        $('#informTable').bootstrapTable({
            method: 'post',
            contentType: "application/x-www-form-urlencoded",
            url:"/admin/complaintList",
            striped: true, //是否显示行间隔色
            cache:false,
            pageNumber: 1, //初始化加载第一页，默认第一页
            pagination:true,//是否分页
            queryParams:function (params) {
                return {
                    pageSize: params.pageSize,
                    pageNumber:params.pageNumber,
                    sortName:params.sortName,
                    sortOrder:params.sortOrder
                }
            },
            queryParamsType:'undefined',
            sidePagination:'server',
            sortable:true,
            sortName:'createdTime',
            sortOrder:'desc',
            pageSize:5,//单页记录数
            pageList:[5,10],//分页步进值
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
                    title:'职位名称',
                    field:'position.name',
                    sortable:true
                },
                {
                    title:'职位类型',
                    field:'position.jobType.name',
                    sortable:true
                },
                {
                    title:'所属公司',
                    field:'position.companyInfo.name',
                    sortable:true
                },
                {
                    title:'职位状态',
                    field:'position.state',
                    align:'center',
                    width:80,
                    sortable:true,
                    formatter:function (value, row, index) {
                        var classes = ['success', 'danger'];
                        var states = ['发布中','已下线'];
                        return '<label class="label label-'+ classes[value - 1] +'">'+ states[value - 1] +'</label>';
                    }
                },
                {
                    title:'锁定状态',
                    field:'position.isLocked',
                    align:'center',
                    width:80,
                    sortable:true,
                    formatter:function (value, row, index) {
                        if (value) return '<i class="fa fa-lock"></i>';
                        else return '<i class="fa fa-unlock"></i>';
                    }
                },
                {
                    title:'举报人',
                    field:'informer',
                    sortable:true
                },
                {
                    title:'联系方式',
                    field:'contactPhone'
                },
                {
                    title:'举报日期',
                    field:'createdTime',
                    sortable:true
                },
                {
                    title:'操作',
                    field:'operate',
                    align:'center',
                    width:100,
                    formatter:operateFormatter,
                    events:operateEvents
                }
            ]
        });

        $('#positionTable').bootstrapTable({
            method: 'post',
            contentType: "application/x-www-form-urlencoded",
            url:"/admin/positionList",
            striped: true, //是否显示行间隔色
            cache:false,
            pageNumber: 1, //初始化加载第一页，默认第一页
            pagination:true,//是否分页
            queryParams:queryParams,
            queryParamsType:'undefined',
            sidePagination:'server',
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
                    align:'center'
                }, {
                    title:'ID',
                    field:'id',
                    visible:false
                }, {
                    title:'职位名',
                    field:'name',
                    sortable:true
                }, {
                    title:'公司名',
                    field:'companyInfo.name',
                    sortable:true
                },{
                    title:'职位类型',
                    field:'jobType.name',
                    sortable:true
                },{
                    title:'职位性质',
                    field:'property',
                    sortable:true
                },{
                    title:'招聘人数',
                    field:'recruitNum',
                    sortable:true
                },{
                    title:'职位状态',
                    field:'state',
                    align:'center',
                    width:80,
                    sortable:true,
                    formatter:function (value, row, index) {
                        var classes = ['warning','success', 'danger'];
                        var states = ['未发布','发布中','已下线'];
                        return '<label class="label label-'+ classes[value] +'">'+ states[value] +'</label>';
                    }
                }, {
                    title:'锁定状态',
                    field:'isLocked',
                    align:'center',
                    width:80,
                    sortable:true,
                    formatter:function (value, row, index) {
                        if (value) return '<i class="fa fa-lock"></i>';
                        else return '<i class="fa fa-unlock"></i>';
                    }
                },{
                    title:'收藏量',
                    field:'collect',
                    sortable:true
                },{
                    title:'浏览量',
                    field:'hit',
                    sortable:true
                },{
                    title:'投递量',
                    field:'sent',
                    sortable:true
                },{
                    title:'创建时间',
                    field:'createdTime',
                    sortable:true
                }, {
                    title:'截止日期',
                    field:'deadline',
                    sortable:true
                },{
                    title:'操作',
                    field:'operate',
                    align:'center',
                    width:80,
                    formatter:operate1Formatter,
                    events:operate1Events
                }
            ]
        })

        $search.click(function () {
            $('#positionTable').bootstrapTable('refresh');
        });

        $reset.click(function () {
            $('#nameKey').val('');
            $('#positionId').val('');
            $('#positionTable').bootstrapTable('refresh');
        });

        $downAll.click(function () {
            $.ajax({
                url:'/admin/downPast',
                type:'post',
                success:function (data) {
                    if(data.code == 1){
                        hint({data:data.msg,type:"success"});
                        $('#positionTable').bootstrapTable('refresh');
                    }else {
                        hint({data:data.msg,type:"error"});
                    }
                }
            })
        });
    });

    function operateFormatter(value, row, index) {
        var formatter = new Array();
        if(row.position.isLocked) formatter.push('<button id="btn_lock" type="button" class="btn btn-success" title="解锁该职位"><i class="fa fa-unlock"></i></button>');
        else formatter.push('<button id="btn_lock" type="button" class="btn btn-danger" title="锁定该职位"><i class="fa fa-lock"></i></button>');
        formatter.push('<button id="btn_search" type="button" class="btn btn-info" title="查找该职位"><i class="fa fa-search"></i></button>');
        return formatter.join('&nbsp;');
    }

    function operate1Formatter(value, row, index) {
        if(!row.isLocked) return '<button id="btn_lock" type="button" class="btn btn-danger" title="锁定该职位"><i class="fa fa-lock"></i></button>';
        else return '<button id="btn_lock" type="button" class="btn btn-success" title="解锁该职位"><i class="fa fa-unlock"></i></button>';
    }

    window.operateEvents = {
        "click #btn_lock": function (e, value, row, index) {
            $.ajax({
                url:'/admin/lockPosition',
                type:'POST',
                contentType:'application/x-www-form-urlencoded',
                data:{positionId:row.position.id},
                success:function(data){
                    if(data.code != -1){
                        hint({ data:data.msg,type:"success"});
                        $('#informTable').bootstrapTable('refresh');
                    }
                    console.log(data.msg);
                }
            });
        },
        "click #btn_search": function (e, value, row, index) {
            $('#positionId').val(row.position.id);
            $('#nameKey').val(row.position.name);
            $('#positionTable').bootstrapTable('refresh');
            $('#perTab').tab('show');
            // $('#toolText').text(row.resumeInfo.personalInfo.name).prop('title',row.resumeInfo.id);
            // $('#personalTable').bootstrapTable('refresh');
            // $('#toolbar').removeClass('hidden');
        }
    };
    window.operate1Events = {
        "click #btn_lock": function (e, value, row, index) {
            $.ajax({
                url:'/admin/lockPosition',
                type:'POST',
                contentType:'application/x-www-form-urlencoded',
                data:{positionId:row.id},
                success:function(data){
                    if(data.code != -1){
                        hint({ data:data.msg,type:"success"});
                        $('#positionTable').bootstrapTable('refresh');
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
            positionKey:$('#nameKey').val(),
            positionId:$('#positionId').val()
        }
    };

</script>
</body>
</html>