<%--
  Created by IntelliJ IDEA.
  User: LP
  Date: 2018/5/1
  Time: 13:11
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
    </style>

</head>
<body>
<div class="container table-responsive">
    <%--表格标题--%>
    <div class="row">
        <div class="col-md-12">
            <h3>管理员信息</h3>
        </div>
    </div>

    <%--按钮--%>
    <div class="row" style="margin-bottom: 20px">
        <div class="col-md-1 col-md-offset-11">
            <button class="btn btn-primary"  data-toggle="modal" data-target="#edit-modal">新增</button>
        </div>
    </div>

    <%--表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th class="text-center">序号</th>
                        <th class="text-center">工号</th>
                        <th class="text-center">角色</th>
                        <th class="text-center">创建时间</th>
                        <th class="text-center">最后修改时间</th>
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
                <h3 id="work-id">&nbsp;</h3>
            </div>
            <input type="hidden" id="delete-user-id">
            <div class="modal-body text-center">
                <button class="btn btn-danger btn-sm" onclick="confirmDelete()">确认</button>
                <button class="btn btn-success btn-sm"  data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<%--添加模态框--%>
<div class="modal fade" id="edit-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" id="close-create-user" onclick="clearCreate()">
                    <span>&times;</span>
                </button>
                <h3>添加新的管理员</h3>
            </div>
            <div class="modal-body">
                <form id="create-user">
                    <div class="form-group">
                        <label for="workId">工号</label>
                        <input type="text" class="form-control" id="workId" placeholder="工号" name="workId">
                    </div>
                    <div class="form-group">
                        <label for="pwd">密码</label>
                        <input type="password" class="form-control" id="pwd" placeholder="密码" name="pwd">
                    </div>
                    <div class="form-group">
                        <label for="confirm-pwd">确认密码</label>
                        <input type="password" class="form-control" id="confirm-pwd" placeholder="确认密码" name="confirm-pwd">
                    </div>
                    <div class="form-group text-center">
                        <button type="button" class="btn btn-danger btn-sm" onclick="confirmCreate()">确认</button>
                        <button type="button" class="btn btn-success btn-sm" data-dismiss="modal" onclick="clearCreate()">取消</button>
                    </div>
                </form>
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
        $.post("/data/user/list",{"page":page,"limit":limit},function (data) {
            if(data.statusCode===200){
                setUser(data.extend.pageInfo.list);
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
    
    function setUser(userList) {
        var tableBody=$(".table tbody");
        if(userList===undefined||userList===null||userList.length===0){
            tableBody.html("暂无数据");
            return;
        }
        tableBody.html("");

        $.each(userList,function (index,item) {
            var numTd=$("<td></td>").append(index+1);
            var workIdTd=$("<td></td>").append(item.workId);
            var roleTd=$("<td></td>").append(item.role);
            var createTimeTd=$("<td></td>").append(item.createTime);
            var lastModifyTimeTd=$("<td></td>").append(item.lastModifyTime);
            var btnTd=$("<td></td>").append($("<button class='btn btn-danger btn-sm'></button>")
                .append($("<span class='glyphicon glyphicon-trash'></span>")).append("删除")
                .click(function () {
                    deleteUser(item.workId,item.id);
                }));

            $("<tr class='text-center'></tr>").append(numTd).append(workIdTd).append(roleTd).append(createTimeTd)
                .append(lastModifyTimeTd).append(btnTd).appendTo(tableBody);
        });
    }
    
    function confirmCreate() {
        $.post("/data/user/add",$("#create-user").serialize(),function (data) {
            clearCreate();

            if(data.statusCode===200){
                getDataByPage(1);
                alert("创建成功");
            }
            else if(data.statusCode===400){
                alert(data.msg);
            }
            else{
                alert("网络错误，请稍后重试");
            }
        });
        $("#edit-modal").modal("hide");
    }
    function clearCreate() {
        $("#create-user")[0].reset();
    }

    function deleteUser(workId,userId) {
        $("#work-id").text("确定要删除工号为 "+workId+" 的用户吗？");
        $("#delete-user-id").val(userId);
        $("#delete-modal").modal("show");
    }
    function confirmDelete() {
        $.post("/data/user/delete",{"userId":$("#delete-user-id").val()},function (data) {
            if(data.statusCode===200){
                getDataByPage($(".active").val());
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
