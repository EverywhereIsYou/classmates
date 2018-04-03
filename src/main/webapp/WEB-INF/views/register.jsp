<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>注册</title>

    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/static/css/register.css">

</head>

<body>

<header>
    <div id="line"></div>
    <img src="/static/images/logo2.png" alt="图片" id="logo" class="img-responsive center-block">
</header>

<form class="form-horizontal" id="fm">

    <div class="form-group">
        <label class="col-sm-4 control-label">手机/邮箱：</label>
        <div class="col-sm-4">
            <input type="email" name="username" class="form-control" placeholder="" id="username">
        </div>
    </div>

    <div class="form-group">
        <label class="col-sm-4 control-label">收到的验证码：</label>
        <div class="col-sm-4">
            <div class="input-group">
                <input type="text" name="dynamicCode" class="form-control" placeholder="" id="dynamicCode">
                <div class="input-group-addon"><a href="#" id="getDynamicCode">获取验证码</a></div>
            </div>
        </div>
    </div>

    <div class="form-group">
        <label class="col-sm-4 control-label">密码：</label>
        <div class="col-sm-4">
            <input type="password" name="password" class="form-control" placeholder="" id="password">
        </div>
    </div>

    <div class="form-group">
        <label class="col-sm-4 control-label">确认密码：</label>
        <div class="col-sm-4">
            <input type="password" name="" class="form-control" placeholder="">
        </div>
    </div>

    <div class="form-group">
        <label class="col-sm-4 control-label">验证码：</label>
        <div class="col-sm-4">
            <div class="input-group">
                <input type="text" name="graphicCode" class="form-control" placeholder="" id="graphicCode">
                <div class="input-group-addon">
                    <img src="" id="verification">
                </div>
            </div>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-4 col-sm-push-4">
            <button class="btn" id="regist"><span>立即注册</span></button>
        </div>
    </div>

</form>

<div class="back">
    <div class="col-sm-4 col-sm-push-4">
        <button type="button" class="btn" id="back"><span>返回登录</span></button>
    </div>
</div>

<footer class="footer">
    <p>Copyright © 2018 <a href="#">Standingbyme</a>. All Rights Reserved.</p>
</footer>

<script src="/static/js/jquery-3.2.1.js"></script>
<script src="/static/js/bootstrap.min.js"></script>

<script src="/static/js/register.js"></script>

<script>
    $(function () {
        $("#verification").attr("src", "<c:url value="/codeService/graphicCode" />");
    });

    $("#verification").click(function () {
        var timeNow = new Date().getTime();
        $("#verification").attr("src", "<c:url value="/codeService/graphicCode?date=" />" + timeNow);
    });
</script>

</body>

</html>
