<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

    <title>登录</title>

    <link rel="stylesheet" href="<c:url value="/static/css/bootstrap.min.css" />">
    <link rel="stylesheet" href="<c:url value="/static/css/login.css" />">

</head>

<body>

<div class="main" id="main">
    <div class="wrapper">
        <header>
            <div id="line"></div>
            <a href="#">
                <img src="<c:url value="/static/images/logo2.png" />" alt="图片" id="logo" class="img-responsive center-block">
            </a>
        </header>

        <form class="form-horizontal" id="form_login" autocomplete="off">

            <div class="form-group">
                <div class="col-xs-10 col-xs-offset-1 text">
                    <input type="email" name="username" class="form-control" id="username" placeholder="手机/邮箱">
                </div>
            </div>

            <div class="form-group">
                <div class="col-xs-10 col-xs-offset-1 text">
                    <input type="password" name="password" class="form-control" id="password" placeholder="密码">
                </div>
            </div>

            <div class="form-group">
                <div class="col-xs-10 col-xs-offset-1 text">
                    <div class="input-group">
                        <input type="text" name="graphicCode" class="form-control verification" placeholder="验证码" id="graphicCode">
                        <div class="input-group-addon">
                            <img src="<c:url value="/codeService/graphicCode" />" id="verification">
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <div class="col-xs-10 col-xs-offset-1">
                    <button class="btn" id="login" type="button">登&nbsp;&nbsp;&nbsp;&nbsp;录</button>
                </div>
            </div>

            <div class="form-group">
                <div>
                    <a class="col-xs-3 col-xs-offset-1" id="p-one" href="<c:url value="/register" />">立即注册</a>
                    <a class="col-xs-3 col-xs-push-4" id="p-two" href="#">忘记密码</a>
                </div>
            </div>

            <div class="form-group">
                <div class="col-xs-6 col-xs-offset-3">
                    <button class="btn" id="download"><span class="glyphicon glyphicon-download-alt"></span>&nbsp;&nbsp;&nbsp;下载android版
                    </button>
                </div>
            </div>
        </form>

    </div>
</div>

<footer class="footer">
    <p>Copyright © 2018 <a href="#">Standingbyme</a>. All Rights Reserved.</p>
</footer>


<script src="<c:url value="/static/js/jquery-3.2.1.js" />"></script>
<script src="<c:url value="/static/js/bootstrap.min.js" />"></script>

<script>
    $(function () {
        $(".wrapper").addClass("wrapper-gif"); //页面加载完成后执行动画

        $("input").focus(function () {
            $(this).addClass("glowing");
        });
        $("input").blur(function () {
            $(this).removeClass("glowing");
        });
    });
    $("#verification").click(function () {
        getVeriCode();
    });
    function getVeriCode() {
        var timeNow = new Date().getTime();
        $("#verification").attr("src", "<c:url value="/codeService/graphicCode?date=" />" + timeNow);
    }

    $("#login").click(function () {
        $("#login").attr("disabled",true);
        $("#login").text("正 在 登 录");

        $.ajax({
            type: 'POST',
            url: "/login",
            data: $("#form_login").serialize(),
            error: function (request) {
                getVeriCode();

                // TODO 错误提示信息
                alert("login error");

                $("#login").attr("disabled",false);
                $("#login").html("登&nbsp;&nbsp;&nbsp;&nbsp;录");
            },
            success: function (data) {
                getVeriCode();

                if(data.statusCode===200){
                    $(location).attr("href","<c:url value="/member/welcome" />");
                    $("#login").html("登&nbsp;&nbsp;&nbsp;&nbsp;录");
                }
                else {
                    // TODO 登录失败信息显示
                    alert(data.msg);

                    $("#login").attr("disabled",false);
                    $("#login").html("登&nbsp;&nbsp;&nbsp;&nbsp;录");
                }
            }
        });
    });
    //回车绑定鼠标点击
    $("#form_login").keydown(function(e){
        var e = e || event,
            keycode = e.which || e.keyCode;
        if (keycode === 13) {
            $("#login").trigger("click");
        }
    });


</script>
</body>
</html>
