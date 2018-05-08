<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>

    <link rel="stylesheet" type="text/css" href="/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/bootstrap/bootstrap-table.css">

</head>
<body>
    <div id="test"></div>
    <div class="container">
        <table id="table"></table>
    </div>

    <script src="/js/jquery.min.js"></script>
    <script src="/bootstrap/bootstrap.min.js"></script>
    <script src="/bootstrap/bootstrap-table.js"></script>
    <script src="/bootstrap/bootstrap-table-zh-CN.js"></script>

<script>


        $('#table').bootstrapTable({
            url:"/json/salary.json",
            columns: [{
                field: 'id',
                title: 'Item ID'
            }, {
                field: 'name',
                title: 'Item Name'
            }, {
                field: 'price',
                title: 'Item Price'
            }],
            data: [{
                id: 1,
                name: 'Item 1',
                price: '$1'
            }, {
                id: 2,
                name: 'Item 2',
                price: '$2'
            }]
        })

    <#--$.getJSON('/json/gender.json',function (data) {-->
        <#--var $test = $('#test');-->
        <#--test($test,data);-->
        <#--$("input[name=gender][value=${id}]").attr("checked",true);-->
    <#--});-->
    <#--function test(parent,data) {-->
        <#--for (var i = 0;i < data.length;i++) {-->
            <#--var labelInput = $("<label></label>");-->
            <#--var radioInput = $("<input type='radio' name='gender'>");-->
            <#--radioInput.attr('value',data[i].value);-->
            <#--$(labelInput).append(radioInput).append(data[i].name).appendTo(parent);-->
        <#--}-->
    <#--}-->


</script>
</body>
</html>