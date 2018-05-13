<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>职位类别</title>
    <link rel="stylesheet" type="text/css" href="/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/bootstrap/bootstrap-table.css">
    <link rel="stylesheet" type="text/css" href="/css/jquery.treegrid.css">

</head>
<body>
    <section class="container-fluid">
        <div class="panel panel-primary">
            <div class="panel-heading"><h2 class="panel-title">职位类别列表</h2>
            </div>
            <div class="panel-body">
                <table id="positionTypeTable"></table>
                <div class="row">
                    <div id="toolbar" class="btn-group pull-right" style="margin-right: 20px;">
                        <div class="form-inline">
                            <button id="btn_remove" type="button" class="btn btn-danger" disabled="true"><span class="glyphicon glyphicon-minus-sign" aria-hidden="true"></span>删除</button>
                            <button id="btn_newFirst" type="button" class="btn btn-info" data-toggle="modal" data-target="#editForm"><span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>新增</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- MODAL -->
    <section class="modal fade" id="editForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content modal-popup">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title" id="myModalLabel">编辑职位类型</h2>
                </div>

                <div class="modal-body">
                    <div class="container-fluid">
                        <form id="subForm" class="form-horizontal" role="form">
                            <div class="form-group">
                                <label for="name" class="col-md-4 control-label">职位类型名</label>
                                <div class="col-md-6">
                                <input type="text" class="form-control" name="name" id="name">
                                </div>
                            </div>
                            <input type="hidden" name="id" id="id">
                            <input type="hidden" name="pid" id="pid">
                        </form>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" id="btn_cancel" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="btn_save">保存</button>
                </div>
            </div>
        </div>
    </section>


    <script src="/js/jquery.min.js"></script>
    <script src="/bootstrap/bootstrap.min.js"></script>
    <script src="/bootstrap/bootstrap-table.js"></script>
    <script src="/bootstrap/bootstrap-table-treegrid.js"></script>
    <script src="/bootstrap/bootstrap-table-zh-CN.js"></script>
    <script src="/js/jquery.treegrid.min.js"></script>


<script>
    $(function () {

        var $table = $('#positionTypeTable'),
            $cancel = $('#btn_cancel'),
            $save = $('#btn_save'),
            $remove = $('#btn_remove');

        $table.bootstrapTable({
            type: 'post',
            idFiled:'id',
            parentIdField:'pid',
            treeShowField:'name',
            contentType: "application/x-www-form-urlencoded",
            url:"/admin/positionTypeList",
            striped: true, //是否显示行间隔色
            cache:false,
            // pageNumber: 1, //初始化加载第一页，默认第一页
            // pagination:true,//是否分页
            // queryParams:queryParams,
            // queryParamsType:'undefined',
            // sidePagination:'server',
            // pageSize:2,//单页记录数
            // pageList:[2,5,10],//分页步进值
            // search:true,
            showRefresh:true,//刷新按钮
            showColumns:true,
            // clickToSelect: true,//是否启用点击选中行
            toolbarAlign:'left',
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
                    title:'PID',
                    field:'pid',
                    visible:false
                },
                {
                    title:'职位类型名',
                    field:'name',
                    sortable:true
                },
                {
                    title:'职位数',
                    field:'jobCount',
                    sortable:true
                },
                {
                    title:'点击数',
                    field:'hit',
                    sortable:true
                },
                {
                    title:'创建日期',
                    field:'createdTime',
                    sortable:true
                },
                {
                    title:'修改日期',
                    field:'updatedTime',
                    sortable:true
                },
                {
                    field:'operate',
                    title: '操作',
                    events: operateEvents,
                    formatter: operateFormatter
                }
            ],
            onLoadSuccess: function(data) {
                console.log('load');
                // jquery.treegrid.js
                $table.treegrid({
                    // initialState: 'collapsed',
                    treeColumn: 1,
                    // expanderExpandedClass: 'glyphicon glyphicon-minus',
                    // expanderCollapsedClass: 'glyphicon glyphicon-plus',
                    onChange: function() {
                        $table.bootstrapTable('resetWidth');
                    }
                });
            }
        });

        $table.on('check.bs.table uncheck.bs.table check-all.bs.table uncheck-all.bs.table', function () {
            $remove.prop('disabled', !$table.bootstrapTable('getSelections').length);
        });

        $cancel.click(function () {
            // $('#subForm :input').not(":button, :submit, :reset, :hidden, :checkbox, :radio").attr('value','');
            // $('#subForm :input').removeAttr("checked").remove("selected");
            resetForm();
            $('#editForm').modal('handleUpdate');
        });
        $save.click(function () {
            var data = $('#subForm').serialize();
            resetForm();
            $('#editForm').modal('handleUpdate');
            $.ajax({
                url:'/admin/saveJobType',
                type:'POST',
                contentType:'application/x-www-form-urlencoded',
                data:data,
                success:function(data){
                    if(data.code != 0){
                        $table.bootstrapTable('refresh', {url: '/admin/positionTypeList'});
                        $('#editForm').modal('toggle');
                    }
                    console.log(data.msg);
                }
            });
        });

        $remove.click(function () {
            var ids = $.map($table.bootstrapTable('getSelections'), function (row) {
                return row.id;
            }).join(',');
            $.post(
                "/admin/deleteJobType",
                    {ids:ids},
                    function (data) {
                        if(data.code == 1){
                            // $table.bootstrapTable('remove', {
                            //     field: 'id',
                            //     values: ids
                            // });
                            $table.bootstrapTable('refresh', {url: '/admin/positionTypeList'});
                            $remove.prop('disabled', true);
                        }
                        console.log(data.msg);
                    }
            );

        });

    });

    function operateFormatter(value, row, index) {
        if(row.pid == 0){
            return [
                '<button id="btn_new" type="button" class="btn btn-info">新增</button>&nbsp&nbsp',
                '<button id="btn_edit" type="button" class="btn btn-warning">修改</button>'
            ].join('');
        }
        return [
            '<button id="btn_edit" type="button" class="btn btn-warning">修改</button>'
        ].join('');
    }
    window.operateEvents = {
        "click #btn_edit": function(e, value, row, index) {
            $('#id').attr('value',row.id);
            $('#name').attr('value',row.name);
            $('#editForm').modal('handleUpdate');
            $('#editForm').modal('toggle');
        },
        "click #btn_new": function(e, value, row, index) {
            $('#pid').attr('value',row.id);
            $('#editForm').modal('handleUpdate');
            $('#editForm').modal('toggle');
        }
    };

    /*请求服务数据时所传参数
    function queryParams(params){
        return{
            pageSize: params.pageSize,
            pageNumber:params.pageNumber
        }
    };*/

    function resetForm() {
        // $('#subForm')[0].reset();
        $('#subForm :input').not(":button, :submit, :reset, :checkbox, :radio").attr('value','');
        $('#subForm :input').removeAttr("checked").remove("selected");
    }

</script>
</body>
</html>