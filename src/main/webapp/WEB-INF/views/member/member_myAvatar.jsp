<%--
  Created by IntelliJ IDEA.
  User: LP
  Date: 2018/5/8
  Time: 15:21
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
        .container{
            padding-top: 50px;
            text-align: center;
            position: relative;
        }
        #avatar{
            opacity: 0;
            margin-right: 0;
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            margin-top: 30px;
        }
        #preview{
            width: 150px;
            height: 150px;
            border-radius: 75px;

        }
        .container a{
            color: #e67777;
            font-size: 1.2em;
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            margin-top: 180px;
            z-index: -1;
        }
        button{
            width: 200px;
            height: 34px;
            color: white;
            font-family: "Helvetica Neue", "Helvetica", "Arial", "sans-serif";
            font-size: 1.2em;
            font-weight: 700;
            background: linear-gradient(to right, #5f4d93, #e67777);
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#5f4d93', endColorstr='#e67777', GradientType=1); /*IE9*/
            border: 0;
            border-radius: 4px;
            -moz-box-shadow: 0 0 5px #e67777;
            -webkit-box-shadow: 0 0 5px #e67777;
            box-shadow: 0 0 5px #e67777;
            margin-top: 250px;
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
        }
    </style>

</head>

<body>

<div class="container">
    <img src="" alt="" id="preview">
    <input type="file" name="avatar" class="input-upload" placeholder="" id="avatar" accept="image/*" onchange="imgPreview(this)">
    <a href="javascript:void(0);"><u>＋上传头像</u></a>
    <button onclick="uploadAvatar()" id="upload-avatar">保&nbsp;&nbsp;存</button>
</div>

<script src="<c:url value="/static/js/jquery-3.2.1.js" />"></script>
<script src="<c:url value="/static/js/bootstrap.min.js" />"></script>
<script src="<c:url value="/static/js/alert.js" />"></script>

<script>
    //上传图片的预览
    function imgPreview(fileDom){
        //判断是否支持FileReader
        if (window.FileReader) {
            var reader = new FileReader();
        } else {
            alert("您的设备不支持图片预览功能，如需该功能请升级您的设备！");
        }
        //获取文件
        var file = fileDom.files[0];
        var imageType = /^image\//;
        //是否是图片
        if (!imageType.test(file.type)) {
            alert("请选择图片！");
            return;
        }
        //读取完成
        reader.onload = function(e) {
            //获取图片dom
            var img = $("#preview");
            //图片路径设置为读取的图片
            img.attr("src",e.target.result);
        };
        reader.readAsDataURL(file);
    }

    var originAvatar;
    $(function () {
        $.post("<c:url value="/member/baseInfo" />",function (data) {
            var image=$("#preview");
            if(data.statusCode===200){
                image.attr("src",data.extend.member.avatar);
            }
            else{
                image.attr("src","<c:url value="/static/images/avatar.png" />");
            }
            originAvatar=image[0].src;
        });
    });

    function uploadAvatar() {
        var imageSrc=$("#preview")[0].src;
        if(imageSrc===undefined||imageSrc===null||imageSrc===''||imageSrc===originAvatar){
            alert("请先选择一张图片");
            return;
        }

        $("#upload-avatar").html("正 在 上 传").attr("disabled",true);
        var formData=new FormData();
        formData.append("avatar",$("#avatar")[0].files[0]);
        $.ajax({
            url:'<c:url value="/file/memberAvatar" />',
            data:formData,
            type:'POST',
            processData:false,
            contentType:false,
            error:function () {
                alert("网络错误，请稍后重试");
            },
            success:function (data) {
                if(data.statusCode===200){
                    $.post("<c:url value="/member/modifyAvatar" />",{"avatar":data.extend.fileName},function (data) {
                        if(data.statusCode===200){
                            alert("上传头像成功");
                        }
                        else{
                            alert(data.msg);
                        }
                        $("#upload-avatar").html("保&nbsp;&nbsp;存").attr("disabled",false);
                    });
                }
                else{
                    alert(data.msg);
                    $("#upload-avatar").html("保&nbsp;&nbsp;存").attr("disabled",false);
                }
            }
        });
    }
</script>

</body>
</html>
