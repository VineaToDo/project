<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>Title</title>
    <style>
    </style>

</head>
<body>


    <#include "header.ftl">

    <section class="outer_box">
        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title">编辑信息</h3>
            </div>
            <div class="panel-body">
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="phone" class="col-md-offset-2 col-md-2 control-label">手机</label>
                        <div class="col-md-5"><input type="text" class="form-control" id="phone" placeholder="请输入手机号" name="phone"></div>
                    </div>
                    <div class="form-group">
                        <label for="email" class="col-md-offset-2 col-md-2 control-label">邮箱</label>
                        <div class="col-md-5"><input type="email" class="form-control" id="email" placeholder="请输入邮箱" name="email"></div>
                    </div>
                    <div class="form-group">
                        <label for="name" class="col-md-offset-2 col-md-2 control-label">真实姓名</label>
                        <div class="col-md-5"><input type="text" class="form-control" id="email" placeholder="请输入真实姓名" name="name"></div>
                    </div>
                    <div class="form-group">
                        <label for="gender" class="col-md-offset-2 col-md-2 control-label">性别</label>
                        <div class="col-md-5">
                            <label class="radio--inline"><input type="radio" id="male" name="gender" checked>男</label>
                            <label class="radio--inline"><input type="radio" id="female" name="gender">女</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="city" class="col-md-offset-2 col-md-2 control-label">所在地</label>
                        <div class="col-md-5"><input type="text" class="form-control" id="city" placeholder="请输入所在地" name="city"></div>
                    </div>
                    <div class="form-group">
                        <label for="birthday" class="col-md-offset-2 col-md-2 control-label">出生日期</label>
                        <div class="col-md-5"><div class="input-group date" id="birthdaypicker">
                                <input type="text" class="form-control" id="birthday" name="birthday" readonly>
                                <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span><span class="input-group-addon"><i class="glyphicon glyphicon-remove"></i></span>
                        </div></div>
                    </div>
                    <div class="form-group">
                        <label for="workYear" class="col-md-offset-2 col-md-2 control-label">工作年份</label>
                        <div class="col-md-5"><div class="input-group date" id="workYearpicker">
                                <input type="text" class="form-control" id="workYear" name="workYear" readonly>
                                <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span><span class="input-group-addon"><i class="glyphicon glyphicon-remove"></i></span>
                        </div></div>
                    </div>
                    <div class="form-group">
                        <label for="politics" class="col-md-offset-2 col-md-2 control-label">政治面貌</label>
                        <div class="col-md-5">
                            <label class="radio--inline">
                                <input type="radio" id="politics1" name="politics" value="中共党员(含预备党员)" checked>中共党员(含预备党员)
                            </label>
                            <label class="radio--inline">
                                <input type="radio" id="politics2" name="politics">团员
                            </label>
                            <label class="radio--inline">
                                <input type="radio" id="politics3" name="politics">群众
                            </label>
                            <label class="radio--inline">
                                <input type="radio" id="politics4" name="politics">民主党派
                            </label>
                            <label class="radio--inline">
                                <input type="radio" id="politics5" name="politics">其他
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="marital" class="col-md-offset-2 col-md-2 control-label">婚姻状况</label>
                        <div class="col-md-5">
                            <label class="radio--inline">
                                <input type="radio" id="marital1" name="marital" checked>未婚
                            </label>
                            <label class="radio--inline">
                                <input type="radio" id="marital2" name="marital">已婚
                            </label>
                            <label class="radio--inline">
                                <input type="radio" id="marital3" name="marital">离异
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-push-7 col-md-9">
                            <button type="submit" class="btn btn-primary">保存</button>
                            <a href="javascript:history.back()" class="btn btn-warning">取消</a>
                        </div>
                    </div>
                </form>
                <form class="form-horizontal hidden" role="form">
                    <div class="form-group">
                        <label for="phone" class="col-md-offset-2 col-md-2 control-label">学校名称</label>
                        <div class="col-md-5"><input type="text" class="form-control" id="school" placeholder="" name="school"></div>
                    </div>
                    <div class="form-group">
                        <label for="major" class="col-md-offset-2 col-md-2 control-label">专业名称</label>
                        <div class="col-md-5"><input type="text" class="form-control" id="major" placeholder="请输入邮箱" name="major"></div>
                    </div>
                    <div class="form-group">
                        <label for="single" class="col-md-offset-2 col-md-2 control-label">是否统招</label>
                        <div class="col-md-5">
                            <label class="radio--inline"><input type="radio" id="yes" name="single" checked>是</label>
                            <label class="radio--inline"><input type="radio" id="no" name="single">否</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-offset-2 col-md-2 control-label">就读时间</label>
                        <div class="col-md-6" style="font-size: 8px" id="studyTime"><div class="input-group"><div class="input-group date" id="beginDatepicker">
                            <input type="text" class="form-control" id="beginDateInput" name="beginDate" readonly>
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span><span class="input-group-addon"><i class="glyphicon glyphicon-remove"></i></span>
                        </div><label class="input-group-addon" style="background-color: #ffffff;border: none;width: 20px">至</label>
                        <div class="input-group date" id="endDatepicker">
                            <input type="text" class="form-control" id="endDateInput" name="endDate" readonly>
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span><span class="input-group-addon"><i class="glyphicon glyphicon-remove"></i></span>
                        </div></div></div>
                    </div>
                    <div class="form-group">
                        <label for="degree" class="col-md-offset-2 col-md-2 control-label">学历</label>
                        <div class="col-md-5"><select class="selectpicker" id="degreeSelect"  name="degree">
                            <#list eduEnum as enum>
                                <option value="${enum.code}" <#if education?? && education.degree == enum.code>selected</#if>>${enum.message}</option>
                            </#list>
                        </select></div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-push-7 col-md-9">
                            <button type="submit" class="btn btn-primary">保存</button>
                            <a href="javascript:history.back()" class="btn btn-warning">取消</a>
                        </div>
                    </div>
                </form>

            </div>
            <#--<h1>教育背景</h1>-->
            <#--<form action="/resume/addEducation" method="post">-->
            <#--&lt;#&ndash;<input type="hidden" name="id" value="${resumid}">&ndash;&gt;-->
                <#--<#if education??>-->
                    <#--<label>时间:</label>-->
                    <#--<input type="hidden" name="id" value="${id}">-->
                    <#--<input type="month" name="beginDate" value="${education.beginDate?string("yyyy-MM")}">至-->
                    <#--<input type="month" name="endDate" value="${education.endDate?string("yyyy-MM")}"><br>-->
                    <#--<label>学校:</label>-->
                    <#--<input type="text" name="school" value="${education.school}"><br>-->
                    <#--<label>学历</label>-->
                    <#--<select name="degree">-->
                        <#--<#list eduEnum as enum>-->
                            <#--<option value="${enum.code}" <#if education.degree == enum.code>selected</#if>>${enum.message}</option>-->
                        <#--</#list>-->
                    <#--</select>-->
                <#--<#else >-->
                    <#--<label>时间:</label>-->
                    <#--<input type="month" name="beginDate">至-->
                    <#--<input type="month" name="endDate"><br>-->
                    <#--<label>学校:</label>-->
                    <#--<input type="text" name="school"><br>-->
                    <#--<label>学历</label>-->
                    <#--<select name="degree">-->
                        <#--<#list eduEnum as enum>-->
                            <#--<option value="${enum.code}">${enum.message}</option>-->
                        <#--</#list>-->
                    <#--</select>-->
                <#--</#if>-->
                <#--<br>-->
                <#--<input type="submit" value="确认">-->
            <#--</form>-->
        </div>
    </section>
<#--<script src="/bootstrap/bootstrap-datetimepicker.min.js"></script>-->
<#--<script src="/bootstrap/bootstrap-datetimepicker.zh-CN.js"></script>-->
<script>
    $('#birthdaypicker,#workYearpicker').datetimepicker({
        language: 'zh-CN',
        todayHighlight: true,
        // todayBtn: true.toSource
        format:'yyyy-mm-dd',
        weekStart: 0, /*以星期一为一星期开始*/
        autoclose: 1,
        minView:"month", /*精确到天*/
        pickerPosition: "bottom-left"
    }).on("changeDate",function (ev) {

    });

    $('#degreeSelect').selectpicker({
        noneSelectedText : '请选择'//默认显示内容
    });

    $('#beginDatepicker').datetimepicker({
        language:  'zh-CN',
        format:'yyyy-mm-dd',
        weekStart: 0, /*以星期一为一星期开始*/
        todayBtn:  1,
        autoclose: 1,
        minView:2, /*精确到天*/
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
        minView:2, /*精确到天*/
        pickerPosition: "bottom-left"
    }).on("changeDate",function(ev){
        //选择的日期不能小于第一个日期控件的日期
        if(ev.date){
            $("#beginDatepicker").datetimepicker('setEndDate', new Date(ev.date.valueOf()));
        }else{
            $("#beginDatepicker").datetimepicker('setEndDate',new Date());
        }
    });



</script>

</body>
</html>