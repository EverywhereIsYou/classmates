<%--
  Created by IntelliJ IDEA.
  User: li
  Date: 2018/5/8
  Time: 9:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="stylesheet" href="<c:url value="/static/css/bootstrap.min.css" />">
    <link rel="stylesheet" href="<c:url value="/static/css/alert.css" />">
    <title>Title</title>
    <style>
        .container{border: 0!important;}
        textarea{
            resize:none;
        }
    </style>
</head>
<body>
<div class="container table-responsive">
    <%--表格标题--%>
    <div class="row">
        <div class="col-md-12">
            <h3>评论信息</h3>
        </div>
    </div>

    <div class="row">&nbsp;</div>

    <%--表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th class="text-center">序号</th>
                    <th class="text-center">填写时间</th>
                    <th class="text-center">内容</th>
                    <th class="text-center">操作</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>

    <%--分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-12 text-right" id="page-info"></div>

        <%--分页条信息--%>
        <div class="col-md-12 text-center" id="nav-area"></div>
    </div>
</div>

<%--删除模态框--%>
<div class="modal fade" id="delete-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
                <h3 id="comment-author-name">&nbsp;</h3>
            </div>
            <input type="hidden" id="delete-comment-id">
            <div class="modal-body text-center">
                <button class="btn btn-danger btn-sm" onclick="confirmDelete()">确认</button>
                <button class="btn btn-success btn-sm"  data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<script src="<c:url value="/static/js/jquery-3.2.1.js" />"></script>
<script src="<c:url value="/static/js/bootstrap.min.js" />"></script>
<script src="<c:url value="/static/js/alert.js" />"></script>
<script src="<c:url value="/static/js/pageinfo.js" />" ></script>
<script>
    $(function () {
        getDataByPage(1);
    });

    function getDataByPage(page) {
        getData(page,6);
    }

    function getData(page,limit) {
        $.post("<c:url value="/data/comment/list" />",{"page":page,"limit":limit},function (data) {
            if(data.statusCode===200){
                setComment(data.extend.pageInfo.list);
                setPageInfo(data.extend.pageInfo);
                setNavArea(data.extend.pageInfo);
            }
            else if(data.statusCode===400){
                alert(data.msg);
            }
            else{
                alert("网络错误，请稍后重试");
            }
        });
    }

    function setComment(commentList) {
        var tableBody=$(".table tbody");
        if(commentList===undefined||commentList===null||commentList.length===0){
            tableBody.html("暂无数据");
            return;
        }
        tableBody.html("");

        $.each(commentList,function (index,item) {
            var numTd=$("<td></td>").append(index+1);
            var createTimeTd=$("<td></td>").append(item.createTime);
            var contentTd=$("<td></td>").append(item.content);

            var deleteBtn=$("<button class='btn btn-danger btn-sm'></button>").append($("<span class='glyphicon glyphicon-trash'></span>"))
                .append("删除").click(function () {
                    var content=item.content;
                    if(content===undefined||content===null||content==='')
                        content=' ';
                    else if(content.length>5)
                        content=content.substring(0,5)+"...";
                    deleteComment(content,item.id);
                });

            var btnTd=$("<td></td>").append(deleteBtn);

            $("<tr class='text-center'></tr>").append(numTd).append(createTimeTd).append(contentTd).append(btnTd).appendTo(tableBody);
        });
    }

    function deleteComment(content,commentId) {
        $("#comment-author-name").text("确定要删除内容为 "+content+" 的评论吗？");
        $("#delete-comment-id").val(commentId);
        $("#delete-modal").modal("show");
    }
    function confirmDelete() {
        $.post("<c:url value="/data/comment/delete" />",{"commentId":$("#delete-comment-id").val()},function (data) {
            if(data.statusCode===200){
                getDataByPage($(".active").text());
                alert("删除成功");
            }
            else if(data.statusCode===400){
                alert(data.msg);
            }
            else{
                alert("网络错误，请稍后重试");
            }
        });
        $("#delete-modal").modal("hide");
    }
</script>
</body>
</html>
