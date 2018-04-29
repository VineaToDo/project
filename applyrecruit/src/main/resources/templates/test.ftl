<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="/js/jquery.min.js"></script>
</head>
<body>
    <div id="test"></div>
<script>
    $.getJSON('/json/gender.json',function (data) {
        var $test = $('#test');
        test($test,data);
        $("input[name=gender][value=${id}]").attr("checked",true);
    });
    function test(parent,data) {
        for (var i = 0;i < data.length;i++) {
            var labelInput = $("<label></label>");
            var radioInput = $("<input type='radio' name='gender'>");
            radioInput.attr('value',data[i].value);
            $(labelInput).append(radioInput).append(data[i].name).appendTo(parent);
        }
    }


</script>
</body>
</html>