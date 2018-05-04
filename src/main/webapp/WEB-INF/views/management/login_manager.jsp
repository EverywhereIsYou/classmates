<%--
  Created by IntelliJ IDEA.
  User: LP
  Date: 2018/5/2
  Time: 9:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>

    <link rel="stylesheet" href="<c:url value="/static/css/bootstrap.min.css" />">

    <title>登录_后台管理系统</title>

    <style>
        /*输入框右边按钮*/
        .input-group-addon {
            padding: 0 0;
            background-color: #7f7f7f;
            border: 0;
            height: 34px!important;
        }

        /*验证码图片*/
        #verification {
            width: 100px;
            height: 34px;
        }

        #login{
            width: 100%;
            margin-top: 30px;
            font-size: 1.3em;
        }
    </style>

</head>
<body>
<h1 class="text-center" style="margin-bottom: 50px">一起同过窗_后台管理系统</h1>

<div class="container">
    <form id="form_login_manager" action="<c:url value="/management/login" />" method="post" autocomplete="off" onkeydown="if(event.keyCode===13){return false;}">
        <div class="form-group col-sm-4 col-sm-offset-4">
            <label for="username" class="control-label">账号</label>
            <input type="text" class="form-control" id="username" name="workId" placeholder="账号" value="">
        </div>
        <div class="form-group col-sm-4 col-sm-offset-4">
            <label for="password" class="control-label">密码</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="密码" value="">
        </div>
        <div class="form-group col-sm-4 col-sm-offset-4">
            <label for="verification" class="control-label">验证码</label>
            <div class="input-group">
                <input type="text" class="form-control verification" id="graphicCode" name="graphicCode" placeholder="验证码" value="">
                <div class="input-group-addon">
                    <img src="<c:url value="/codeService/graphicCode" />" id="verification">
                </div>
            </div>
        </div>
        <div class="form-group col-sm-4 col-sm-offset-4 text-center">
            <button type="button" class="btn btn-primary" id="login">登&nbsp;&nbsp;&nbsp;&nbsp;录</button>
        </div>
    </form>
</div>

<script src="<c:url value="/static/js/jquery-3.2.1.js" />"></script>
<script src="<c:url value="/static/js/bootstrap.min.js" />"></script>

<script>
    $("#verification").click(function () {
        $("#verification").attr("src", "<c:url value="/codeService/graphicCode?date=" />" + new Date().getTime());
    });

    //回车触发登录
    $(document).keydown(function(event){
        if(event.keyCode===13){
            $("#login").trigger("click");
        }
    });

    $("#login").click(function () {
        $("#login").html("正&nbsp;&nbsp;在&nbsp;&nbsp;登&nbsp;&nbsp;录").attr("disabled",true);
        $("#form_login_manager").submit();
    });

    $(function () {
        var errorMsg="${errorMsg}";
        if(errorMsg!==undefined&&errorMsg!==null&&errorMsg!==''){
            alert(errorMsg);
        }
    });
</script>

</body>
</html>
