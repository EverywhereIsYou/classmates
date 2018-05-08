<%--
  Created by IntelliJ IDEA.
  User: li
  Date: 2018/5/7
  Time: 9:08
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
            <h3>同学录信息</h3>
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
                    <th class="text-center">名称</th>
                    <th class="text-center">学校</th>
                    <th class="text-center">班级</th>
                    <th class="text-center">创建时间</th>
                    <th class="text-center">修改时间</th>
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
                <h3 id="classmate-name">&nbsp;</h3>
            </div>
            <input type="hidden" id="delete-classmate-id">
            <div class="modal-body text-center">
                <button class="btn btn-danger btn-sm" onclick="confirmDelete()">确认</button>
                <button class="btn btn-success btn-sm"  data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<%--查看模态框--%>
<div class="modal fade" id="view-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" id="close-create-user">
                    <span>&times;</span>
                </button>
                <h3>同学录信息详情</h3>
            </div>
            <div class="modal-body container-fluid">
                <form>
                    <div class="form-group row">
                        <div class="col-xs-6">
                            <label for="name">名称</label>
                            <input type="text" class="form-control" id="name" placeholder="名称" name="name">
                        </div>
                        <div class="col-xs-6">
                            <label for="permission">权限</label>
                            <input type="text" class="form-control" id="permission" placeholder="权限" name="permission">
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-xs-6">
                            <label for="school">学校</label>
                            <input type="text" class="form-control" id="school" placeholder="学校" name="school">
                        </div>
                        <div class="col-xs-6">
                            <label for="clazz">班级</label>
                            <input type="text" class="form-control" id="clazz" placeholder="班级" name="clazz">
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-xs-6">
                            <label for="createTime">创建时间</label>
                            <input type="text" class="form-control" id="createTime" placeholder="创建时间" name="createTime">
                        </div>
                        <div class="col-xs-6">
                            <label for="lastModifyTime">修改时间</label>
                            <input type="text" class="form-control" id="lastModifyTime" placeholder="修改时间" name="lastModifyTime">
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-xs-12">
                            <label for="description">描述</label>
                            <textarea rows="3" class="form-control" id="description" placeholder="描述" name="description"></textarea>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-xs-12">
                            <label for="customizeFiled">自定义</label>
                            <textarea rows="5" class="form-control" id="customizeFiled" placeholder="自定义" name="customizeFiled"></textarea>
                        </div>
                    </div>

                    <div class="form-group text-center">
                        <div class="col-xs-12">
                            <button type="button" class="btn btn-success btn-sm" data-dismiss="modal">确定</button>
                        </div>
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
        $.post("<c:url value="/data/classmate/list"/>",{"page":page,"limit":limit},function (data) {
            if(data.statusCode===200){
                setClassmate(data.extend.pageInfo.list);
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

    function setClassmate(classmateList) {
        var tableBody=$(".table tbody");
        if(classmateList===undefined||classmateList===null||classmateList.length===0){
            tableBody.html("暂无数据");
            return;
        }
        tableBody.html("");

        $.each(classmateList,function (index,item) {
            var numTd=$("<td></td>").append(index+1);
            var nameTd=$("<td></td>").append(item.name);
            var schoolTd=$("<td></td>").append(item.school);
            var clazzTd=$("<td></td>").append(item.clazz);
            var createTimeTd=$("<td></td>").append(item.createTime);
            var modifyTimeTd=$("<td></td>").append(item.lastModifyTime);

            var detailBtn=$("<button class='btn btn-primary btn-sm'></button>").append($("<span class='glyphicon glyphicon-search'></span>"))
                .append("详情").click(function () {
                    detail(item);
                });
            var deleteBtn=$("<button class='btn btn-danger btn-sm'></button>").append($("<span class='glyphicon glyphicon-trash'></span>"))
                .append("删除").click(function () {
                        deleteClassmate(item.name,item.id);
                });
            var btnTd=$("<td></td>").append(detailBtn).append(" ").append(deleteBtn);

            $("<tr class='text-center'></tr>").append(numTd).append(nameTd).append(schoolTd).append(clazzTd)
                .append(createTimeTd).append(modifyTimeTd).append(btnTd).appendTo(tableBody);
        });
    }

    function detail(classmate) {
        $("#name").val(classmate.name);
        var permission=classmate.permission;
        if(permission===2){
            $("#permission").val("参与人可见");
        }
        else if(permission===1){
            $("#permission").val("拥有者可见");
        }
        else if(permission===3){
            $("#permission").val("所有人可见");
        }

        $("#school").val(classmate.school);
        $("#clazz").val(classmate.clazz);
        $("#createTime").val(classmate.createTime);
        $("#lastModifyTime").val(classmate.lastModifyTime);
        $("#description").val(classmate.description);
        $("#customizeFiled").val(classmate.customizeFiled);

        $("#view-modal").modal("show");
    }

    function deleteClassmate(name,classmate) {
        $("#classmate-name").text("确定要删除名称为 "+name+" 的同学录吗？");
        $("#delete-classmate-id").val(classmate);
        $("#delete-modal").modal("show");
    }
    function confirmDelete() {
        $.post("<c:url value="/data/classmate/delete" />",{"classmateId":$("#delete-classmate-id").val()},function (data) {
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
