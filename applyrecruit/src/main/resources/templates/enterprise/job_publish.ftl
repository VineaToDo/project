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
            <div class="panel-heading"><h2 class="panel-title">发布新职位</h2></div>
            <div class="panel-body">
                <form action="/position/updatePostion" class="form-horizontal" role="form" method="post">
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
                        <label for="type" class="col-md-offset-2 col-md-2 control-label">职位类型</label>
                        <div class="col-md-5"><input type="text" class="form-control" id="type" placeholder="" name="type" value="<#if position??&& position.type??>${position.type}</#if>"></div>
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
                        <div class="col-md-5" id="salaryDiv"></div>
                    </div>
                    <div class="form-group">
                        <label for="property" class="col-md-offset-2 col-md-2 control-label">职位性质</label>
                        <div class="col-md-5">
                            <label class="radio-inline"><input type="radio" value="全职" name="property" checked>全职</label>
                            <label class="radio-inline"><input type="radio" value="兼职" name="property" <#if position?? && position.property?? && position.property == 0> checked</#if>>兼职</label>
                            <label class="radio-inline"><input type="radio" value="实习" name="property" <#if position?? && position.property?? && position.property == 0> checked</#if>>实习</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="degree" class="col-md-offset-2 col-md-2 control-label">学历要求</label>
                        <div class="col-md-5" id="degreeDiv"></div>
                    </div>
                    <div class="form-group">
                        <label for="recruitNum" class="col-md-offset-2 col-md-2 control-label">招聘人数</label>
                        <div class="col-md-5"><input type="number" class="form-control" id="recruitNum" placeholder="" name="recruitNum" value="<#if position??&& position.recruitNum??>${position.recruitNum}</#if>"></div>
                    </div>
                    <div class="form-group">
                        <label for="experience" class="col-md-offset-2 col-md-2 control-label">工作经验</label>
                        <div class="col-md-5"><select class="selectpicker" multiple data-max-options="1" id="experienceSelect" name="experience">
                            <option value="不限">不限</option>
                            <option value="接受应届毕业生">接受应届毕业生</option>
                            <option value="1-2年">1-2年</option>
                            <option value="3-5年">3-5年</option>
                            <option value="3-5年">3-5年</option>
                            <option value="6-7年">6-7年</option>
                            <option value="8年以上">8年以上</option>
                        </select></div>
                    </div>
                    <div class="form-group">
                        <label for="description" class="col-md-offset-2 col-md-2 control-label">职位描述</label>
                        <div class="col-md-5"><textarea class="form-control" name="description" rows="3"><#if position??>${position.description}</#if></textarea></div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-push-7 col-md-9">
                            <button type="submit" class="btn btn-primary">保存</button>
                            <a href="javascript:history.back()" class="btn btn-warning">取消</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>

    </section>


    <!-- FOOTER -->
    <footer data-stellar-background-ratio="0.5">
        <div class="container">
            <div class="row">
                <div class="col-md-5 col-sm-12">
                    <div class="footer-thumb footer-info">
                        <h2>Hydro Company</h2>
                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
                    </div>
                </div>

                <div class="col-md-2 col-sm-4">
                    <div class="footer-thumb">
                        <h2>Company</h2>
                        <ul class="footer-link">
                            <li><a href="#">About Us</a></li>
                            <li><a href="#">Join our team</a></li>
                            <li><a href="#">Read Blog</a></li>
                            <li><a href="#">Press</a></li>
                        </ul>
                    </div>
                </div>

                <div class="col-md-2 col-sm-4">
                    <div class="footer-thumb">
                        <h2>Services</h2>
                        <ul class="footer-link">
                            <li><a href="#">Pricing</a></li>
                            <li><a href="#">Documentation</a></li>
                            <li><a href="#">Support</a></li>
                        </ul>
                    </div>
                </div>

                <div class="col-md-3 col-sm-4">
                    <div class="footer-thumb">
                        <h2>Find us</h2>
                        <p>123 Grand Rama IX, <br> Krung Thep Maha Nakhon 10400</p>
                    </div>
                </div>

                <div class="col-md-12 col-sm-12">
                    <div class="footer-bottom">
                        <div class="col-md-6 col-sm-5">
                            <div class="copyright-text">
                                <p>Copyright &copy; 2017 Your Company</p>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-7">
                            <div class="phone-contact">
                                <p>Call us <span>(+66) 010-020-0340</span></p>
                            </div>
                            <ul class="social-icon">
                                <li><a href="https://www.facebook.com/templatemo" class="fa fa-facebook-square" attr="facebook icon"></a></li>
                                <li><a href="#" class="fa fa-twitter"></a></li>
                                <li><a href="#" class="fa fa-instagram"></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <script src="/js/custom.js"></script>

<script>
    $('#deptSelect').selectpicker({
        noneSelectedText : '请选择'//默认显示内容

    });
    $('#experienceSelect').selectpicker({
        noneSelectedText : '请选择'//默认显示内容
    });

    $.getJSON('/json/sql_areas.json',function(data){
        for (var i = 0; i < data.length; i++) {
            var area = {id:data[i].id,name:data[i].cname,level:data[i].level,parentId:data[i].upid};
            data[i] = area;
        }
        $('.bs-chinese-region').chineseRegion('source',data).on('completed.bs.chinese-region',function(e,areas){
            $(this).find('[name=workplace]').val(areas[areas.length-1].id);
        });
    });

    // $.ajaxSettings.async = false;
    $.getJSON('/json/edudegree.json',function (data) {
        var $div = $('#degreeDiv');
        initSelect($div,data,"degree");
        $('#degreeSelect').selectpicker({
            noneSelectedText : '请选择'//默认显示内容

        });
        <#if position?? && position.degree??>
            $('#degreeSelect').selectpicker('val',${position.degree});
        </#if>
        $('#degreeSelect').selectpicker('refresh');
    });
    $.getJSON('/json/salary.json',function (data) {
        var $div = $('#salaryDiv');
        initSelect($div,data,"salary");
        <#if position?? && position.salary??>
            $('#salarySelect').selectpicker('val',${position.salary});
        </#if>
        $('#salarySelect').selectpicker({
            noneSelectedText : '请选择'//默认显示内容

        });
        $('#salarySelect').selectpicker('refresh');
    });

    // $.ajaxSettings.async = true;
    function initSelect(parent,data,selectName) {
        var select = $("<select class='selectpicker' multiple data-max-options='1' id='" + selectName + "Select' name='" + selectName + "'></select>");
        for (var i = 0;i < data.length;i++){
            var option = $("<option value='"+ data[i].value +"'>" + data[i].name +"</option>");
            $(select).append(option).appendTo(parent);
        }
    }
</script>
</body>
</html>