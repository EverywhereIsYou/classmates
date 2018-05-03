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

    <%--两个按钮--%>
    <div class="row" style="margin-bottom: 20px">
        <div class="col-md-4 col-md-offset-8 text-right">
            <button class="btn btn-primary"  data-toggle="modal" data-target="#edit-modal">新增</button>
            <button class="btn btn-danger" data-toggle="modal" data-target="#delete-modal">删除</button>
        </div>
    </div>

    <%--表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                    <th class="text-center">id</th>
                    <th class="text-center">昵称</th>
                    <th class="text-center">姓名</th>
                    <th class="text-center">年龄</th>
                    <th class="text-center">备注</th>
                    <th class="text-center">操作</th>
                </tr>
                <tr class="text-center">
                    <td>1</td>
                    <td>张三</td>
                    <td>张三</td>
                    <td>22</td>
                    <td>1</td>
                    <td>
                        <button class="btn btn-primary btn-sm" data-toggle="modal" data-target="#edit-modal">
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                            编辑
                        </button>
                        <button class="btn btn-danger btn-sm" data-toggle="modal" data-target="#delete-modal">
                            <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                            删除
                        </button>
                    </td>
                </tr>

            </table>
        </div>
    </div>

    <%--分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-12 text-right">
            当前记录：xxx
        </div>

        <%--分页条信息--%>
        <div class="col-md-12 text-center">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li><a href="#">首页</a></li>
                    <li>
                        <a href="#" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    <li class="active"><a href="#">1</a></li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li><a href="#">4</a></li>
                    <li><a href="#">5</a></li>
                    <li>
                        <a href="#" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                    <li><a href="#">末页</a></li>
                </ul>
            </nav>
        </div>
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
                <h3>确定要删除此用户吗？</h3>
            </div>
            <div class="modal-body text-center">
                <button class="btn btn-danger btn-sm">确认</button>
                <button class="btn btn-success btn-sm"  data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<%--编辑模态框--%>
<div class="modal fade" id="edit-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
                <h3>编辑id为 1 的用户</h3>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="nickname">昵称</label>
                        <input type="text" class="form-control" id="nickname" placeholder="昵称" value="">
                    </div>
                    <div class="form-group">
                        <label for="rolename">姓名</label>
                        <input type="text" class="form-control" id="rolename" placeholder="姓名" value="">
                    </div>
                    <div class="form-group">
                        <label for="age">年龄</label>
                        <input type="text" class="form-control" id="age" placeholder="年龄" value="">
                    </div>
                    <div class="form-group">
                        <label for="remark">备注</label>
                        <input type="text" class="form-control" id="remark" placeholder="备注" value="">
                    </div>
                    <div class="form-group text-center">
                        <button class="btn btn-danger btn-sm">确认</button>
                        <button class="btn btn-success btn-sm" data-dismiss="modal">取消</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="<c:url value="/static/js/jquery-3.2.1.js" />"></script>
<script src="<c:url value="/static/js/bootstrap.min.js" />"></script>
<script src="<c:url value="/static/js/alert.js" />"></script>

</body>
</html>
