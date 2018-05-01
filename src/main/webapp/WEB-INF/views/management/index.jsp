<%--suppress ALL --%>
<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>一起同过窗_后台管理系统</title>

    <link rel="stylesheet" href="<c:url value="/static/css/bootstrap.min.css" />">
    <link rel="stylesheet" href="<c:url value="/static/css/index.css" />">

</head>

<body>

<%--顶部导航栏--%>
<nav class="navbar navbar-inverse bdr-n z-ind">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="javascript:void(0)">一起同过窗_后台管理系统</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" id="username" data-toggle="dropdown" role="button"
                       aria-haspopup="true" aria-expanded="false">admin <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">修改密码</a></li>
                        <li onclick="logout()"><a href="#">退出</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<%--左边菜单栏--%>
<div class="menu" id="menu">
    <div class="panel-group" id="accordion">
        <div class="panel panel-default">
            <div class="panel-heading">
                <a href="#collapseOne" data-toggle="collapse"
                   data-parent="#accordion">
                    <h4 class="panel-title">
                        用户管理
                    </h4>
                </a>
            </div>
            <div id="collapseOne" class="panel-collapse collapse">
                <a href="javascript:void (0)" id="manager">
                    <div class="panel-body">
                        管理员
                    </div>
                </a>
                <a href="javascript:void (0)">
                    <div class="panel-body">
                        普通用户
                    </div>
                </a>
            </div>
        </div>
        <div class="panel panel-default">
            <div class="panel-heading">
                <a href="#collapseTwo" data-toggle="collapse"
                   data-parent="#accordion">
                    <h4 class="panel-title">
                        同学录管理
                    </h4>
                </a>
            </div>
            <div id="collapseTwo" class="panel-collapse collapse">
                <div class="panel-body">
                    这里是第二部分。
                </div>
            </div>
        </div>
        <div class="panel panel-default">
            <div class="panel-heading">
                <a href="#collapseThree" data-toggle="collapse"
                   data-parent="#accordion">
                    <h4 class="panel-title">
                        反馈消息
                    </h4>
                </a>
            </div>
            <div id="collapseThree" class="panel-collapse collapse">
                <div class="panel-body">
                    这里是第三部分。
                </div>
            </div>
        </div>
    </div>
</div>
<div class="content container-fluid">
    <%--主体内容--%>
    <iframe src="welcome_manager" frameborder="0"></iframe>
</div>

<script src="<c:url value="/static/js/jquery-3.2.1.js" />"></script>
<script src="<c:url value="/static/js/bootstrap.min.js" />"></script>

<script>
    $(function () {
        $(".content").css("height", $(window).height() - 50 + "px");
    });
    $(window).resize(function () {
        $(".content").css("height", $(window).height() - 50 + "px");
    });

    $("#manager").click(function () {
        $("iframe").attr("src", "manager");
    });
</script>

</body>
</html>
