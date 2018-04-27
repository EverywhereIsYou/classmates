<%--
  Created by IntelliJ IDEA.
  User: li
  Date: 2018/4/19
  Time: 17:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>404_一起同过窗</title>

    <link rel="stylesheet" href="<c:url value="/static/css/bootstrap.min.css" />">

    <style>
        body {
            margin: 0;
            overflow: hidden;
            text-align: center;
            background-image: url("/static/images/404_bg.png");
            background-repeat: no-repeat;
            background-position-x: center;
        }

        .box {
            width: 400px;
            height: 400px;
            position: absolute;
            left: 50%;
            top: 50%;
            margin-left: -200px;
            margin-top: -200px;
            text-align: center;
        }
        a {
            width: 100%;
            height: 40px;
            background-color: #e67777;
            color: white;
            display: block;
            border-radius: 5px;
            text-align: center;
            font-size: 1.5em;
            line-height: 40px;
            font-weight: 500;
            box-shadow: 0 0 5px #e67777;
            position: absolute;
        }
        a:hover,a:focus{
            text-decoration: none;
            color: white;
        }
        #home{top: 50%}
        #welcome{top: 70%}
    </style>

</head>

<body>

<div class="box">
    <a href="<c:url value="/"/>" id="home">首&nbsp;&nbsp;&nbsp;&nbsp;页</a>
    <a href="<c:url value="/member/welcome"/>" id="welcome">返回个人中心</a>
</div>

<script src="<c:url value="/static/js/jquery-3.2.1.js" />"></script>
<script src="<c:url value="/static/js/404.js" />"></script>
<script src="<c:url value="/static/js/balloon.js" />"></script>

<script>

</script>

</body>
</html>

