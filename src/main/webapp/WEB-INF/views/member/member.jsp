<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="utf-8">

    <link rel="stylesheet" href="<c:url value="/static/css/bootstrap.min.css" />">
    <link rel="stylesheet" href="<c:url value="/static/css/alert.css" />">
    <link rel="stylesheet" href="<c:url value="/static/css/common.css" />">

<title>${nickname}_个人中心</title>

    <style>
        *{margin: 0;padding: 0;}
        body{background-color: white;background-image: none}
        header{
            width: 100%;
            height: 50px;
            background-color: #e67777;
            opacity: 0.9;
            padding-left: 20px;
            padding-right: 20px;
            box-shadow: 0 0 5px #e67777;
        }
        #standingbyme{
            float: left;
            line-height: 50px;
            color: white;
        }
        #logout{
            float: right;
            line-height: 50px;
            color: white;
        }

        .main{position: relative}
        .content{
            width: 900px;
            height: 700px;
            border-radius: 4px;
            border: 1px solid #cdcdcd;
            box-shadow: 0 0 5px #cdcdcd;
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            top: 50px;
            margin-bottom: 100px;
        }

        .nav{
            width: 160px;
            height: 100%;
            border-right: 1px solid #cdcdcd;
        }
        .account{
            width: 100%;
            height: 50px;
            border-bottom: 1px solid #cdcdcd;
        }
        .account p{
            color: #7f7f7f;
            line-height: 50px;
            text-align: center;
        }

        .navigation ul li{
            width: 100%;
            height: 40px;
            color: #3c3c3c;
            list-style: none;
            text-align: center;
            line-height: 40px;
            font-size: 1.1em;
        }
        .navigation ul li a{
            width: 100%;
            height: 100%;
            display: block;
            text-decoration: none;
            color: #3c3c3c;
            transition: color 0.7s ease,background-color 0.7s ease;
        }
        .navigation ul li a:hover{
            background-color: #e67777;
            color: white;
        }
        .active{
            background-color: #e67777;
            color: white!important;
        }

        .account-content{
            width: 740px;
            height: 100%;
            position: absolute;
            top: 0;
            left: 160px;
        }
        iframe{
            width: 100%;
            height: 100%;
            overflow-y: auto;
        }
    </style>

</head>

<body>

<header>
    <a href="<c:url value="/member/welcome" />"><p id="standingbyme">一起同过窗</p></a>
    <a href="<c:url value="/logout" />"><p id="logout">退出账号</p></a>
</header>

<div class="main container">
    <div class="content">
        <div class="nav">
            <div class="account">
                <p>个人中心</p>
            </div>
            <div class="navigation">
                <ul>
                    <li><a href="javascript:void(0)" id="myInfo" onclick="switching(this)" class="active">我的信息</a></li>
                    <li><a href="javascript:void(0)" id="myAvatar" onclick="switching(this)">我的头像</a></li>
                    <li><a href="javascript:void(0)" id="confirmPassword" onclick="switching(this)">修改密码</a></li>
                </ul>
            </div>
        </div>
        <div class="account-content">
            <iframe src="<c:url value="/member/baseInfo" />" frameborder="0"></iframe>
        </div>
    </div>
</div>

<script src="<c:url value="/static/js/jquery-3.2.1.js" />"></script>
<script src="<c:url value="/static/js/bootstrap.min.js" />"></script>
<script src="<c:url value="/static/js/alert.js" />"></script>
<script src="<c:url value="/static/js/common.js" />"></script>

<script>

    <%--左边导航切换--%>
    function switching(e) {
        var id = $(e).attr("id");
        $(".navigation a").removeClass("active");
        $(e).addClass("active");

        if(id === "myInfo"){
            $("iframe").attr("src","<c:url value='/member/baseInfo' />");
        }
        else if(id === "myAvatar"){
            $("iframe").attr("src","<c:url value='/member/avatar' />");
        }
        else if(id === "confirmPassword"){
            $("iframe").attr("src","<c:url value='/member/modifyPwd' />");
        }
    }

</script>

</body>
</html>
