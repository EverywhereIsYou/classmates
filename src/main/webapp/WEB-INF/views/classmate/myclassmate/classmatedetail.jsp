<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1, user-scalable=no">

    <title>朝花夕拾</title>

    <link rel="stylesheet" href="<c:url value="/static/css/bootstrap.min.css" />">
    <link rel="stylesheet" href="<c:url value="/static/css/common.css" />">
    <link rel="stylesheet" href="<c:url value="/static/css/classmatedetail.css" />">

</head>
<body>

<!-- 菜单框 -->
<div class="menu-wrapper" id="menu-wrapper">
    <div class="menu-content" id="menu-content">
        <img src="<c:url value="/static/images/close.png" />" alt="close" class="close" id="close">
        <ul>
            <li id="menu-first"><a href="#">首页</a></li>
            <li><a href="#">我的同学录</a></li>
            <li><a href="#">青春瞬间</a></li>
            <li><a href="#">个人中心</a></li>
            <li><a href="#">退出账号</a></li>
        </ul>
    </div>
</div>

<div class="wrapper" id="wrapper">
    <a href="javascript:void(0)"><img src="<c:url value="/static/images/menu.png" />" alt="图片" id="menu"></a>
    <div class="container header">
        <!-- <h1>我的同学录</h1>
        <div id="liner"></div>
        <h3>如果你无法简洁的表达你的想法，那只说明你还不够了解它。
            -- 阿尔伯特·爱因斯坦</h3> -->
        <a href="javascript:void(0)">
            <div class="mousedown"><span class="glyphicon glyphicon-menu-down" id="mousedown"></span>
            </div>
        </a>
    </div>

    <div class="container operation-wrapper">
        <div class="row">
            <div class="col-sm-10 col-xs-10 operation"><h3><a href="#">邀请同学填写</a></h3></div>
            <div class="col-sm-2 col-xs-2" id="invite">
                <a href="#"><img src="<c:url value="/static/images/invite.png" />" alt="邀请" class="icon"></a>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-10 col-xs-10 operation"><h3><a href="#">编辑</a></h3></div>
            <div class="col-sm-2 col-xs-2" id="edit">
                <a href="#"><img src="<c:url value="/static/images/edit.png" />" alt="编辑" class="icon"></a>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-10 col-xs-10 operation"><h3><a href="#">删除</a></h3></div>
            <div class="col-sm-2 col-xs-2" id="delete">
                <a href="#"><img src="<c:url value="/static/images/delete.png" />" alt="删除" class="icon"></a>
            </div>
        </div>
    </div>
</div>

<div class="classmate-detail-wrapper" id="classmate-detail-wrapper">
    <div class="container">
        <div class="paper" id="paper">
            <div class="paper-header">
                <!--<a href="#"><img src="../../../../static/images/avatar.png" alt="头像" id="avatar" class="img-circle img-responsive avatar"></a>-->
                <!--<a href="javascript:void(0)"><h3>李四</h3></a>-->
                <!--<h6>填写于 2018年4月11日</h6>-->
                <a href="javascript:void(0)"><img src="<c:url value="/static/images/delete_2.png" />" alt="删除" id="delete2" data-toggle="tooltip" title="删除本页同学录"></a>
            </div>

            <div class="paper-content">
                <p id="name">姓名：</p>
                <p id="nickname">昵称：</p>
                <p id="sex">性别：</p>
                <p id="birthday">生日：</p>
                <p id="address">能收到信的地方：</p>
                <p id="phone">常用电话：</p>
                <p id="email">email：</p>
                <p id="qq">QQ：</p>
                <p id="wechat">微信：</p>
                <p id="fav-movie">最喜欢的电影：</p>
                <p id="fav-singer">最喜欢的歌手：</p>
                <p id="fav-book">最爱的书：</p>
                <p id="fav-travel-place">最想去的地方：</p>
                <p id="fav-thing-to-do">最想做的事情：</p>
                <p id="special-in-class">上课做过最奇葩的事情：</p>
                <p id="word-to-me">简单聊聊我吧：</p>

                <img id="photo" class="img-responsive" src="" alt="">
            </div>
            <a href="#"><div class="col-sm-3 col-xs-3 navigation" id="pre">上一页</div></a>
            <a href="#"><div class="col-sm-3 col-xs-3 navigation" id="photo-wall">照片墙</div></a>
            <a href="#"><div class="col-sm-3 col-xs-3 navigation" id="comment-wall">留言墙</div></a>
            <a href="#"><div class="col-sm-3 col-xs-3 navigation" id="next">下一页</div></a>
        </div>

    </div>

</div>




	<script src="<c:url value="/static/js/jquery-3.2.1.js" />"></script>
	<script src="<c:url value="/static/js/bootstrap.min.js" />"></script>
    <script src="<c:url value="/static/js/common.js" />"></script>
	<script src="<c:url value="/static/js/classmatedetail.js" />"></script>

</body>
</html>