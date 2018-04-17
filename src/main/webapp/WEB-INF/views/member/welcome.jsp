<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>欢迎！_一起同过窗</title>

    <link rel="stylesheet" href="<c:url value="/static/css/bootstrap.min.css" />">

    <style>
        * {
            margin: 0;
            padding: 0;
        }

        body {
            background-image: url("<c:url value="/static/images/welcome_background.png" />");
            background-repeat: no-repeat;
            background-size: 100% 100% cover;
        }

        /*头部信息*/
        header {
            width: 100%;
            height: 50px;
        }

        #logo {
            width: 50px;
            height: 50px;
            margin-left: 10px;
            float: left;
        }

        h3 {
            margin: 0;
            margin-left: 10px;
            display: block;
            height: 50px;
            color: white;
            opacity: 0.95;
            float: left;
            line-height: 50px;
        }

        /*头像*/
        .avatar {
            margin-top: 120px;
            position: relative;;
        }

        #avatar {
            width: 150px;
            height: 150px;
            border-radius: 200px;
            position: absolute;
            left: 50%;
            margin-left: -75px;
            top: 50%;
            margin-top: -75px;
        }

        #account-number {
            margin-left: 65%;
        }

        h1 {
            margin-top: 0;
            margin-bottom: 20px;
            color: white;
            opacity: 0.95;
        }

        h4 {
            margin-bottom: 20px;
            color: white;
            opacity: 0.5;
        }

        /*屏幕宽度小于600px*/
        @media screen and (max-width: 600px) {
            #avatar {
                left: 20%;
            }

            #account-number {
                margin-left: 40%;
            }
        }

        /*屏幕宽度大于1200px*/
        @media screen and (min-width: 1200px) {
            #account-number {
                margin-left: 60%;
            }
        }

        #icon {
            margin-top: 80px;
        }

        .icon {
            width: 80px;
            height: 80px;
            float: left;
            padding-top: 15px;
            padding-left: 15px;
            background-color: white;
            border-radius: 500px;
        }

        #book, #moment, #user2 {
            width: 50px;
            height: 50px;
        }

        .book {
            position: absolute;
            left: 30%;
        }

        .moment {
            position: absolute;
            left: 50%;
            margin-left: -40px;
        }

        .user2 {
            position: absolute;
            right: 30%;
        }

        .my {
            float: left;
            margin-top: 90px;
        }

        p {
            color: white;
            font-family: "Helvetica Neue", "Helvetica", "Arial", "sans-serif";
            font-size: 1.4em;
            font-weight: 400;
        }

        .mybook {
            left: 29.5%;
        }

        /*屏幕宽度小于1200px*/
        @media screen and (max-width: 1200px) {
            .book {
                left: 15%;
            }

            .user2 {
                right: 15%;
            }

            .mybook {
                left: 14.5%;
            }
        }

        /*屏幕宽度小于900px*/
        @media screen and (max-width: 900px) {
            .book {
                left: 20%;
            }

            .user2 {
                right: 20%;
            }

            .mybook {
                left: 19.3%;
            }
        }

        /*屏幕宽度小于600px*/
        @media screen and (max-width: 600px) {
            .book {
                left: 6%;
            }

            .user2 {
                right: 6%;
            }

            .mybook {
                left: 4.5%;
            }
        }

    </style>

</head>

<body>

<header>
    <a href="<c:url value="" />"><img src="<c:url value="/static/images/logo1.png" />" alt="LOGO" id="logo"></a>
    <a href="<c:url value="" />"><h3>一起同过窗</h3></a>
</header>

<div class="container">
    <div class="avatar">
        <a href="#"><img src="<c:url value="/static/images/avatar.png" />" alt="avatar"
                         class="img-responsive center-block" id="avatar"></a>

        <div class="" id="account-number">
            <h1 id="member_nickname">&nbsp;</h1>
            <h4 id="member_username">&nbsp;</h4>
            <h4 id="member_fans">&nbsp;</h4>
            <h4 id="member_attentions">&nbsp;</h4>
        </div>
    </div>
    <div class="container" id="icon">
        <div class="icon book">
            <a href="<c:url value="/classmate/myclassmates" />"><img src="<c:url value="/static/images/book.png" />" alt="icon" class="img-responsive"
                             id="book"></a>
        </div>
        <div class="icon moment">
            <a href="#"><img src="<c:url value="/static/images/moment.png" />" alt="icon" class="img-responsive"
                             id="moment"></a>
        </div>
        <div class="icon user2">
            <a href="#"><img src="<c:url value="/static/images/user2.png" />" alt="icon" class="img-responsive"
                             id="user2"></a>
        </div>
    </div>
    <div class="container" id="my">
        <a href="<c:url value="/classmate/myclassmates" />"><p class="my book mybook">我的同学录</p></a>
        <a href="#"><p class="my moment mymoment">青春瞬间</p></a>
        <a href="#"><p class="my user2 myuser2">个人中心</p></a>
    </div>
</div>


<script src="<c:url value="/static/js/jquery-3.2.1.js" />"></script>
<script src="<c:url value="/static/js/bootstrap.min.js" />"></script>
<script>
    $(function () {
        $.ajax({
            type: 'POST',
            url: '<c:url value="/member/welcome" />',
			dataType:'json',
            success: function (data) {
                var username=data.extend.member.phone;
                if(username===null||username===''){
                    username=data.extend.member.email;
                }
                var nickname=data.extend.member.nickname;
                if(nickname===null||nickname===''){
                    nickname=username;
                }
                var avatar=data.extend.member.avatar;
                if(avatar!==null&&avatar!==''){
                    $("#avatar").attr("src",avatar);
                }

                $("#member_nickname").html(nickname);
                $("#member_username").html(username);
                $("#member_fans").html(data.extend.fans+" 关注者");
                $("#member_attentions").html(data.extend.attentions+" 关注的人");
            }
        });
    });
</script>

</body>
</html>
