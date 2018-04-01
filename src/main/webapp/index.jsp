<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<body>
<h2>Hello World!</h2>
<img src="<c:url value="test/image" />" id="img" alt="图片4">

<script src="<c:url value="static/js/jquery-3.2.1.js" />" ></script>
<script>
    $(function () {
        $("#img").attr("src","test/image");
    });
</script>
</body>
</html>
