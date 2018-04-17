<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

    <title>我的同学录_一起同过窗</title>

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
            <a href="javascript:void(0)"><h3 id="create-myclassmate"><u>＋创建新的同学录</u></h3></a>
        </div>
    </div>
</div>
<%--创建同学录的模态框--%>
<div class="create-myclassmate-wrapper hidden">
    <div class="create-myclassmate-content">
        <div class="create-myclassmate-header">
            <img src="<c:url value="/static/images/close2.png" />" alt="close" class="close" id="create-myclassmate-close">
            <h3 class="create-myclassmate-title">创建新的同学录</h3>
        </div>
        <div class="create-myclassmate-body">
            <form class="form-horizontal" id="myclassmate-fm" autocomplete="off" onkeydown="if(event.keyCode===13){return false;}">
                <div class="form-group">
                    <label class="col-sm-3 control-label">同学录封面：</label>
                    <div class="col-sm-8" id="my-classmate-cover">
                        <input type="file" name="cover" class="input-upload" placeholder="" id="cover" accept="image/*" onchange="imgPreview(this)">
                        <a href="javascript:void(0);"><u>＋上传封面</u></a>
                    <img id="preview" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">同学录名称：</label>
                    <div class="col-sm-8">
                        <input type="text" name="name" class="form-control" placeholder="" id="classmatename">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">所属学校：</label>
                    <div class="col-sm-8">
                        <input type="text" name="school" class="form-control" placeholder="" id="school">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">所属班级：</label>
                    <div class="col-sm-8">
                        <input type="text" name="clazz" class="form-control" placeholder="" id="clazz">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">简单说明：</label>
                    <div class="col-sm-8">
                        <textarea type="text" name="description" class="form-control" placeholder="" id="description"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">个性定制：</label>
                </div>
                <div class="form-group create-btn">
                    <div class="col-sm-10 col-sm-offset-1">
                        <button class="btn" id="sure-create" type="button" onclick="createNewClassmate()">确&nbsp;&nbsp;认&nbsp;&nbsp;创&nbsp;&nbsp;建</button>
                    </div>
                </div>
            </form>
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