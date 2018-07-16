<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <title>企业用户</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
</head>
<body>
    <!-- 导航条 -->
    <#include "header.ftl"><div style="padding-top: 70px"></div>
    <!-- HOME -->
    <section class="container">
        <div class="panel panel-default">
            <div class="panel-heading row">
                <h2 class="panel-title"><ol class="breadcrumb">
                <li><a href="#">首页</a></li>
                <li>简历管理</li><li class="active">收件箱</li>
                </ol></h2>
            </div>
            <div class="panel-body">
                <ul id="resumeTab" class="nav nav-tabs">
                    <li class="active"><a href="#recent" data-toggle="tab">最新简历</a></li>
                    <li><a href="#publishing" data-toggle="tab">发布中职位</a></li>
                    <li><a href="#offline" data-toggle="tab">已下线职位</a></li>
                    <li id="resumeList" class="hidden" title=""><a href="#viewList" data-toggle="tab">职位-简历列表</a></li>
                    <form class="navbar-form navbar-right" role="search">
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
                        <button id="btn_search" type="button" class="btn btn-info" disabled="true"><span class="glyphicon glyphicon-search"></span></button>
                    </form>
                </ul>
                <div class="well well-lg"><div id="resumeContent" class="tab-content">
                    <div id="recent" class="tab-pane fade in active">
                        <table id="recentTable"></table>
                    </div>
                    <div id="publishing" class="tab-pane fade">
                        <table id="publishingTable" title="1"></table>
                    </div>
                    <div id="offline" class="tab-pane fade">
                        <table id="offlineTable" title="2"></table>
                    </div>
                    <div id="viewList" class="tab-pane fade">
                        <table id="viewListTable"></table>
                    </div>
                    <div id="toolbar" class="form-inline">
                        <div class="form-group">
                            <label for="selectedDate" class="control-label">最早投递日期</label>
                            <div class="input-group date" id="setPicker">
                                <input type="text" class="form-control" id="selectedDate" name="selectedDate" readonly>
                                <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                            </div>
                        </div>
                    </div>
                </div></div>
            </div>
        </div>

    </section>
    <script src="/bootstrap/bootstrap-table.js"></script>
    <script src="/bootstrap/bootstrap-table-zh-CN.js"></script>
<script>

    $(function () {
        $('#setPicker').datetimepicker({
            language: 'zh-CN',
            todayHighlight: true,
            // todayBtn: true.toSource
            format:'yyyy-mm-dd',
            weekStart: 0, /*以星期一为一星期开始*/
            autoclose: 1,
            startView: 'year',
            minView:'month', /*精确到月*/
            pickerPosition: "bottom-left"
        }).on('changeDate',function (ev) {
            $('#recentTable').bootstrapTable('refresh');
        });
        $('#selectedDate').val(recentDate);

        initPositionTable();
        $('#recentTable').bootstrapTable({
            method: 'post',
            contentType: "application/x-www-form-urlencoded",
            url:"/deliver/deliverList",
            striped: true, //是否显示行间隔色
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
            clickToSelect: true,//是否启用点击选中行
            rowStyle:rowStyle,
            toolbar:'#toolbar',
            columns:[
                {
                    title:'姓名',
                    align:'center',
                    sortable:true,
                    field:'resumeInfo.personalInfo.name'
                },
                {
                    title:'应聘职位',
                    align:'center',
                    sortable:true,
                    field:'position.name'
                },
                {
                    title:'工作经验',
                    align:'center',
                    sortable:true,
                    field:'resumeInfo.personalInfo.workYear',
                    formatter:function (value, row, index) {
                        var now = new Date();
                        var getDate = new Date(Date.parse(value));
                        var year = now.getFullYear() - getDate.getFullYear();
                        if(year != 0) return year + "年";
                        else if((now.getMonth() - getDate.getMonth()) != 0) return (now.getMonth() - getDate.getMonth()) + "个月";
                        else return "无工作经验";
                    }
                },
                {
                    title:'性别',
                    align:'center',
                    sortable:true,
                    field:'resumeInfo.personalInfo.gender',
                    formatter:function (value, row, index) {
                        if(value == 1) return '男';
                        else return'女';
                    }
                },
                {
                    title:'联系方式',
                    align:'center',
                    field:'resumeInfo.personalInfo.phone'
                },
                {
                    title:'最后更新',
                    align:'center',
                    sortable:true,
                    field:'resumeInfo.updatedTime'
                },
                {
                    title:'投递日期',
                    align:'center',
                    sortable:true,
                    field:'createdTime'
                },
                {
                    title:'查看简历',
                    field:'view',
                    align:'center',
                    width:80,
                    formatter:viewFormatter,
                    events:vieweEvents
                }
            ]
        });

        $('#viewListTable').bootstrapTable({
            method: 'post',
            contentType: "application/x-www-form-urlencoded",
            url:"/deliver/deliverList",
            striped: true, //是否显示行间隔色
            cache:false,
            pageNumber: 1, //初始化加载第一页，默认第一页
            pagination:true,//是否分页
            queryParams:function (params) {
                return{
                    pageSize: params.pageSize,
                    pageNumber:params.pageNumber,
                    sortName:params.sortName,
                    sortOrder:params.sortOrder,
                    positionId:$('#resumeList').attr('title')
                }
            },
            queryParamsType:'undefined',
            sortStable:true,
            sortable:true,
            sortOrder:'desc',
            sortName:'createdTime',
            sidePagination:'server',
            pageSize:2,//单页记录数
            pageList:[2,5,10],//分页步进值
            showRefresh:true,//刷新按钮
            clickToSelect: true,//是否启用点击选中行
            rowStyle:rowStyle,
            columns:[
                {
                    title:'姓名',
                    align:'center',
                    sortable:true,
                    field:'resumeInfo.personalInfo.name'
                },
                {
                    title:'应聘职位',
                    align:'center',
                    sortable:true,
                    field:'position.name'
                },
                {
                    title:'工作经验',
                    align:'center',
                    sortable:true,
                    field:'resumeInfo.personalInfo.workYear',
                    formatter:function (value, row, index) {
                        var now = new Date();
                        var getDate = new Date(Date.parse(value));
                        var year = now.getFullYear() - getDate.getFullYear();
                        if(year != 0) return year + "年";
                        else if((now.getMonth() - getDate.getMonth()) != 0) return (now.getMonth() - getDate.getMonth()) + "个月";
                        else return "无工作经验";
                    }
                },
                {
                    title:'性别',
                    align:'center',
                    sortable:true,
                    field:'resumeInfo.personalInfo.gender',
                    formatter:function (value, row, index) {
                        if(value == 1) return '男';
                        else return'女';
                    }
                },
                {
                    title:'联系方式',
                    align:'center',
                    field:'resumeInfo.personalInfo.phone'
                },
                {
                    title:'最后更新',
                    align:'center',
                    sortable:true,
                    field:'resumeInfo.updatedTime'
                },
                {
                    title:'投递日期',
                    align:'center',
                    sortable:true,
                    field:'createdTime'
                },
                {
                    title:'查看简历',
                    field:'view',
                    align:'center',
                    width:80,
                    formatter:viewFormatter,
                    events:vieweEvents
                }
            ]
        });

        $('a[data-toggle="tab"]').on('shown.bs.tab',function (e) {
            var tabText = $(e.target).text();
            var flag = (tabText== '发布中职位' || tabText == '已下线职位');
            $('#btn_search').attr('disabled',!flag);
        });

        $('#btn_search').click(function () {
            $('#resumeContent .tab-pane.fade.active.in').find('table').bootstrapTable('refresh');
        });

    });
    
    function recentDate() {
        var now = new Date();
        return (new Date(now - 86400000 * 15)).Format("yyyy-MM-dd");
    }

    function initPositionTable() {
        var tableArray = $('#resumeContent table[title]').toArray();
        for (var i = 0;i < tableArray.length;i++) {
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
                    }
                },
                queryParamsType: 'undefined',
                sortStable:true,
                sortable:true,
                sortOrder:'desc',
                sortName:'createdTime',
                sidePagination: 'server',
                pageSize: 2,//单页记录数
                pageList: [2, 5, 10],//分页步进值
                clickToSelect: true,//是否启用点击选中行
                paginationVAlign: 'bottom',//分页栏位置
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
                        align:'center',
                        sortable:true,
                        field: 'name'
                    },
                    {
                        title: '招聘人数',
                        align:'center',
                        sortable:true,
                        field: 'recruitNum'
                    },
                    {
                        title: '工作经验',
                        align:'center',
                        sortable:true,
                        field: 'experience'
                    },
                    {
                        title: '职位类型',
                        align:'center',
                        sortable:true,
                        field: 'jobType.name'
                    },
                    {
                        title:'发布时间',
                        align:'center',
                        sortable:true,
                        field:'createdTime'
                    },
                    {
                        title:'浏览量',
                        align:'center',
                        sortable:true,
                        field:'hit'
                    },
                    {
                        title:'投递数',
                        align:'center',
                        sortable:true,
                        field:'sent'
                    },
                    {
                        field: 'operate',
                        title: '简历列表',
                        align:'center',
                        width:80,
                        formatter: operateFormatter,
                        events:operateEvents
                    }
                ]
            });

        }
    }
    function viewFormatter(value, row, index) {
        return '<a id="btn_view" type="button" href="/deliver/getDeliver?deliverId='+ row.id +'" class="btn btn-xs btn-success" title="查看简历" target="_blank"><span class="glyphicon glyphicon-eye-open"></span></a>';
    }

    function operateFormatter(value, row, index) {
        return [
            '<button id="btn_list" type="button" class="btn btn-xs btn-info" title="查看应聘简历列表" target="_blank"><span class="glyphicon glyphicon-list"></span></button>'
        ].join('');
    }

    window.vieweEvents = {
        "click #btn_view": function(e, value, row, index) {

            if(row.available == 0){
                $.ajax({
                    url:'/deliver/feedback',
                    type:'POST',
                    contentType:'application/x-www-form-urlencoded',
                    data:{id:row.id,available:1},
                    success:function(data){
                        if(data.code == 1){
                            // window.location.reload(true);
                            $('#resumeContent .tab-pane.fade').find('table:not(table[title])').each(function () {
                                $(this).bootstrapTable('refresh');
                            });
                        }
                        console.log(data.msg);
                    }
                });
            }

            return true;
        }
    };
    window.operateEvents = {
        "click #btn_list": function(e, value, row, index) {
            $('#resumeTab li').removeClass('active');
            $('#resumeList').removeClass('hidden').attr('title',row.id);
            $('#resumeList a').tab('show');
            $('#viewListTable').bootstrapTable('refresh');
        }
    };


    //请求服务数据时所传参数
    function queryParams(params){
        return{
            pageSize: params.pageSize,
            pageNumber:params.pageNumber,
            sortName:params.sortName,
            sortOrder:params.sortOrder,
            selectedDate:$('#selectedDate').val()
        }
    }
    //对未查看的简历进行style标记
    function rowStyle(row,index){
        if(row.available == 0){
            return {classes:'danger'};
        }
        return {classes:'active'};
    }


    // 对Date的扩展，将 Date 转化为指定格式的String
    // 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，
    // 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)
    Date.prototype.Format = function (fmt) { //author: meizz
        var o = {
            "M+": this.getMonth() + 1, //月份
            "d+": this.getDate(), //日
            "H+": this.getHours(), //小时
            "m+": this.getMinutes(), //分
            "s+": this.getSeconds(), //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }


</script>
</body>
</html>