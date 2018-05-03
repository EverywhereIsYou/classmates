<%--suppress ALL --%>
<%--
  Created by IntelliJ IDEA.
  User: LP
  Date: 2018/4/19
  Time: 9:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1, user-scalable=no">

    <title></title>

    <link rel="stylesheet" href="<c:url value="/static/css/bootstrap.min.css" />">
    <link rel="stylesheet" href="<c:url value="/static/css/alert.css" />">

    <style>
        *{margin: 0;padding: 0;}
        body {
            height: 100%;
            background-image: url("<c:url value="/static/images/bg.jpg" />");
            background-repeat: no-repeat;
            background-size: 100% 100% cover;
            background-attachment: fixed;
        }
        /*logo*/
        header {
            width: 100%;
            height: 50px;
            position: fixed;
            float: top;
            z-index: 1;
        }
        #logo {
            width: 50px;
            height: 50px;
            margin-left: 10px;
            float: left;
        }
        #standingbyme{
            margin: 0;
            margin-left: 10px;
            display: block;
            height: 50px;
            color: white;
            opacity: 0.95;
            float: left;
            line-height: 50px;
        }

        .main{
            width: 100%;
            height: 100%;
            position: fixed;
            overflow-y: auto;
            background: linear-gradient(to left bottom, rgba(95,77,147,0.5), rgba(227,118,130,0.5));

            /*透视效果*/
            perspective: 1000;
            -moz-perspective: 1000;
            -o-perspective: 1000;
            -webkit-perspective: 1000; /* Safari 和 Chrome */
            perspective-origin: 50% 50%;
            -moz-perspective-origin: 50% 50%;
            -o-perspective-origin: 50% 50%;
            -webkit-perspective-origin: 50% 50%;
        }
        .wrapper {
            position: absolute;
            top: 70px;
            left: 50%;
            width: 500px;
            margin-left: -250px;
            margin-bottom: 100px;
            background-color: white;
            border-radius: 5px;
            cursor: default;
            opacity: 0;
            box-shadow: 0 0 10px #c16b7f;
            text-align: center;

            /*初始效果*/
            -o-transform-origin: 50% 50%; /*Opare*/
            -moz-transform-origin: 50% 50%; /*Firefox*/
            -webkit-transform-origin: 50% 50%; /*Safari和Chrome*/
            -ms-transform-origin: 50% 50%; /*IE9*/
            transform-origin: 50% 50%; /*标准*/
            -o-transform: rotateX(20deg);
            -moz-transform: rotateX(20deg);
            -webkit-transform: rotateX(20deg);
            -ms-transform: rotateX(20deg);
            transform: rotateX(20deg);
            -o-transition: opacity 1s ease, -o-transform 1s ease;
            -moz-transition: opacity 1s ease, -moz-transform 1s ease;
            -webkit-transition: opacity 1s ease, -webkit-transform 1s ease;
            -ms-transition: opacity 1s ease, -ms-transform 1s ease;
            transition: opacity 1s ease, transform 1s ease;
        }
        /*过渡到这个效果*/
        .wrapper-gif {
            opacity: 1;
            -o-transform: rotateX(0deg);
            -moz-transform: rotateX(0deg);
            -webkit-transform: rotateX(0deg);
            -ms-transform: rotateX(0deg);
            transform: rotateX(0deg);
        }
        h3,h4{color: #e67777}
        h5{
            color: #7f7f7f;
            margin-bottom: 20px;
        }
        #author{
            padding-right: 2em;
            opacity: 0.7;
        }
        input,textarea{
            margin-top: 20px;
            margin-bottom: 20px;
            resize:none;
        }
        textarea:focus,input:focus{
            border-color: #e67777!important;
            -moz-box-shadow: 0 0 10px #e67777!important;
            -webkit-box-shadow: 0 0 10px #e67777!important;
            box-shadow: 0 0 10px #e67777!important;
        }
        #sure-write{
            width: 100%;
            color: white;
            font-size: 1.2em;
            margin-top: 20px;
            background: linear-gradient(to right, #5f4d93, #e67777);
            border: 0;
            box-shadow: 0 0 10px #c16b7f;
        }

        /*页脚*/
        footer {
            text-align: center;
            position: absolute;
            margin: 0;
            width: 100%;
            bottom: 0;
        }

        footer p {
            color: white;
            opacity: 0.8;
        }

        footer a {
            color: #e67777;
            opacity: 0.8;
            text-decoration: none;
            border-bottom: 1px dashed #e67777;
        }

        footer a:hover {
            color: #e67777;
            opacity: 1;
            text-decoration: none;
            border-bottom: 1px dashed #e67777;
        }

        footer a:focus {
            color: #e67777;
            opacity: 1;
            text-decoration: none;
            border-bottom: 1px dashed #e67777;
        }
    </style>
</head>
<body>

<header>
    <a href="<c:url value="/" />"><img src="<c:url value="/static/images/logo1.png" />" alt="LOGO" id="logo"></a>
    <a href="<c:url value="/" />"><h3 id="standingbyme">一起同过窗</h3></a>
</header>

<div class="main">
    <div class="wrapper">
        <h3 class="text-center">${classmate.name}</h3>
        <h5 class="text-center">${classmate.school} ${classmate.clazz}</h5>
        <h5 class="text-right" id="author">————<span style="color: #e67777;">${classmateAuthorName}</span>的同学录</h5>
        <div class="container-fluid">
            <form class="form-horizontal" id="paper-fm">
                <input id="classmateId" name="classmateId" class="hidden" value="${classmate.id}">
                <input id="authorId" name="authorId" class="hidden">
                <input type="text" name="name" class="form-control" placeholder="姓名" id="name">
                <input type="text" name="nickname" class="form-control" placeholder="昵称" id="nickname">
                <input type="text" name="sex" class="form-control" placeholder="性别" id="sex">
                <input type="text" name="birthday" class="form-control" placeholder="生日" id="birthday">
                <input type="text" name="address" class="form-control" placeholder="能收到信的地方" id="address">
                <input type="text" name="phone" class="form-control" placeholder="常用电话" id="phone">
                <input type="email" name="email" class="form-control" placeholder="邮箱" id="email">
                <input type="text" name="qq" class="form-control" placeholder="QQ" id="qq">
                <input type="text" name="wechat" class="form-control" placeholder="微信" id="wechat">
                <input type="text" name="favMovie" class="form-control" placeholder="最喜欢的电影" id="favMovie">
                <input type="text" name="favSinger" class="form-control" placeholder="最喜欢的歌手" id="favSinger">
                <input type="text" name="favBook" class="form-control" placeholder="最爱的书" id="favBook">
                <input type="text" name="favTravelPlace" class="form-control" placeholder="最想去的地方" id="favTravelPlace">

                <textarea class="form-control" name="favThingToDo" rows="4" placeholder="最想做的事" id="favThingToDo"></textarea>
                <textarea class="form-control" name="specialInClass" rows="4" placeholder="上课做过最奇葩的事" id="specialInClass"></textarea>
                <textarea class="form-control" name="wordToMe" rows="8" placeholder="简单聊聊我吧" id="wordToMe"></textarea>

                <button class="btn" type="button" id="sure-write" onclick="writePaper()">确认填写</button>
            </form>
        </div>
    </div>
    <footer class="footer">
        <p>Copyright © 2018 <a href="<c:url value="/" />">Standingbyme</a>. All Rights Reserved.</p>
    </footer>
</div>


<script src="<c:url value="/static/js/jquery-3.2.1.js" />"></script>
<script src="<c:url value="/static/js/bootstrap.min.js" />"></script>
<script src="<c:url value="/static/js/alert.js" />"></script>

<script>
    $(function () {
        $(".wrapper").addClass("wrapper-gif").css("height",$(".container-fluid").height()+150+"px"); //页面加载完成后执行动画
        $(".footer").css("top",$(".wrapper").height()+120+"px");

        if("${paperAuthor}"!==undefined){
            $("#authorId").val("${paperAuthor.id}");
            $("#name").val("${paperAuthor.realName}");
            $("#nickname").val("${paperAuthor.nickname}");
            $("#sex").val("${paperAuthor.sex}");
            $("#birthday").val("${paperAuthor.birthday}");
            $("#address").val("${paperAuthor.address}");
            $("#phone").val("${paperAuthor.phone}");
            $("#email").val("${paperAuthor.email}");
            $("#qq").val("${paperAuthor.qq}");
            $("#wechat").val("${paperAuthor.wechat}");
        }
    });

    function writePaper() {
        var writeBtn=$("#sure-write");
        writeBtn.attr("disabled",true);
        writeBtn.text("正在提交同学录");

        $.post("<c:url value="/classmate/writePaper" />",$("#paper-fm").serialize(),
            function (data) {
                if(data.statusCode===200){
                    alert("同学录填写成功");
                    if(data.extend.nextPage==='welcome'){
                        $(location).attr("href","<c:url value="/member/welcome" />");
                    }
                    else{
                        $(location).attr("href","<c:url value="/" />");
                    }
                }
                else if(data.status===400){
                    alert(data.msg);
                }
                else{
                    alert("网络错误，请稍后重试");
                }
                writeBtn.attr("disabled",false);
                writeBtn.text("确认填写");
            });
    }
</script>

</body>
</html>
