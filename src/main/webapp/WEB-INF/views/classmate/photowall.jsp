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
            <div class="mousedown"><span class="glyphicon glyphicon-menu-down" id="mousedown"></span>
            </div>
        </a>
    </div>

    <div class="container operation-wrapper">
        <div class="row">
            <div class="col-sm-10 col-xs-8 operation"><h3><a href="#">邀请同学填写</a></h3></div>
            <div class="col-sm-2 col-xs-2" id="invite">
                <a href="#"><img src="<c:url value="/static/images/invite.png" />" alt="邀请" class="icon"></a>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-10 col-xs-8 operation"><h3><a href="#">编辑</a></h3></div>
            <div class="col-sm-2 col-xs-2" id="edit">
                <a href="#"><img src="<c:url value="/static/images/edit.png" />" alt="编辑" class="icon"></a>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-10 col-xs-8 operation"><h3><a href="#">删除</a></h3></div>
            <div class="col-sm-2 col-xs-2" id="delete">
                <a href="#"><img src="<c:url value="/static/images/delete.png" />" alt="删除" class="icon"></a>
            </div>
        </div>
    </div>
</div>
<div class="photo-wall-wrapper container-fluid" id="photo-wall-wrapper">
    <div class="col-sm-offset-2 col-xs-offset-2">
        <a href="javascript:void (0)"><h3 id="add-new-photo"><u>＋添加新的照片</u></h3></a>
    </div>
    <div class="photo-cntent container-fluid">
        <!--<div class="col-sm-7 photo-wrapper" id="photo1">-->
            <!--<a href="javascript:void (0)">-->
                <!--<div class="myphoto" style="background-image: url('../../../../static/images/1.jpg')">-->
                    <!--<div class="photo-color" id="photo-color1"></div>-->
                <!--</div>-->
            <!--</a>-->
        <!--</div>-->
        <div class="show-wrapper hidden">
            <img src="<c:url value="/static/images/close.png" />" alt="close" class="close" id="photo-close">
            <img src="" alt="" class="img-responsive" id="large-photo">
        </div>
    </div>
</div>

<script src="<c:url value="/static/js/jquery-3.2.1.js" />"></script>
<script src="<c:url value="/static/js/bootstrap.min.js" />"></script>
<script src="<c:url value="/static/js/common.js" />"></script>
<script src="<c:url value="/static/js/photowall.js" />"></script>

</body>
</html>