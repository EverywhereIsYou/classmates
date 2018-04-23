<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

    <title>一起同过窗</title>

    <link rel="stylesheet" href="<c:url value="/static/css/bootstrap.min.css" />">

    <style>
        *{
            margin: 0;
            padding: 0;
        }

        body{
            background-image: url("/static/images/index_background.png");
            background-size: 100% 600px;
            background-repeat: no-repeat;
        }
        header{
            position: absolute;
            top: 0;
            width: 100%;
            height: 70px
        }
        #logo{
            width: 50px;
            height: 50px;
            margin-left: 10px;
            margin-top: 10px;
            float: left;
        }
        #standingbyme{
            margin: 10px 50px 0 10px;
            display: block;
            height: 50px;
            color: white;
            opacity: 0.95;
            float: left;
            line-height: 50px;
        }
        header ul{position: relative}
        header ul li{
            list-style: none;
        }
        header ul li a{
            display: block;
            float: left;
            width: 80px;
            height: 100%;
            color: white;
            font-size: 1.5em;
            line-height: 70px;
            text-align: center;
            text-decoration: none!important;
        }
        a:hover{color: white}
        a:focus{color: white}
        @keyframes run {
            from{margin-left: 0}
            to{margin-left: 80px}
        }
        @keyframes back {
            from{margin-left: 80px}
            to{margin-left: 0}
        }
        .show{
            width: 80px;
            height: 70px;
            position: absolute;
            background-color: #e67777;
            left: 240px;
            z-index: -100;
            margin-left: 0;
            margin-top: -10px;
            transition: margin-left 0.7s ease;
        }

        /*导航栏的登录注册*/
        #login-register{margin-right: 40px;}
        #login-register li a{
            color: white;
            float: right;
            margin-top: -10px;
        }
        #login-register li a:hover{
            background-color: #e67777;
            color: white;
            transition: background-color 0.5s ease;
        }

        /*轮播器*/
        #myCarousel{
            width: 100%;
            height: 600px;
            z-index: -100;
        }
        .carousel-inner{height: 600px}
        .item{height: 600px}
        .item img{
            width: 100%;
            height: 100%;
            position: absolute;
            bottom: 0;
        }
        .section1{
            width: 100%;
            background-color: white;
            box-shadow: 0 0 100px rgba(0,0,0,0.5);
            z-index: 100;
            padding-top: 100px;
            text-align: center;
        }
        .section1 h1{
            color: #e67777;
            margin-top: 0;
            text-align: center;
            line-height: 2em;
        }
        .section1 img{
            width: 100px;
            height: 100px;
        }
        .icon{text-align: center;}
        .section1 .icon p{font-size: 1.5em}
        .section1 h2{
            text-align: center;
            line-height: 1.2em;
            margin-top: 2em;
            margin-bottom: 2em;
        }
        .section1 h4{text-align: center;}
        .section1 h4 a{
            font-size: 1.3em;
            text-decoration: none;
            color: #e67777;
        }
        .section1 h4 a:hover{color: #e67777}
        .section1 h4 a:focus{text-decoration: none}
        .section1 button{
            width: 400px;
            color: white;
            font-family: "Helvetica Neue", "Helvetica", "Arial", "sans-serif";
            font-size: 1.3em;
            font-weight: 700;
            background: linear-gradient(to right, #5f4d93, #e67777);
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#5f4d93', endColorstr='#e67777', GradientType=1); /*IE9*/
            border: 0;
            -moz-box-shadow: 0 0 5px #c16b7f;
            -webkit-box-shadow: 0 0 5px #c16b7f;
            box-shadow: 0 0 5px #c16b7f;
        }
        .section1 button:hover{color: white}

        .liner{
            width: 80%;
            height: 1px;
            position: absolute;
            left: 50%;
            margin-left: -40%;
            background: linear-gradient(to right, #5f4d93, #e67777);
            background: -moz-linear-gradient(to right, #5f4d93, #e67777);
            background: -o-linear-gradient(to right, #5f4d93, #e67777);
            background: -webkit-linear-gradient(to right, #5f4d93, #e67777);
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#5f4d93', endColorstr='#e67777', GradientType=1); /*IE9*/
        }
        /*注脚*/
        footer {
            text-align: center;
            margin: 0 auto;
            width: 100%;
            height: 150px;
            position: relative;
            padding-top: 100px;
            bottom: 0;
        }
        footer p {
            color: #3c3c3c;
            margin-bottom: 0;
            margin-top: 20px;
            opacity: 1;
        }
        footer a {
            color: #e67777;
            opacity: 0.8;
            text-decoration: none;
            border-bottom: 1px dashed #f0f0f0;
        }
        footer a:hover {
            color: #e67777;
            opacity: 1;
            text-decoration: none;
            border-bottom: 1px dashed #fff;
        }
        footer a:focus {
            color: #e67777;
            opacity: 1;
            text-decoration: none;
            border-bottom: 1px dashed #fff;
        }
    </style>
</head>
<body>

<header>
    <a href=""><img src="<c:url value="/static/images/logo1.png" />" id="logo" alt="LOGO"></a>
    <a href="#"><h3 id="standingbyme">一起同过窗</h3></a>
    <ul>
        <li><a href="#" id="a1">首页</a></li>
        <li><a href="javascript:void(0)" id="a2">下载</a></li>
    </ul>
    <div class="show"></div>
    <ul id="login-register">
        <li><a href="#">注册</a></li>
        <li><a href="#">登录</a></li>
    </ul>
</header>

<div id="myCarousel" class="carousel slide">
    <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0"
            class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
    </ol>
    <div class="carousel-inner">
        <div class="item active">
            <img src="<c:url value="/static/images/index_show_1.png" />" alt="第二张">
        </div>
        <div class="item">
            <img src="<c:url value="/static/images/index_show_1.png" />" alt="第二张">
        </div>
    </div>
</div>
<div class="section1" id="section1">
    <h1>我们的特色</h1>
    <div class="container-fluid">
        <div class="col-sm-5 col-xs-5 icon">
            <img src="<c:url value="/static/images/cloud.png" />" alt="">
            <p style="color: #7d568f">云端永久保存</p>
        </div>
        <div class="col-sm-2 col-xs-2 icon">
            <img src="<c:url value="/static/images/pen.png" />" alt="">
            <p style="color: #be6b87">随时随地填写</p>
        </div>
        <div class="col-sm-5 col-xs-5 icon">
            <img src="<c:url value="/static/images/airplane.png" />" alt="">
            <p style="color: #e67777">分享给好友</p>
        </div>
    </div>
    <h2>你的同学录<br>交给我们来保管</h2>
    <h4><a href=""><u>前往网页版</u></a></h4>
    <button class="btn">下载Android版</button>

    <footer>
        <div class="liner"></div>
        <p>Copyright © 2018 <a href="#">Standingbyme</a>. All Rights Reserved.</p>
    </footer>
</div>

<script src="<c:url value="/static/js/jquery-3.2.1.js" />"></script>
<script src="<c:url value="/static/js/bootstrap.min.js" />"></script>
<script>
    var a2 = $("#a2");
    var showDiv = $(".show");
    a2.mouseover(function () {
        showDiv.css("animation","run 0.7s ease").css("margin-left","80px");
    });
    a2.mouseout(function () {
        showDiv.css("animation","back 0.7s ease").css("margin-left","0");
    });
    a2.click(function () {
        $("html,body").animate({scrollTop: $("#section1").offset().top}, 1000);
    });

    $('#myCarousel').carousel({
        interval : 5000, //设置自动播放/5 秒
        pause : 'hover',//设置鼠标悬停时停止播放
        wrap : true      //设置循环播放
    });
</script>
</body>
</html>
