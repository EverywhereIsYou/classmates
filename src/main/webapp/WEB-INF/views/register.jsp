<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>注册</title>

    <link rel="stylesheet" href="<c:url value="/static/css/bootstrap.min.css" />">
    <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/register.css" />">

</head>

<body>

<header>
    <div id="line"></div>
    <img src="<c:url value="/static/images/logo2.png" />" alt="图片" id="logo" class="img-responsive center-block">
</header>

<form class="form-horizontal" id="fm" autocomplete="off">

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
                <span class="input-group-btn">
                    <button class="btn" type="button" id="getDynamicCode" onclick="getDCode()">获取验证码</button>
                </span>
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
                    <img src="<c:url value="/codeService/graphicCode" />" id="verification">
                </div>
            </div>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-4 col-sm-push-4">
            <button class="btn" id="register"><span>立即注册</span></button>
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

<script src="<c:url value="/static/js/jquery-3.2.1.js" />"></script>
<script src="<c:url value="/static/js/bootstrap.min.js" />"></script>

<script>
    $("input").focus(function () {
        $(this).addClass("glowing");
    });
    $("input").blur(function () {
        $(this).removeClass("glowing");
    });

    $("footer a").focus(function () {
        $(this).css("text-decoration", "none");
        $(this).css("color", "#e67777");
    });

    $("form a").focus(function () {
        $(this).css("text-decoration", "none");
        $(this).css("color", "white");
    });

    $("#verification").click(function () {
        getVeriCode();
    });

    function getVeriCode() {
        var timeNow = new Date().getTime();
        $("#verification").attr("src", "<c:url value="/codeService/graphicCode?date=" />" + timeNow);
    }

    $("#register").click(function () {
        $("#register").attr("disabled",true);
        $("#register").text("正 在 进 行 注 册");
        getVeriCode();

        $.ajax({
            type: 'POST',
            url: "<c:url value="/register" />",
            data: $("#fm").serialize(),
            error: function (request) {
                // TODO 错误提示信息
                alert("register error");

                $("#register").attr("disabled",false);
                $("#register").text("立即注册");
            },
            success: function (data) {
                if(data.statusCode===200){
                    // TODO 注册成功之后的提示信息
                    alert("register successfully");

                    $("#register").text("立即注册");
                    $(location).attr("href","<c:url value="/login" />");
                }
                else {
                    // TODO 注册失败之后的提示信息
                    alert(data.msg);

                    $("#register").attr("disabled",false);
                    $("#register").text("立即注册");
                }
            }
        });
    });

    $("#back").click(function(){
        $(location).attr('href',"<c:url value="/login" />");
    });

    //获取动态验证码，并进入获取倒计时
    function getDCode() {
        setTime();

        var username=$("#username").val();
        $.ajax({
            type: 'POST',
            url: "<c:url value="/codeService/dynamicCode" />",
            data: {"username":username}
        });
    }
    var countDown=60;
    function setTime() {
        var get_code_btn=$("#getDynamicCode");

        if(countDown<=0){
            get_code_btn.attr("disabled",false);
            get_code_btn.text("获取验证码");
            countDown = 60;
        }
        else {
            get_code_btn.attr("disabled","disabled");
            get_code_btn.text("重新发送(" + countDown + "s)");
            countDown--;

            setTimeout(function () {
                setTime();
            },1000);
        }
    }
</script>

</body>

</html>
