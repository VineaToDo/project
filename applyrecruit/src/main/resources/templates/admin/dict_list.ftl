<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>系统设置</title>
    <link rel="stylesheet" type="text/css" href="/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/bootstrap/bootstrap-table.css">

</head>
<body style="height: 500px">
    <section class="container-fluid">
        <#--<div class="panel panel-primary">-->
            <#--<div class="panel-heading"><h2 class="panel-title">数据字典列表</h2>-->
            <#--</div>-->
            <#--<div class="panel-body">-->
                <table id="dictTable"></table>
                <div class="row">
                    <div id="toolbar" class="btn-group" style="margin-right: 20px;">
                        <button id="btn_removeList" type="button" class="btn btn-danger" disabled="true"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>&nbsp;删除</button>
                        <button id="btn_newFirst" type="button" class="btn btn-info" data-toggle="modal" data-target="#parentModal"><span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>&nbsp;新增</button>
                    </div>
                </div>
            <#--</div>-->
        <#--</div>-->
    </section>

    <!-- MODAL -->
    <section class="modal fade" id="parentModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content modal-popup">
                <div class="modal-header">
                    <h2 class="modal-title" id="myModalLabel1">编辑数据字典</h2>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <form id="parentForm" class="form-horizontal" role="form">
                            <div class="form-group">
                                <label for="code" class="col-md-4 control-label">字典编码</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="code" id="code">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="name" class="col-md-4 control-label">数据字典名</label>
                                <div class="col-md-6">
                                <input type="text" class="form-control" name="name" id="name">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="description" class="col-md-4 control-label">描述</label>
                                <div class="col-md-6">
                                <input type="text" class="form-control" name="description" id="description">
                                </div>
                            </div>
                            <input type="hidden" name="id" id="parentId">
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
    <section class="modal fade" id="subModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content modal-popup">
                <div class="modal-header">
                    <h2 class="modal-title" id="myModalLabel2">编辑字典项</h2>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <form id="subForm" class="form-horizontal" role="form">
                            <div class="form-group">
                                <label for="value" class="col-md-4 control-label">字典值</label>
                                <div class="col-md-6">
                                <input type="text" class="form-control" name="value" id="value">
                                </div>
                            </div>
                            <input type="hidden" name="id" id="subId">
                            <input type="hidden" name="pid" id="pid">
                        </form>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" id="btn_cancel_sub" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="btn_save_sub">保存</button>
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
        var $parentModal = $('#parentModal'),$cancel = $('#btn_cancel'),$save = $('#btn_save'),$remove = $('#btn_removeList'),$table = $('#dictTable');

        $table.bootstrapTable({
            type: 'post',
            contentType: "application/x-www-form-urlencoded",
            url:"/admin/dictList",
            striped: true, //是否显示行间隔色
            cache:false,
            detailView: true,//父子表
            // pageNumber: 1, //初始化加载第一页，默认第一页
            // pagination:true,//是否分页
            // queryParams:queryParams,
            // queryParamsType:'undefined',
            // sidePagination:'server',
            // pageSize:2,//单页记录数
            // pageList:[2,5,10],//分页步进值
            search:true,
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
                    title:'序号',
                    align:'center',
                    sortable:true,
                    formatter:function (value,row,index) {
                        return index + 1;
                    }
                },
                {
                    title:'ID',
                    field:'id',
                    visible:false
                },
                {
                    title:'字典编码',
                    field:'code',
                    sortable:true
                },
                {
                    title:'数据字典名',
                    field:'name'
                },
                {
                    title:'描述',
                    field:'description'
                },
                {
                    field:'operate',
                    title: '操作',
                    width:100,
                    align: 'center',
                    events: parentOperateEvents,
                    formatter: parentOperateFormatter
                }
            ],
            //注册加载子表的事件。三个参数--index：父表当前行的行索引。row：父表当前行的Json数据对象。$detail：当前行下面创建的新行里面的td对象。
            onExpandRow: function (index, row, $detail) {
                initSubTable(index, row, $detail);
            }
        });

        $table.on('check.bs.table uncheck.bs.table check-all.bs.table uncheck-all.bs.table', function () {
            $remove.prop('disabled', !$table.bootstrapTable('getSelections').length);
        });

        $cancel.click(function () {
            // $('#subForm :input').not(":button, :submit, :reset, :hidden, :checkbox, :radio").attr('value','');
            // $('#subForm :input').removeAttr("checked").remove("selected");
            resetParentForm();
            $parentModal.modal('handleUpdate');

        });
        $save.click(function () {
            var data = $('#parentForm').serialize();
            $.ajax({
                url:'/admin/saveDict',
                type:'POST',
                contentType:'application/x-www-form-urlencoded',
                data:data,
                success:function(data){
                    if(data.code != 0){
                        // $table.bootstrapTable('refresh', {url: '/admin/dictList'});
                        // resetParentForm();
                        // $parentModal.modal('handleUpdate');
                        // $parentModal.modal('toggle');
                        hint({ data:data.msg,type:"success"});
                        window.location.reload(true);
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
                "/admin/deleteDict",
                    {ids:ids,level:0},
                    function (data) {
                        if(data.code != 0){
                            // $table.bootstrapTable('remove', {
                            //     field: 'id',
                            //     values: ids
                            // });
                            hint({ data:data.msg,type:"success"});
                            $table.bootstrapTable('refresh', {url: '/admin/dictList'});
                            $remove.prop('disabled', true);
                        }
                        console.log(data.msg);
                    }
            );
        });
    });

    function parentOperateFormatter(value, row, index) {
        return [
            '<button id="btn_new" type="button" class="btn btn-xs btn-info" title="新增"><span class="glyphicon glyphicon-plus"></span></button>&nbsp',
            '<button id="btn_edit" type="button" class="btn btn-xs btn-warning" title="修改"><span class="glyphicon glyphicon-pencil"></span></button>&nbsp',
            '<button id="btn_remove" type="button" class="btn btn-xs btn-danger" title="删除"><span class="glyphicon glyphicon-trash"></span></button>'
        ].join('');
    }
    function subOperateFormatter(value, row, index) {
        return [
            '<button id="btn_edit_sub" type="button" class="btn btn-xs btn-warning" title="修改"><span class="glyphicon glyphicon-pencil"></span></button>&nbsp',
            '<button id="btn_remove_sub" type="button" class="btn btn-xs btn-danger" title="删除"><span class="glyphicon glyphicon-trash"></span></button>'
        ].join('');
    }
    window.parentOperateEvents = {
        "click #btn_new": function(e, value, row, index) {
            $('#pid').attr('value',row.id);
            $('#dictTable').bootstrapTable('expandRow',index);
            $('#subModal').modal('handleUpdate');
            $('#subModal').modal('toggle');
        },
        "click #btn_edit": function(e, value, row, index) {
            $('#parentId').attr('value',row.id);
            $('#code').attr('value',row.code);
            $('#name').attr('value',row.name);
            $('#description').attr('value',row.description);
            $('#parentModal').modal('handleUpdate');
            $('#parentModal').modal('toggle');
        },
        "click #btn_remove": function(e, value, row, index) {
            // var ids = $.map(row.id);
            $.post(
                    "/admin/deleteDict",
                    {ids:row.id,level:0},
                    function (data) {
                        if(data.code == 1){
                            hint({ data:data.msg,type:"success"});
                            $('#dictTable').bootstrapTable('refresh', {url: '/admin/dictList'});
                            $('#btn_remove').prop('disabled', true);
                        }
                        console.log(data.msg);
                    }
            );
        },

    };
    window.subOperateEvents = {
        "click #btn_edit_sub": function(e, value, row, index) {
            $('#subId').attr('value',row.id);
            $('#value').attr('value',row.value);
            $('#pid').attr('value',row.pid);
            $('#subModal').modal('handleUpdate');
            $('#subModal').modal('toggle');
        },
        "click #btn_remove_sub": function(e, value, row, index) {
            $.post(
                    "/admin/deleteDict",
                    {ids:row.id,level:1},
                    function (data) {
                        if(data.code == 1){
                            hint({ data:data.msg,type:"success"});
                            $('#childTable').bootstrapTable('remove', {
                                field: 'id',
                                values: [row.id]
                            });
                            // $(cur_table).bootstrapTable('refresh', {url: '/admin/dictList'});
                            $remove.prop('disabled', true);
                        }
                        console.log(data.msg);
                    }
            );
        }
    };

    function initSubTable(index, row, $detail) {
        var cur_table = $detail.html('<table id="childTable"></table><div id="toolbar_sub" class="btn-group" style="margin-right: 20px;"><button id="btn_removeList_sub" type="button" class="btn btn-danger" disabled="true"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>&nbsp删除</button></div>')
                .find('table');
        var $subModal = $('#subModal'),
            $cancel_sub = $('#btn_cancel_sub'),
            $save_sub = $('#btn_save_sub'),
            $remove_sub = $('#btn_removeList_sub');
        $(cur_table).bootstrapTable({
            striped: true, //是否显示行间隔色
            cache:false,
            toolbar:'#toolbar_sub',
            columns: [{
                checkbox: true
            }, {
                field: 'id',
                title: 'ID',
                visible:false
            }, {
                field: 'pid',
                title: 'PID',
                visible:false
            }, {
                field: 'code',
                title: '值编码'
            }, {
                field: 'value',
                title: '字典值'
            },{
                field:'operate',
                title: '操作',
                width:100,
                align: 'center',
                valign: 'middle',
                events: subOperateEvents,
                formatter: subOperateFormatter
            }],
            data:row.dict_items
        });

        $(cur_table).on('check.bs.table uncheck.bs.table check-all.bs.table uncheck-all.bs.table', function () {
            $remove_sub.prop('disabled', !$(cur_table).bootstrapTable('getSelections').length);
        });

        $cancel_sub.click(function () {
            resetSubForm();
            $subModal.modal('handleUpdate');
        });
        $save_sub.click(function () {
            var data = $('#subForm').serialize();
            $.ajax({
                url:'/admin/saveDictItem',
                type:'POST',
                contentType:'application/x-www-form-urlencoded',
                data:data,
                success:function(data){
                    if(data.code != 0){
                        hint({ data:data.msg,type:"success"});
                        window.location.reload(true);
                    }
                    console.log(data.msg);
                }
            });
        });

        $remove_sub.click(function () {
            var idList = $.map($(cur_table).bootstrapTable('getSelections'), function (row) {
                return row.id;
            });
            var ids = idList.join(',');
            $.post(
                    "/admin/deleteDict",
                    {ids:ids,level:1},
                    function (data) {
                        if(data.code != 0){
                            hint({ data:data.msg,type:"success"});
                            $('#childTable').bootstrapTable('remove', {
                                field: 'id',
                                values: idList
                            });
                            // $(cur_table).bootstrapTable('refresh', {url: '/admin/dictList'});
                            $remove.prop('disabled', true);
                        }
                        console.log(data.msg);
                    }
            );
        });
    };
    /*请求服务数据时所传参数
    function queryParams(params){
        return{
            pageSize: params.pageSize,
            pageNumber:params.pageNumber
        }
    };*/
    function resetParentForm() {
        $('#parentForm :input').not(":button, :submit, :reset, :checkbox, :radio").attr('value','');
        $('#parentForm :input').removeAttr("checked").remove("selected");
    }

    function resetSubForm() {
        $('#subForm :input').not(":button, :submit, :reset, :checkbox, :radio").attr('value','');
        $('#subForm :input').removeAttr("checked").remove("selected");
    }
    
    function hint(data) {
        window.parent.hintData(data);
    }

    /* center modal */
    function centerModals() {
        $('#parentModal,#subModal').each(function(i) {
            var $clone = $(this).clone().css('display', 'block').appendTo('body');
            var top = Math.round(($clone.height() - $clone.find('.modal-content').height()) / 2);
            top = top > 0 ? top : 0;
            $clone.remove();
            $(this).find('.modal-content').css("margin-top", top);
        });
    }
    $('#parentModal').on('show.bs.modal', centerModals);
    $('#subModal').on('show.bs.modal', centerModals);
    $(window).on('resize', centerModals);


</script>
</body>
</html>