<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <title>职位编辑</title>
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
                    <li><a href="#">首页</a></li>
                    <li>职位管理</li><li class="active">发布新职位</li>
                </ol></h2>
            </div>
            <div class="panel-body">
                <form id="editForm" action="/position/updatePostion" class="form-horizontal" role="form" method="post">
                    <div class="form-group">
                        <label for="deptSelect" class="col-md-offset-2 col-md-2 control-label">所属部门</label>
                        <div class="col-md-5"><select class="selectpicker" multiple data-max-options="1" id="deptSelect" name="deptId">
                            <#if deptList??>
                                <#list deptList as dept>
                                <option value="${dept.id}">${dept.name}</option>
                                </#list>
                            </#if>
                        </select></div>
                    </div>
                    <div class="form-group">
                        <label for="name" class="col-md-offset-2 col-md-2 control-label">职位名称</label>
                        <div class="col-md-5"><input type="text" class="form-control" id="name" placeholder="" name="name" value="<#if position??>${position.name}</#if>"></div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-offset-2 col-md-2 control-label" for="deadlinepicker">截止时间</label>
                        <div class="col-md-3">
                            <div class="input-group date" id="deadlinepicker">
                                <input type="text" class="form-control" id="deadlineInput" name="deadline" value="<#if position??>${position.deadline?string("yyyy-MM-dd")}</#if>" readonly>
                                <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span><span class="input-group-addon"><i class="glyphicon glyphicon-remove"></i></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="type" class="col-md-offset-2 col-md-2 control-label">职位类型</label>
                        <div class="col-md-5">
                            <select class="selectpicker" multiple data-max-options="1" id="typeSelect" name="type">
                                <#if jobTypes??><#list jobTypes as jobType>
                                        <optgroup label="${jobType.name}">
                                            <#if jobType.childrens??><#list jobType.childrens as child>
                                                    <option data-content="<span class='label label-danger'>${child.name}</span>" value="${child.id}"></option>
                                            </#list></#if>
                                        </optgroup>
                                </#list></#if>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="workplace" class="col-md-offset-2 col-md-2 control-label">工作地点</label>
                        <div class="col-md-5">
                            <div class="bs-chinese-region flat dropdown" data-min-level="1" data-max-level="3" data-def-val="[name=workplace]">
                                <input type="text" class="form-control" id="workplace" placeholder="请选择所在地" data-toggle="dropdown" readonly="">
                                <input type="hidden" class="form-control" name="workplace" <#if position?? && position.workplace??>value="${position.workplace}" </#if>>
                                <div class="dropdown-menu" role="menu" aria-labelledby="dLabel">
                                    <div>
                                        <ul class="nav nav-tabs" role="tablist">
                                            <li role="presentation" class="active"><a href="#province" data-next="city" role="tab" data-toggle="tab">省份</a></li>
                                            <li role="presentation"><a href="#city" data-next="district" role="tab" data-toggle="tab">城市</a></li>
                                            <li role="presentation"><a href="#district" data-next="street" role="tab" data-toggle="tab">县区</a></li>
                                        </ul>
                                        <div class="tab-content">
                                            <div role="tabpanel" class="tab-pane active" id="province">--</div>
                                            <div role="tabpanel" class="tab-pane" id="city">--</div>
                                            <div role="tabpanel" class="tab-pane" id="district">--</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="single" class="col-md-offset-2 col-md-2 control-label">薪资待遇</label>
                        <div class="col-md-5" id="salaryDiv">
                            <select class="selectpicker" multiple data-max-options='1' id='salarySelect' name='salary'>
                            <#list salaryDict?values as salaryOpt>
                                <option value="${salaryOpt.code}">${salaryOpt.value}</option>
                            </#list>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="property" class="col-md-offset-2 col-md-2 control-label">职位性质</label>
                        <div class="col-md-5">
                            <label class="radio-inline"><input type="radio" value="全职" name="property" checked>全职</label>
                            <label class="radio-inline"><input type="radio" value="兼职" name="property" <#if position?? && position.property?? && position.property == "兼职"> checked</#if>>兼职</label>
                            <label class="radio-inline"><input type="radio" value="实习" name="property" <#if position?? && position.property?? && position.property == "实习"> checked</#if>>实习</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="degree" class="col-md-offset-2 col-md-2 control-label">学历要求</label>
                        <div class="col-md-5" id="degreeDiv">
                            <select class="selectpicker" multiple data-max-options='1' id='degreeSelect' name='degree'>
                                <#list eduDegreeDict?values as eduDegreeOpt>
                                    <option value="${eduDegreeOpt.code}">${eduDegreeOpt.value}</option>
                                </#list>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="recruitNum" class="col-md-offset-2 col-md-2 control-label">招聘人数</label>
                        <div class="col-md-2"><input type="number" class="form-control" id="recruitNum" placeholder="" name="recruitNum" value="<#if position??&& position.recruitNum??>${position.recruitNum}</#if>"></div>
                    </div>
                    <div class="form-group">
                        <label for="experience" class="col-md-offset-2 col-md-2 control-label">工作经验</label>
                        <div class="col-md-5"><select class="selectpicker" multiple data-max-options="1" id="experienceSelect" name="experience">
                            <option value="不限">不限</option>
                            <option value="接受应届毕业生">接受应届毕业生</option>
                            <option value="1-2年">1-2年</option>
                            <option value="3-5年">3-5年</option>
                            <option value="6-7年">6-7年</option>
                            <option value="8年以上">8年以上</option>
                        </select></div>
                    </div>
                    <div class="form-group">
                        <label for="description" class="col-md-offset-2 col-md-2 control-label">职位描述</label>
                        <div class="col-md-5"><textarea class="form-control" name="description" rows="3"><#if position??>${position.description}</#if></textarea></div>
                    </div>
                    <#if position??>
                        <input type="hidden" value="${position.id}" name="id">
                    </#if>

                    <div class="form-group">
                        <div class="col-md-push-7 col-md-9">
                            <button id="btn_publish" type="button" class="btn btn-success">立即发布</button>
                            <button id="btn_save" type="button" class="btn btn-primary">暂时保存</button>
                            <a href="javascript:history.back()" class="btn btn-warning">取消</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </section>
    <#include "../footer.ftl">
<script>
    $(function () {
        var $publish = $('#btn_publish'),$save = $('#btn_save');
        $('#deadlinepicker').datetimepicker({
            language:  'zh-CN',
            format:'yyyy-mm-dd',
            weekStart: 0, /*以星期一为一星期开始*/
            todayBtn:  1,
            autoclose: 1,
            startView: 'year',
            minView:'month', /*精确到日*/
            pickerPosition: "bottom-left"
        });
        $('#deadlinepicker').datetimepicker('setStartDate',new Date());

        $publish.click(function () {
            var data = $.param({"state":1}) + "&" + $('#editForm').serialize();
            ajaxSubmit(data);
        });

        $save.click(function () {
            var data = $('#editForm').serialize();
            ajaxSubmit(data);
        });

        $('#deptSelect,#experienceSelect,#typeSelect').selectpicker({
            noneSelectedText : '请选择'//默认显示内容
        });

        <#if position??>
        $('#deptSelect').selectpicker('val',${position.department.id});
        $('#typeSelect').selectpicker('val',${position.jobType.id});
        $('#salarySelect').selectpicker('val',${position.salary});
        $('#degreeSelect').selectpicker('val',${position.degree});
        $('#experienceSelect').selectpicker('val','${position.experience}');
        </#if>

        $.getJSON('/json/sql_areas.json',function(data){
            for (var i = 0; i < data.length; i++) {
                var area = {id:data[i].id,name:data[i].cname,level:data[i].level,parentId:data[i].upid};
                data[i] = area;
            }
            $('.bs-chinese-region').chineseRegion('source',data).on('completed.bs.chinese-region',function(e,areas){
                $(this).find('[name=workplace]').val(areas[areas.length-1].id);
            });
        });

    });

    function ajaxSubmit(data){
        $.ajax({
            url:'/position/updatePostion',
            data:data,
            type:'post',
            success:function (data) {
                if(data.code != -1){
                    toastr.success("将自动跳转到职位管理界面...",data.msg);
                    setTimeout(function () {
                        window.location.href = '/position/getPosition';
                    },2000);
                }else {
                    toastr.error("请稍后再试",data.msg);
                }
            }
        });
    }

</script>
</body>
</html>