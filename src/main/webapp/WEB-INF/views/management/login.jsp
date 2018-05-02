<%--
  Created by IntelliJ IDEA.
  User: li
  Date: 2018/4/30
  Time: 18:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <form action="/management/login" method="post">
        <label title="工号">
            <input type="text" name="workId">
        </label>
        <label title="密码">
            <input type="password" name="password">
        </label>
        <label title="验证码">
            <input type="text" name="graphicCode">
        </label>
        <img src="/codeService/graphicCode">
        <button type="submit">登录</button>
    </form>

<script src="<c:url value="/static/js/jquery-3.2.1.js" />"></script>
<script>
    $(function () {
        var errorMsg="${errorMsg}";
        if(errorMsg!==undefined&&errorMsg!==null&&errorMsg!==''){
            alert(errorMsg);
        }
    });
</script>
</body>
</html>
