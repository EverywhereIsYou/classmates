<%--
  Created by IntelliJ IDEA.
  User: LP
  Date: 2018/5/8
  Time: 15:22
  To change this template use File | Settings | File Templates.
--%>
<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">

    <link rel="stylesheet" href="<c:url value="/static/css/bootstrap.min.css" />">
    <link rel="stylesheet" href="<c:url value="/static/css/alert.css" />">

    <style>
        .container{padding-top: 50px}
        label{
            height: 100%!important;
            text-align: right;
            line-height: 34px;
        }

        /*输入框获得焦点*/
        input:focus {
            border-color: #e67777!important;
            -moz-box-shadow: 0 0 10px #e67777!important;
            -webkit-box-shadow: 0 0 10px #e67777!important;
            box-shadow: 0 0 10px #e67777!important;
        }
        #save{
            width: 100%;
            height: 34px;
            color: white;
            font-family: "Helvetica Neue", "Helvetica", "Arial", "sans-serif";
            font-size: 1.2em;
            font-weight: 700;
            background: linear-gradient(to right, #5f4d93, #e67777);
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#5f4d93', endColorstr='#e67777', GradientType=1); /*IE9*/
            border: 0;
            -moz-box-shadow: 0 0 5px #e67777;
            -webkit-box-shadow: 0 0 5px #e67777;
            box-shadow: 0 0 5px #e67777;
            margin-top: 40px;
        }
    </style>

</head>

<body>

<div class="container">
    <form class="form-horizontal" id="fm" autocomplete="off" onkeydown="if(event.keyCode===13){return false;}">

        <div class="form-group">
            <label class="col-xs-2 control-label">密码：</label>
            <div class="col-xs-8">
                <input type="password" name="password" class="form-control" placeholder="现在使用的密码" id="password">
            </div>
        </div>
        <div class="form-group">
            <label class="col-xs-2 control-label">新的密码：</label>
            <div class="col-xs-8">
                <input type="password" name="newPassword" class="form-control" placeholder="新密码" id="newPassword">
            </div>
        </div>
        <div class="form-group">
            <label class="col-xs-2 control-label">确认新密码：</label>
            <div class="col-xs-8">
                <input type="password" name="confirmPassword" class="form-control" placeholder="再次输入新的密码" id="confirmPassword">
            </div>
        </div>

        <div class="col-xs-4 col-xs-offset-4">
            <button type="submit" class="btn" id="save">保&nbsp;&nbsp;存</button>
        </div>
    </form>
</div>

<script src="<c:url value="/static/js/jquery-3.2.1.js" />"></script>
<script src="<c:url value="/static/js/bootstrap.min.js" />"></script>
<script src="<c:url value="/static/js/alert.js" />"></script>

</body>
</html>
