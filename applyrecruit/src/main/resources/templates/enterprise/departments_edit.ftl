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
            <div class="panel-heading"><h2 class="panel-title">设置部门结构</h2>
            </div>
            <div class="panel-body">
                <table id="deptTable"></table>
                <div class="row">
                    <div id="toolbar" class="btn-group" style="margin-right: 20px;">
                        <div class="form-inline">
                            <button id="btn_removeList" type="button" class="btn btn-danger" disabled="true"><span class="glyphicon glyphicon-trash"></span>&nbsp;一键删除</button>
                            <button class="btn btn-primary" type="button" data-toggle="modal" data-target="#deptModal"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>&nbsp;新增</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="modal fade" id="deptModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content modal-popup">
                <div class="modal-header bg-info">
                    <h4 class="modal-title">
                        <i class="fa fa-pencil"></i>
                        <span id="myModalLabel" style="font-weight:bold">编辑部门信息</span>
                    </h4>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <form id="deptForm" class="form-horizontal" role="form">
                            <div class="form-group">
                                <label class="control-label col-md-4">部门名称</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="name" id="name" value="">
                                </div>
                            </div>
                            <input type="hidden" id="id" name="id">
                        </form>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" id="btn_cancel" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="btn_save">提交</button>
                </div>
            </div>
        </div>
    </section>

    <script src="/bootstrap/bootstrap-table.js"></script>
    <script src="/bootstrap/bootstrap-table-zh-CN.js"></script>
<script>
    // toastr.options.positionClass = 'toast-center-center';
    $(function () {
        var $table = $('#deptTable'),$remove = $('#btn_removeList');
        $table.bootstrapTable({
            method: 'post',
            contentType: "application/x-www-form-urlencoded",
            url:"/company/deptList",
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
            toolbarAlign:'left',
            buttonsAlign:'right',//按钮对齐方式
            toolbar:'#toolbar',//指定工作栏
            columns:[
                {
                    title:'全选',
                    field:'select',
                    checkbox:true,
                    width:25,
                    align:'center'
                },
                {
                    title:'部门名',
                    field:'name',
                    align:'center',
                    sortable:true
                },
                {
                    title:'创建时间',
                    field:'createdTime',
                    align:'center',
                    sortable:'true'
                },
                {
                    title:'上次修改时间',
                    field:'updatedTime',
                    align:'center',
                    sortable:true
                },
                {
                    title:'操作',
                    field:'operate',
                    width:100,
                    align: 'center',
                    events: operateEvents,
                    formatter: operateFormatter
                }
            ]
        });

        $table.on('check.bs.table uncheck.bs.table check-all.bs.table uncheck-all.bs.table', function () {
            $remove.prop('disabled', !$table.bootstrapTable('getSelections').length);
        });

        $('#btn_save').click(function () {
            var data = $('#deptForm').serialize();
            $.post(
                    "/company/saveDepartments",
                    data,
                    function (data) {
                        if(data.code != -1){
                            $('#deptModal').modal('hide');
                            toastr.success(data.msg);
                            $table.bootstrapTable('refresh');
                        }else {
                            toastr.error(data.msg);
                        }
                    });
        });

        $remove.click(function () {
            var ids = ($.map($table.bootstrapTable('getSelections'), function (row) {
                return row.id;
            })).join(',');
            console.info(ids);
            $.post(
                    "/company/delDept",
                    {ids:ids},
                    function (data) {
                        if(data.code == 1){
                            toastr.success(data.msg);
                            $table.bootstrapTable('refresh');
                            $remove.prop('disabled', true);
                        }else {
                            toastr.error(data.msg);
                        }
                    }
            );
        });

        $('#deptModal').on('show.bs.modal', centerModals);
        $('#deptModal').on('hide.bs.modal',function () {
            $('#deptForm :input').not(":button, :submit").val('');
        });
        $(window).on('resize', centerModals);
    });

    function operateFormatter(value, row, index) {
        return [
            '<button id="btn_edit" type="button" class="btn btn-xs btn-warning" title="修改"><span class="glyphicon glyphicon-pencil"></span></button>&nbsp',
            '<button id="btn_remove" type="button" class="btn btn-xs btn-danger" title="删除"><span class="glyphicon glyphicon-trash"></span></button>'
        ].join('');
    };
    window.operateEvents = {
        "click #btn_edit": function(e, value, row, index) {
            $('#id').val(row.id);
            $('#name').val(row.name);
            $('#deptModal').modal('toggle');
        },
        "click #btn_remove": function(e, value, row, index) {
            $.post(
                    "/company/delDept",
                    {ids:row.id},
                    function (data) {
                        if(data.code == 1){
                            toastr.success(data.msg);
                            $('#deptTable').bootstrapTable('refresh');
                            // $('#btn_remove').prop('disabled', true);
                        }else {
                            toastr.error(data.msg);
                        }
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
            sortOrder:params.sortOrder
        }
    };
    /* center modal */
    function centerModals() {
        $('#deptModal').each(function(i) {
            var $clone = $(this).clone().css('display', 'block').appendTo('body');
            var top = Math.round(($clone.height() - $clone.find('.modal-content').height()) / 3);
            top = top > 0 ? top : 0;
            $clone.remove();
            $(this).find('.modal-content').css("margin-top", top);
        });
    }
</script>
</body>
</html>