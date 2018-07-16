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
                <li class="active">反馈通</li>
                </ol></h2>
                <#--<form class="navbar-form navbar-right" role="search">-->
                    <#--<div class="form-group">-->
                        <#--<label class="control-label" for="deptSelect">所属部门</label>-->
                        <#--<select id="deptSelect" class="selectpicker" name="deptId" multiple data-max-options='1' title="所有部门">-->
                            <#--<#list Session.user.companyInfo.departments as dept>-->
                                <#--<option value="${dept.id}">${dept.name}</option>-->
                            <#--</#list>-->
                        <#--</select>-->
                    <#--</div>-->
                    <#--<div class="form-group">-->
                        <#--<label class="control-label">职位名称</label>-->
                        <#--<input class="form-control" type="text" placeholder="输入职位关键字" name="positionKey">-->
                    <#--</div>-->
                    <#--<button id="btn_search" type="button" class="btn btn-info" disabled="true"><span class="glyphicon glyphicon-search"></span></button>-->
                <#--</form>-->
            </div>
            <div class="panel-body">
                <ul id="resumeTab" class="nav nav-tabs nav-justified">
                    <li class="active"><a href="#pending" data-toggle="tab">待处理</a></li>
                    <li><a href="#unCertain" data-toggle="tab">待沟通</a></li>
                    <li><a href="#invited" data-toggle="tab">已邀请面试</a></li>
                    <li><a href="#improper" data-toggle="tab">不合适</a></li>
                    <form class="navbar-form navbar-right" role="search">
                        <div class="form-group">
                            <label for="selectedDate" class="control-label">最早投递日期</label>
                            <div class="input-group date" id="setPicker">
                                <input type="text" class="form-control" id="selectedDate" name="selectedDate" readonly>
                                <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span><span class="input-group-addon"><i class="glyphicon glyphicon-remove"></i></span>
                            </div>
                        </div>
                    </form>
                </ul>
                <div id="resumeContent" class="tab-content">
                    <div id="pending" class="tab-pane fade in active">
                        <table id="pendingTable" title="available=0&available=1"></table>
                    </div>
                    <div id="unCertain" class="tab-pane fade">
                        <table id="unCertainTable" title="available=3"></table>
                    </div>
                    <div id="invited" class="tab-pane fade">
                        <table id="invitedTable" title="available=2"></table>
                    </div>
                    <div id="improper" class="tab-pane fade">
                        <table id="improperTable" title="available=4"></table>
                    </div>
                </div>
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
            format:'yyyy-mm-dd',
            weekStart: 0, /*以星期一为一星期开始*/
            autoclose: 1,
            startView: 'year',
            minView:'month', /*精确到月*/
            pickerPosition: "bottom-left"
        }).on('changeDate',function (ev) {
            $('#resumeContent .tab-pane.fade.active.in').find('table').bootstrapTable('refresh');
        });

        initTable();

    });

    function initTable() {
        var tableArray = $('#resumeContent table').toArray();
        for (var i = 0;i < tableArray.length;i++) {
            $(tableArray[i]).bootstrapTable({
                method: 'post',
                contentType: "application/x-www-form-urlencoded",
                url: "/deliver/deliverList?" + $(tableArray[i]).attr('title'),
                striped: true, //是否显示行间隔色
                cache: false,
                pageNumber: 1, //初始化加载第一页，默认第一页
                pagination: true,//是否分页
                queryParams: queryParams,
                queryParamsType:'undefined',
                sortStable:true,
                sortable:true,
                sortOrder:'desc',
                sortName:'createdTime',
                sidePagination:'server',
                pageSize:2,//单页记录数
                pageList:[2,5,10],//分页步进值
                showRefresh:true,//刷新按钮
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
        }
    }
    function viewFormatter(value, row, index) {
        return '<a id="btn_view" type="button" href="/deliver/getDeliver?deliverId='+ row.id +'" class="btn btn-xs btn-success" title="查看简历" target="_blank"><span class="glyphicon glyphicon-eye-open"></span></a>';
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
                            $('#pendingTable').bootstrapTable('refresh');
                        }
                        console.log(data.msg);
                    }
                });
            }
            return true;
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