<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1, user-scalable=no">

    <title></title>

    <link rel="stylesheet" href="<c:url value="/static/css/bootstrap.min.css" />">
    <link rel="stylesheet" href="<c:url value="/static/css/common.css" />">
    <link rel="stylesheet" href="<c:url value="/static/css/photowall.css" />">

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

<input id="classmateId" class="hidden" value="${classmateId}">

<div class="wrapper" id="wrapper">
    <a href="javascript:void(0)"><img src="<c:url value="/static/images/menu.png" />" alt="图片" id="menu"></a>
    <div class="container header">
        <h1 id="classmate-name">&nbsp;</h1>
        <h3 id="classmate-shcool">&nbsp;</h3>
        <div id="liner"></div>
        <h3 id="classmate-description">&nbsp;</h3>
        <a href="javascript:void(0)">
            <div class="mousedown">
                <span class="glyphicon glyphicon-menu-down" id="mousedown"></span>
            </div>
        </a>
    </div>
</div>

<div class="photo-wall-wrapper container-fluid" id="photo-wall-wrapper">
    <div class="col-sm-offset-2 col-xs-offset-2">
        <a href="javascript:void (0)"><h3 id="add-new-photo"><u>＋添加新的照片</u></h3></a>
    </div>
    <div class="show-wrapper hidden">
        <img src="<c:url value="/static/images/close.png" />" alt="close" class="close" id="photo-close">
        <img src="" alt="" class="img-responsive" id="large-photo">
    </div>
    <div class="photo-cntent container-fluid" id="photo-area"></div>
</div>

<div class="upload-photo-wrapper hidden">
    <div class="upload-photo-content">
        <div class="upload-photo-header">
            <img src="<c:url value="/static/images/close2.png" />" alt="close" class="close" id="upload-photo-close">
            <h3 class="upload-photo-title">添加新的照片</h3>
        </div>
        <button onclick="addImage()" id="addImageBtn" class="btn">添加照片</button>
        <div class="upload-photo-body" id="upload-photo-body"></div>
        <button type="button" class="btn" id="do-upload" onclick="uploadImages()">确 认 上 传</button>
    </div>
</div>

<script src="<c:url value="/static/js/jquery-3.2.1.js" />"></script>
<script src="<c:url value="/static/js/bootstrap.min.js" />"></script>
<script src="<c:url value="/static/js/common.js" />"></script>
<script src="<c:url value="/static/js/photowall.js" />"></script>

</body>
</html>