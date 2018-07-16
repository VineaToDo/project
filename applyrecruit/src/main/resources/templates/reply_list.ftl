<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <title>企业用户</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" type="text/css" href="/css/jquery.webui-popover.min.css">
</head>
<body>
    <!-- 导航条 -->
    <#include "header.ftl">
    <div style="padding-top: 70px"></div>
    <!-- HOME -->
    <div class="container" style="margin-top: 40px;">
        <div class="well well-lg">
            <div class="panel panel-info">
                <div class="panel-heading"><ul id="replyTab" class="nav nav-pills">
                    <li class="active"><a href="#message" data-toggle="pill">新消息</a></li>
                    <li><a href="#deliver" data-toggle="pill">投递记录</a></li>
                </ul></div>
                <div class="panel-body"><div id="replyContent" class="tab-content">
                    <div id="message" class="tab-pane fade in active">
                                <#if messageList?? && messageList?size != 0>
                                <ul class="list-group">
                                    <#list messageList as message>
                                        <li class="list-group-item list-group-item-info">你投递的<label class="label label-primary">${message.positionName}</label>职位负责人
                                            <#if message.available == 1>已查看你的简历
                                            <#elseif message.available == 2>已通知你面试
                                            <#elseif message.available == 3>想与你进一步沟通
                                            <#elseif message.available == 4>觉得你暂时不适合</#if>
                                            ，请在投递记录中查看详情。
                                        </li>
                                    </#list>
                                </ul>
                                <#else>
                                    <div class="jumbotron text-center">
                                        <h3>暂无新消息</h3>
                                    </div>
                                </#if>
                    </div>
                    <div id="deliver" class="tab-pane fade">
                        <#if Session.user.resumeInfo??>
                            <div class="panel panel-warning">
                                <div class="panel-heading"><h3 class="panel-title">投递列表</h3></div>
                                <div class="panel-body">
                                    <table id="deliverTable"></table>
                                </div>
                            </div>
                        <#else>
                            <div class="jumbotron text-center">
                                <h3><a href="/resume/getResume">请先完善简历信息</a></h3>
                            </div>
                        </#if>
                    </div>
                </div></div>
            </div>
        </div>

    </div>
    <script src="/bootstrap/bootstrap-table.js"></script>
    <script src="/bootstrap/bootstrap-table-zh-CN.js"></script>
    <script src="/js/jquery.webui-popover.min.js"></script>
<script>
    $(function () {
        $('#deliverTable').bootstrapTable({
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
            pageSize:3,//单页记录数
            pageList:[3,5,10],//分页步进值
            showRefresh:true,//刷新按钮
            showColumns:true,
            clickToSelect: true,//是否启用点击选中行
            toolbarAlign:'right',
            buttonsAlign:'right',//按钮对齐方式
            toolbar:'#toolbar',//指定工作栏
            maintainSelected:true,
            columns:[
                {
                    title:'序号',
                    align:'center',
                    formatter:function (value,row,index) {
                        //return index + 1;
                        var pageSize=$('#deliverTable').bootstrapTable('getOptions').pageSize;//通过表的#id 可以得到每页多少条
                        var pageNumber=$('#deliverTable').bootstrapTable('getOptions').pageNumber;//通过表的#id 可以得到当前第几页
                        return pageSize * (pageNumber - 1) + index + 1;//返回每条的序号： 每页条数 * （当前页 - 1 ）+ 序号
                    }
                },
                {
                    title:'职位名',
                    field:'position.name',
                    align:'center',
                    sortable:true,
                    formatter:positionClick
                },
                {
                    title:'招聘人数',
                    align:'center',
                    sortable:true,
                    field:'position.recruitNum'
                },
                {
                    title:'工作经验',
                    align:'center',
                    sortable:true,
                    field:'position.experience'
                },
                {
                    title:'职位类型',
                    align:'center',
                    sortable:true,
                    field:'position.jobType.name'
                },
                {
                    title:'投递时间',
                    align:'center',
                    field:'createdTime',
                    sortable:true
                },
                {
                    title:'投递状态',
                    align:'center',
                    sortable:true,
                    field:'available',
                    formatter:function (value,row,index) {
                        if(row.available == 0){
                            return '<label class="label label-info">HR未查看</label>';
                        }else if(row.available == 1){
                            return '<label class="label label-primary">HR已查看</label>';
                        }else if(row.available == 2){
                            return '<lable class="label label-success">已通知面试</lable>';
                        }else if(row.available == 3){
                            return '<lable class="label label-warning">待沟通</lable>';
                        }else return '<lable class="label label-danger">已拒绝</lable>';
                    }
                },
                {
                    title:'操作',
                    align:'center',
                    events: operateEvents,
                    formatter:function (value,row,index) {
                        if(row.available == 2){
                            return [
                                '<button id="btn_view" class="btn btn-success">查看面试信息</button>'
                            ].join('');
                        }else if(row.available == 4){
                            return [
                                '<button id="btn_view" class="btn btn-danger">查看拒绝原因</button>'
                            ].join('');
                        }
                        return null;
                    }
                }
            ]
        });

        <#--<#if messageList?size != 0>-->
        <#--$.ajax({-->
            <#--url:'/deliver/collectDeliver',-->
            <#--type:'POST',-->
            <#--contentType:'application/x-www-form-urlencoded',-->
            <#--data:{deliverId:${deliverId}},-->
            <#--success:function(data){-->
                <#--if(data.code == 1){-->
                    <#--window.location.reload(true);-->
                <#--}-->
                <#--console.log(data.msg);-->
            <#--}-->
        <#--});-->
        <#--</#if>-->

    });

    //请求服务数据时所传参数
    function queryParams(params){
        return{
            pageSize: params.pageSize,
            pageNumber:params.pageNumber,
            sortName:params.sortName,
            sortOrder:params.sortOrder,
            resumeId:${Session.user.resumeInfo.id}
        }
    };
    
    function positionClick(value,row,index) {
        return '<a href="/position/positionDetail?positionId='+ row.position.id +'">'+ value +'</a>';
    }


    window.operateEvents = {

        "click #btn_view": function(e, value, row, index) {
            // $('#btn_view').webuiPopover({title:'Title',content:'Content',placement:'right',trigger:'hover'});
            if(row.available == 2){
                console.info(e);
                $(e.target).webuiPopover({
                    title:'面试信息',
                    content:'<ul class="list-group"><li class="list-group-item list-group-item-warning">面试时间：'+ row.interviewTime +'</li><li class="list-group-item list-group-item-warning">面试地点：'+ row.interviewAddr +'</li><li class="list-group-item list-group-item-warning">联系人：'+ row.contactName +'</li><li class="list-group-item list-group-item-warning">联系方式：'+ row.contactPhone +'</li></ul>',
                    placement:'right',
                    trigger:'hover',
                    style:'inverse',
                    animation:'pop',
                    closeable:true
                });
            }else if(row.available == 4){
                // console.info(e);
                var reason = row.reason.split(','),content = '<ul class="list-group"></ul>';
                $.each(reason,function (i,val) {
                    content = $(content).append('<li class="list-group-item list-group-item-danger">'+ val +'</li>');
                });
                $(e.target).webuiPopover({
                    title:'拒绝原因',
                    content:$(content),
                    placement:'right',
                    trigger:'hover',
                    style:'inverse',
                    animation:'pop',
                    closeable:true
                });
            }
            $(e.target).webuiPopover('toggle');
        }
    };
</script>
</body>
</html>