<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

    <title>我的同学录</title>

    <link rel="stylesheet" href="<c:url value="/static/css/bootstrap.min.css" />">
    <link rel="stylesheet" href="<c:url value="/static/css/myclassmate.css" />">
</head>

<body>

<!-- 菜单框 -->
<div class="menu-wrapper" id="menu-wrapper">
    <div class="menu-content" id="menu-content">
        <img src="<c:url value="/static/images/close.png" />" alt="close" class="close" id="close">
        <ul>
            <li id="menu-first"><a href="<c:url value='/member/welcome' />">首页</a></li>
            <li><a href="<c:url value='/classmate/myclassmates' />">我的同学录</a></li>
            <li><a href="#">青春瞬间</a></li>
            <li><a href="#">个人中心</a></li>
            <li><a href="<c:url value='/logout' />">退出账号</a></li>
        </ul>
    </div>
</div>
<div class="wrapper" id="wrapper">
    <a href="javascript:void(0)"><img src="<c:url value="/static/images/menu.png" />" alt="图片" id="menu"></a>
    <div class="container header">
        <h1>我的同学录</h1>
        <div id="liner"></div>
        <h3>那些带给你感动的，那些送给你温暖的，那些陪伴你青春的，那些能让你在寂静的夜里默默思念的任何事——都在这里。</h3>
        <a href="javascript:void(0)">
            <div class="mousedown"><span class="glyphicon glyphicon-menu-down" id="mousedown"></span>
            </div>
        </a>

        <div class="new-classmate" id="new-classmate">
            <a href="#"><h3><u>＋创建新的同学录</u></h3></a>
        </div>
    </div>

</div>
<div class="conatiner-fluid" id="classmate-wrapper">
    <div class="create" id="create0"></div>
</div>

<footer class="footer" id="footer">
    <p>Copyright © 2018 <a href="#">Standingbyme</a>. All Rights Reserved.</p>
</footer>

<script src="<c:url value="/static/js/jquery-3.2.1.js" />"></script>
<script src="<c:url value="/static/js/bootstrap.min.js" />"></script>
<script src="<c:url value="/static/js/myclassmate.js" />"></script>

</body>

</html>