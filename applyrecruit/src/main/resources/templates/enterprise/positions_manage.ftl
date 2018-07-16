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
        <div class="panel panel-default">
            <div class="panel-heading row">
                <h2 class="panel-title"><ol class="breadcrumb">
                    <li><a href="/user/recruit">首页</a></li>
                    <li>职位管理</li><li class="active">管理职位列表</li>
                </ol></h2>
            </div>
            <div class="panel-body">
                <form class="navbar-form navbar-left" role="search">
                    <div class="form-group">
                        <label class="control-label" for="deptSelect">所属部门</label>
                        <select id="deptSelect" class="selectpicker" name="deptId" multiple data-max-options='1' title="所有部门">
                            <#list Session.user.companyInfo.departments as dept>
                                <option value="${dept.id}">${dept.name}</option>
                            </#list>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="control-label">职位名称</label>
                        <input class="form-control" type="text" placeholder="输入职位关键字" name="positionKey">
                    </div>
                    <div class="input-group">
                        <div class="input-group date" id="beginDatepicker" style="width: 180px;">
                            <input type="text" class="form-control" placeholder="发布时间" id="beginDateInput" name="beginDate" value="" readonly>
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span><span class="input-group-addon"><i class="glyphicon glyphicon-remove"></i></span>
                        </div>
                        <label class="input-group-addon" style="background-color: #ffffff;border: none;width: 20px">至</label>
                        <div class="input-group date" id="endDatepicker" style="width: 180px;">
                            <input type="text" class="form-control" placeholder="截止时间" id="endDateInput" name="endDate" value="" readonly>
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span><span class="input-group-addon"><i class="glyphicon glyphicon-remove"></i></span>
                        </div>
                    </div>
                    <button id="btn_search" type="button" class="btn btn-info"><span class="glyphicon glyphicon-search"></span></button>
                </form>
                <div class="panel panel-default">
                    <div class="panel-heading"><ul id="replyTab" class="nav nav-tabs">
                        <li class="active"><a href="#publishing" data-toggle="tab">已发布职位</a></li>
                        <li><a href="#unpublished" data-toggle="tab">未发布职位</a></li>
                        <li><a href="#offline" data-toggle="tab">已下线职位</a></li>
                        <li><a href="#all" data-toggle="tab">所有职位</a></li>
                    </ul></div>
                    <div class="panel-body"><div id="replyContent" class="tab-content">
                        <div id="publishing" class="tab-pane fade in active">
                            <table id="publishingTable" title="1"></table>
                        </div>
                        <div id="unpublished" class="tab-pane fade">
                            <table id="unpublishedTable" title="0"></table>
                        </div>
                        <div id="offline" class="tab-pane fade">
                            <table id="offlineTable" title="2"></table>
                        </div>
                        <div id="all" class="tab-pane fade">
                            <table id="allTable"></table>
                        </div>
                        <div id="toolbar" class="row" >
                            <div id="toolbar_publishing" class="btn-group" style="margin-left: 5px;">
                                <button id="btn_offline" type="button" class="btn btn-warning" disabled="true"><span class="glyphicon glyphicon-save">&nbsp;一键下线</button>
                            </div>
                            <div id="toolbar_unpublished" class="btn-group" style="margin-left: 5px;">
                                <button id="btn_publish" type="button" class="btn btn-success" disabled="true"><span class="glyphicon glyphicon-open">&nbsp;一键发布</button>
                                <button id="btn_removeList" type="button" class="btn btn-danger" disabled="true"><span class="glyphicon glyphicon-trash">&nbsp;一键删除</button>
                            </div>
                            <div id="toolbar_offline" class="btn-group" style="margin-left: 5px;">
                                <button id="btn_publish" type="button" class="btn btn-success" disabled="true"><span class="glyphicon glyphicon-open">&nbsp;一键发布</button>
                                <button id="btn_removeList" type="button" class="btn btn-danger" disabled="true"><span class="glyphicon glyphicon-trash">&nbsp;一键删除</button>
                            </div>
                        </div>
                    </div></div>
                </div>
            </div>
        </div>
    </section>
    <script src="/bootstrap/bootstrap-table.js"></script>
    <script src="/bootstrap/bootstrap-table-zh-CN.js"></script>
<script>
    $(function () {
        $('#beginDatepicker').datetimepicker({
            language:  'zh-CN',
            format:'yyyy-mm-dd',
            weekStart: 0, /*以星期一为一星期开始*/
            todayBtn:  1,
            autoclose: 1,
            startView: 'year',
            minView:'month', /*精确到月*/
            pickerPosition: "bottom-left"
        }).on("changeDate",function(ev){  //值改变事件
            //选择的日期不能大于第二个日期控件的日期
            if(ev.date){
                $("#endDatepicker").datetimepicker('setStartDate', new Date(ev.date.valueOf()));
            }else{
                $("#endDatepicker").datetimepicker('setStartDate',null);
            }
        });

        $('#endDatepicker').datetimepicker({
            language:  'zh-CN',
            format:'yyyy-mm-dd',
            weekStart: 0, /*以星期一为一星期开始*/
            todayBtn:  1,
            autoclose: 1,
            startView: 'year',
            minView:'month', /*精确到月*/
            pickerPosition: "bottom-left"
        }).on("changeDate",function(ev){
            //选择的日期不能小于第一个日期控件的日期
            if(ev.date){
                $("#beginDatepicker").datetimepicker('setEndDate', new Date(ev.date.valueOf()));
            }else{
                $("#beginDatepicker").datetimepicker('setEndDate',null);
            }
        });

        initPositionTable();

        $('#allTable').bootstrapTable({
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
            sortStable:true,
            sortable:true,
            sortOrder:'desc',
            sortName:'createdTime',
            pageSize:2,//单页记录数
            pageList:[2,5,10],//分页步进值
            toolbarAlign:'right',
            buttonsAlign:'right',//按钮对齐方式
            paginationVAlign:'top',//分页栏位置
            columns:[
                {
                    title:'职位名',
                    field:'name',
                    align:'center',
                    sortable:true
                },
                {
                    title:'招聘人数',
                    field:'recruitNum',
                    align:'center',
                    sortable:true
                },
                {
                    title:'工作经验',
                    field:'experience',
                    align:'center',
                    sortable:true
                },
                {
                    title:'职位类型',
                    field:'jobType.name',
                    align:'center',
                    sortable:true
                },
                {
                    title:'发布日期',
                    align:'center',
                    sortable:true,
                    field:'createdTime'
                },
                {
                    title:'截止日期',
                    align:'center',
                    sortable:true,
                    field:'deadline'
                },
                {
                    title:'职位状态',
                    align:'center',
                    sortable:true,
                    field:'state',
                    formatter:function (value, row, index) {
                        var classes = ['default','success', 'warning'];
                        var word = ['未发布','发布中','已下线'];
                        return '<label class="label label-' + classes[value] +'">'+ word[value] + '</label>';
                    }
                },
                {
                    field: 'operate',
                    title: '操作',
                    align:'center',
                    width:100,
                    events: operateEvents,
                    formatter: operateFormatter
                }
            ]
        });

        $('#btn_search').click(function () {
            $('#replyContent .tab-pane.fade.active.in').find('table').eq(1).bootstrapTable('refresh');
        });

        $('#btn_publish').click(function () {
            var ids = $.map($('#replyContent .tab-pane.fade.active.in').find('table').eq(1).bootstrapTable('getSelections'),function (row) {
                return row.id
            }).join(',');

            $.post(
                "/position/publishPositions",
                    {ids:ids},
                    function (data) {
                        if(data.code == 1) {
                            toastr.success(data.msg);
                            $('#replyContent .tab-pane.fade').find('table').each(function () {
                                $(this).bootstrapTable('refresh');
                            });
                            $('#btn_publish').prop('disabled',true);
                            $('#btn_removeList').prop('disabled',true);
                        }else {
                            toastr.error(data.msg);
                        }
                        console.log(data.msg);
                    }
            );

        });

        $('#btn_offline').click(function () {
            var ids = $.map($('#replyContent .tab-pane.fade.active.in').find('table').eq(1).bootstrapTable('getSelections'),function (row) {
                return row.id
            }).join(',');

            $.post(
                "/position/offlinePositions",
                    {ids:ids},
                    function (data) {
                        if (data.code == 1) {
                            toastr.success(data.msg);
                            $('#replyContent .tab-pane.fade').find('table').each(function () {
                                $(this).bootstrapTable('refresh');
                            });
                            $('#btn_offline').prop('disabled',true);
                        }else {
                            toastr.error(data.msg);
                        }
                        console.log(data.msg);
                    }
            );
        });
        $('#btn_removeList').click(function () {
            var ids = $.map($('#replyContent .tab-pane.fade.active.in').find('table').eq(1).bootstrapTable('getSelections'),function (row) {
                return row.id
            }).join(',');

            $.post(
                "/position/deletePositions",
                    {ids:ids},
                    function (data) {
                        if(data.code == 1){
                            toastr.success(data.msg);
                            $('#replyContent .tab-pane.fade.active.in').find('table').bootstrapTable('refresh');
                            $('#allTable').bootstrapTable('refresh');
                            $('#btn_publish').prop('disabled',true);
                            $('#btn_removeList').prop('disabled',true);
                        }else {
                            toastr.error(data.msg);
                        }
                        console.log(data.msg);
                    }
            );
        });

        $('#publishingTable').on('check.bs.table uncheck.bs.table check-all.bs.table uncheck-all.bs.table', function () {
            $('#toolbar_publishing #btn_offline').prop('disabled', !$('#publishingTable').bootstrapTable('getSelections').length);
        });

        $('#unpublishedTable').on('check.bs.table uncheck.bs.table check-all.bs.table uncheck-all.bs.table', function () {
            $('#toolbar_unpublished #btn_removeList').prop('disabled', !$('#unpublishedTable').bootstrapTable('getSelections').length);
            $('#toolbar_unpublished #btn_publish').prop('disabled', !$('#unpublishedTable').bootstrapTable('getSelections').length);
        });
        $('#offlineTable').on('check.bs.table uncheck.bs.table check-all.bs.table uncheck-all.bs.table', function () {
            $('#toolbar_offline #btn_removeList').prop('disabled', !$('#offlineTable').bootstrapTable('getSelections').length);
            $('#toolbar_offline #btn_publish').prop('disabled', !$('#offlineTable').bootstrapTable('getSelections').length);
        });


    });

    function initPositionTable() {
        var tableArray = $('.tab-content table[id]').toArray();
        var toolbarArray = $('#toolbar div[class="btn-group"]').toArray();

        for (var i = 0;i < toolbarArray.length;i++) {
            $(tableArray[i]).bootstrapTable({
                method: 'post',
                contentType: "application/x-www-form-urlencoded",
                url: "/position/positionManage?state=" + $(tableArray[i]).attr('title'),
                striped: true, //是否显示行间隔色
                cache: false,
                pageNumber: 1, //初始化加载第一页，默认第一页
                pagination: true,//是否分页
                queryParams: function (params) {
                    return {
                        pageSize: params.pageSize,
                        pageNumber: params.pageNumber,
                        sortName:params.sortName,
                        sortOrder:params.sortOrder,
                        deptId: $('#deptSelect option:selected').val(),
                        positionKey: $('input[name="positionKey"]').val(),
                        beginDate: $('input[name="beginDate"]').val(),
                        endDate: $('input[name="endDate"]').val()
                    }
                },
                queryParamsType: 'undefined',
                sidePagination: 'server',
                sortStable:true,
                sortable:true,
                sortOrder:'desc',
                sortName:'createdTime',
                pageSize: 2,//单页记录数
                pageList: [2, 5, 10],//分页步进值
                // clickToSelect: true,//是否启用点击选中行
                toolbarAlign: 'left',
                // buttonsAlign:'right',//按钮对齐方式
                paginationVAlign: 'bottom',//分页栏位置
                toolbar: toolbarArray[i],//指定工作栏
                columns: [
                    {
                        title: '全选',
                        field: 'select',
                        checkbox: true,
                        width: 25,
                        align: 'center'
                    },
                    {
                        title: '职位名',
                        field: 'name',
                        align:'center',
                        sortable: true
                    },
                    {
                        title: '招聘人数',
                        field: 'recruitNum',
                        align:'center',
                        sortable: true
                    },
                    {
                        title: '工作经验',
                        field: 'experience',
                        align:'center',
                        sortable: true
                    },
                    {
                        title: '职位类型',
                        field: 'jobType.name',
                        align:'center',
                        sortable: true
                    },
                    {
                        title:'发布日期',
                        align:'center',
                        sortable:true,
                        field:'createdTime'
                    },
                    {
                        title:'截止日期',
                        align:'center',
                        sortable:true,
                        field:'deadline'
                    },
                    {
                        field: 'operate',
                        title: '操作',
                        align:'center',
                        width:100,
                        events: operateEvents,
                        formatter: operateFormatter
                    }
                ]
            });

        }
    }

    function operateFormatter(value, row, index) {
        var res;
        if(row.state == 1){
            res = [
                '<a id="btn_edit" type="button" href="/position/editPosition?id='+ row.id +'" class="btn btn-xs btn-info" title="修改" target="_blank"><span class="glyphicon glyphicon-edit"></span></a>',
                '<button id="btn_offline" type="button" class="btn btn-xs btn-warning" title="下线"><span class="glyphicon glyphicon-save"></span></button>'
            ].join('');
        }
        if(row.state == 0 || row.state == 2){
            res = [
                '<button id="btn_publish" type="button" class="btn btn-xs btn-success" title="发布"><span class="glyphicon glyphicon-open"></span></button>',
                '<a id="btn_edit" type="button" href="/position/editPosition?id='+ row.id +'" class="btn btn-xs btn-info" title="修改" target="_blank"><span class="glyphicon glyphicon-edit"></span></a>',
                '<button id="btn_remove" type="button" class="btn btn-xs btn-danger" title="删除"><span class="glyphicon glyphicon-trash"></span></button>'
            ].join('');
        }
        return res;
    }
    window.operateEvents = {
        "click #btn_publish": function(e, value, row, index) {
            $.post(
                    "/position/publishPositions",
                    {ids:row.id},
                    function (data) {
                        if(data.code == 1){
                            toastr.success(data.msg);
                            $('#replyContent .tab-pane.fade').find('table').each(function () {
                                $(this).bootstrapTable('refresh');
                            });
                        }else {
                            toastr.error(data.msg);
                        }
                        console.log(data.msg);
                    }
            );
        },
        "click #btn_offline": function(e, value, row, index) {
            $.post(
                    "/position/offlinePositions",
                    {ids:row.id},
                    function (data) {
                        if(data.code == 1){
                            toastr.success(data.msg);
                            $('#replyContent .tab-pane.fade').find('table').each(function () {
                                $(this).bootstrapTable('refresh');
                            });
                        }else {
                            toastr.error(data.msg);
                        }
                        console.log(data.msg);
                    }
            );
        },
        "click #btn_remove": function (e, value, row, index) {
            $.post(
                    "/position/deletePositions",
                    {ids:row.id},
                    function (data) {
                        if(data.code == 1){
                            toastr.success(data.msg);
                            $('#replyContent .tab-pane.fade.active.in').find('table').bootstrapTable('refresh');
                            $('#allTable').bootstrapTable('refresh');
                        }else {
                            toastr.error(data.msg);
                        }
                        console.log(data.msg);
                    }
            );
        }
    };

    //请求服务数据时所传参数
    function queryParams(params){
        return{
            pageSize: params.pageSize,
            pageNumber:params.pageNumber,
            sortName:params.sortName,
            sortOrder:params.sortOrder,
            deptId:$('#deptSelect option:selected').val(),
            positionKey:$('input[name="positionKey"]').val(),
            beginDate:$('input[name="beginDate"]').val(),
            endDate:$('input[name="endDate"]').val()
        }
    };


</script>
</body>
</html>