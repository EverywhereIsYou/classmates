<%--
  Created by IntelliJ IDEA.
  User: LP
  Date: 2018/5/8
  Time: 14:53
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
        #confirm-modify{
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
            <label class="col-xs-2 control-label">昵称：</label>
            <div class="col-xs-8">
                <input type="text" name="nickname" class="form-control" placeholder="未填写" id="nickname">
            </div>
        </div>
        <div class="form-group">
            <label class="col-xs-2 control-label">真实姓名：</label>
            <div class="col-xs-8">
                <input type="text" name="realName" class="form-control" placeholder="未填写" id="realName">
            </div>
        </div>
        <div class="form-group">
            <label class="col-xs-2 control-label">性别：</label>
            <div class="col-xs-8">
                <input type="text" name="sex" class="form-control" placeholder="未填写" id="sex">
            </div>
        </div>
        <div class="form-group">
            <label class="col-xs-2 control-label">电话：</label>
            <div class="col-xs-8">
                <input type="text" name="phone" class="form-control" placeholder="未填写" id="phone">
            </div>
        </div>
        <div class="form-group">
            <label class="col-xs-2 control-label">邮箱：</label>
            <div class="col-xs-8">
                <input type="email" name="email" class="form-control" placeholder="未填写" id="email">
            </div>
        </div>
        <div class="form-group">
            <label class="col-xs-2 control-label">生日：</label>
            <div class="col-xs-8">
                <input type="text" name="birthday" class="form-control" placeholder="未填写" id="birthday">
            </div>
        </div>
        <div class="form-group">
            <label class="col-xs-2 control-label">住址：</label>
            <div class="col-xs-8">
                <input type="text" name="address" class="form-control" placeholder="未填写" id="address">
            </div>
        </div>
        <div class="form-group">
            <label class="col-xs-2 control-label">故乡：</label>
            <div class="col-xs-8">
                <input type="text" name="hometown" class="form-control" placeholder="未填写" id="hometown">
            </div>
        </div>
        <div class="form-group">
            <label class="col-xs-2 control-label">QQ：</label>
            <div class="col-xs-8">
                <input type="text" name="qq" class="form-control" placeholder="未填写" id="qq">
            </div>
        </div>
        <div class="form-group">
            <label class="col-xs-2 control-label">微信：</label>
            <div class="col-xs-8">
                <input type="text" name="wechat" class="form-control" placeholder="未填写" id="wechat">
            </div>
        </div>
        <div class="col-xs-4 col-xs-offset-4">
            <button type="button" class="btn" id="confirm-modify" onclick="modifyMember()">保&nbsp;&nbsp;存</button>
        </div>
    </form>
</div>

<script src="<c:url value="/static/js/jquery-3.2.1.js" />"></script>
<script src="<c:url value="/static/js/bootstrap.min.js" />"></script>
<script src="<c:url value="/static/js/alert.js" />"></script>
<script>
    $(function () {
        $.post("<c:url value="/member/baseInfo" />",function (data) {
            if(data.statusCode===200){
                setMember(data.extend.member);
            }
            else if(data.statusCode===400){
                alert(data.msg);
            }
            else{
                alert("网络错误，请稍后重试");
            }
        });
    });

    function setMember(member) {
        $("#nickname").val(member.nickname);
        $("#realName").val(member.realName);
        $("#sex").val(member.sex);
        $("#birthday").val(member.birthday);
        $("#address").val(member.address);
        $("#hometown").val(member.hometown);
        $("#qq").val(member.qq);
        $("#wechat").val(member.wechat);

        var phone=member.phone;
        if(phone!==undefined&&phone!==null&&phone!==''){
            $("#phone").val(phone).attr("readonly",true);
        }
        var email=member.email;
        if(email!==undefined&&email!==null&&email!==''){
            $("#email").val(email).attr("readonly",true);
        }
    }

    function modifyMember() {
        $("#confirm-modify").html("正 在 修 改").attr("disabled",true);
        $.post("<c:url value="/member/modifyInfo" />",$("#fm").serialize(),function (data) {
            if(data.statusCode===200){
                alert("修改成功");
            }
            else if(data.statusCode===400){
                alert(data.msg);
            }
            else{
                alert("网络错误，请稍后重试");
            }
            $("#confirm-modify").html("保&nbsp;&nbsp;存").attr("disabled",false);
        });
    }
</script>

</body>
</html>