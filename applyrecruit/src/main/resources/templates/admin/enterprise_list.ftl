<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>企业用户管理</title>
    <link rel="stylesheet" type="text/css" href="/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/bootstrap/bootstrap-table.css">
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css">
</head>
<body>
    <section class="container-fluid">
        <ul class="nav nav-tabs">
            <li class="active"><a href="#enterpriseList" data-toggle="tab">企业用户列表</a></li>
        </ul>
        <div class="tab-content">
            <div id="enterpriseList" class="tab-pane fade in active">
                <table id="enterpriseTable"></table>
                <div class="row">
                    <div id="toolbar" style="margin-left: 10px;">
                        <label id="ableFilter" class="label label-success" style="cursor: pointer;font-size: 14px;" title="">
                            <i class="fa fa-toggle-off fa-lg"></i>&nbsp;只查看未授权公司
                        </label>
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
        var $able = $('#ableFilter');
        $('#enterpriseTable').bootstrapTable({
            method: 'post',
            contentType: "application/x-www-form-urlencoded",
            url: "/admin/userList",
            striped: true, //是否显示行间隔色
            cache: false,
            pageNumber: 1, //初始化加载第一页，默认第一页
            pagination: true,//是否分页
            queryParams: function (params) {
                return {
                    pageSize: params.pageSize,
                    pageNumber: params.pageNumber,
                    sortName: params.sortName,
                    sortOrder: params.sortOrder,
                    available:$able.attr('title'),
                    roleName: "recruit"
                }
            },
            queryParamsType: 'undefined',
            sidePagination: 'server',
            sortable: true,
            sortName: 'createdTime',
            sortOrder:'desc',
            pageSize: 5,//单页记录数
            pageList: [5, 10],//分页步进值
            showRefresh: true,//刷新按钮
            showColumns: true,
            toolbarAlign: 'left',
            buttonsAlign: 'right',//按钮对齐方式
            toolbar: '#toolbar',//指定工作栏
            columns: [{
                title: '全选',
                field: 'select',
                checkbox: true,
                width: 25,
                align: 'center',
                valign: 'middle'
            }, {
                title: 'ID',
                field: 'id',
                visible: false
            }, {
                title: '企业用户名',
                field: 'userName',
                sortable: true
            }, {
                title: '注册公司名',
                field: 'companyInfo.name',
                sortable: true
            }, {
                title: '公司规模',
                field: 'companyInfo.dimensionsCode',
                formatter:function(value, row, index){
                    return row.companyInfo.dimensions;
                },
                sortable: true
            }, {
                title: '公司性质',
                field: 'companyInfo.propertyCode',
                formatter:function(value, row, index){
                    return row.companyInfo.property;
                },
                sortable: true
            }, {
                title: '锁定状态',
                field: 'isLocked',
                align: 'center',
                width: 80,
                sortable: true,
                formatter: function (value, row, index) {
                    if (value) return '<i class="fa fa-lock"></i>';
                    else return '<i class="fa fa-unlock"></i>';
                }
            }, {
                title: '权限状态',
                field: 'companyInfo.available',
                align: 'center',
                width: 80,
                sortable: true,
                formatter: function (value, row, index) {
                    if (value) return '<label class="label label-success">有</label>';
                    else return '<label class="label label-danger">无</label>';
                }
            }, {
                title: '注册时间',
                field: 'createdTime',
                sortable: true
            }, {
                title: '操作',
                field: 'operate',
                align: 'center',
                width: 100,
                formatter: operateFormatter,
                events: operateEvents
            }
            ]
        });

        $able.click(function () {
            if($able.attr('title') == ''){
                $able.attr('title','false');
                $able.removeClass('label-success').addClass('label-danger').find('i');
                $able.find('i').removeClass('fa-toggle-off').addClass('fa-toggle-on');
                $('#enterpriseTable').bootstrapTable('refresh');
            }
            else {
                $able.attr('title','');
                $able.removeClass('label-danger').addClass('label-success');
                $able.find('i').removeClass('fa-toggle-on').addClass('fa-toggle-off');
                $('#enterpriseTable').bootstrapTable('refresh');
            }

        });
    });

    function operateFormatter(value, row, index) {
        var formatter = new Array();
        if(row.isLocked) formatter.push('<button id="btn_lock" type="button" class="btn btn-danger" title="锁定"><i class="fa fa-lock"></i></button>');
        else formatter.push('<button id="btn_lock" type="button" class="btn btn-success" title="解锁"><i class="fa fa-unlock"></i></button>');

        if(row.companyInfo.available) formatter.push('<button id="btn_check" type="button" class="btn btn-warning" title="解除权限"><i class="fa fa-times-circle"></i></button>');
        else formatter.push('<button id="btn_check" type="button" class="btn btn-info" title="授予权限"><i class="fa fa-check-circle"></i></button>');

        return formatter.join('&nbsp;');
    }

    window.operateEvents = {
        "click #btn_lock": function (e, value, row, index) {
            $.ajax({
                url:'/admin/lockUser',
                type:'POST',
                contentType:'application/x-www-form-urlencoded',
                data:{userId:row.id},
                success:function(data){
                    if(data.code != -1){
                        hint({ data:data.msg,type:"success"});
                        $('#enterpriseTable').bootstrapTable('refresh');
                    }
                    console.log(data.msg);
                }
            });
        },
        "click #btn_check": function (e, value, row, index) {
            $.ajax({
                url:'/admin/checkCompany',
                type:'POST',
                contentType:'application/x-www-form-urlencoded',
                data:{companyId:row.companyInfo.id},
                success:function(data){
                    if(data.code != -1){
                        hint({ data:data.msg,type:"success"});
                        $('#enterpriseTable').bootstrapTable('refresh');
                    }
                    console.log(data.msg);
                }
            });
        }
    };

    function hint(data) {
        window.parent.hintData(data);
    }

</script>
</body>
</html>