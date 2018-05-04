<%--
  Created by IntelliJ IDEA.
  User: li
  Date: 2018/5/4
  Time: 15:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"%>
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
            <h3>用户信息</h3>
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
                    <th class="text-center">昵称</th>
                    <th class="text-center">真实姓名</th>
                    <th class="text-center">性别</th>
                    <th class="text-center">邮箱</th>
                    <th class="text-center">电话</th>
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
                <h3 id="member-id">&nbsp;</h3>
            </div>
            <input type="hidden" id="delete-member-id">
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
                <button type="button" class="close" data-dismiss="modal" id="close-create-user" onclick="clearCreate()">
                    <span>&times;</span>
                </button>
                <h3>用户信息详情</h3>
            </div>
            <div class="modal-body container-fluid">
                <form>
                    <div class="form-group row">
                        <div class="col-xs-6">
                            <label for="nickname">昵称</label>
                            <input type="text" class="form-control" id="nickname" placeholder="昵称" name="nickname">
                        </div>
                        <div class="col-xs-6">
                            <label for="realName">真实姓名</label>
                            <input type="text" class="form-control" id="realName" placeholder="真实姓名" name="realName">
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-xs-6">
                            <label for="nickname">邮箱</label>
                            <input type="text" class="form-control" id="email" placeholder="邮箱" name="email">
                        </div>
                        <div class="col-xs-6">
                            <label for="realname">电话</label>
                            <input type="text" class="form-control" id="phone" placeholder="电话" name="phone">
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-xs-6">
                            <label for="nickname">QQ</label>
                            <input type="text" class="form-control" id="qq" placeholder="QQ" name="qq">
                        </div>
                        <div class="col-xs-6">
                            <label for="realname">微信</label>
                            <input type="text" class="form-control" id="wechat" placeholder="微信" name="wechat">
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-xs-6">
                            <label for="nickname">性别</label>
                            <input type="text" class="form-control" id="sex" placeholder="性别" name="sex">
                        </div>
                        <div class="col-xs-6">
                            <label for="realname">生日</label>
                            <input type="text" class="form-control" id="birthday" placeholder="生日" name="birthday">
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-xs-12">
                            <label for="realname">住址</label>
                            <input type="text" class="form-control" id="address" placeholder="住址" name="address">
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-xs-12">
                            <label for="realname">故乡</label>
                            <input type="text" class="form-control" id="hometown" placeholder="故乡" name="hometown">
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-xs-6">
                            <label for="nickname">创建时间</label>
                            <input type="text" class="form-control" id="createTime" placeholder="创建时间" name="createTime">
                        </div>
                        <div class="col-xs-6">
                            <label for="realname">最后修改时间</label>
                            <input type="text" class="form-control" id="lastModifyTime" placeholder="最后修改时间" name="lastModifyTime">
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-xs-12">
                            <label for="realname">备注</label>
                            <textarea rows="3" class="form-control" style="resize:none" id="remark" placeholder="备注" name="remark"></textarea>
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
        $.post("/data/member/list",{"page":page,"limit":limit},function (data) {
            if(data.statusCode===200){
                setMember(data.extend.pageInfo.list);
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

    function setMember(memberList) {
        var tableBody=$(".table tbody");
        if(memberList===undefined||memberList===null||memberList.length===0){
            tableBody.html("暂无数据");
            return;
        }
        tableBody.html("");

        $.each(memberList,function (index,item) {
            var numTd=$("<td></td>").append(index+1);
            var nicknameTd=$("<td></td>").append(item.nickname);
            var realnameTd=$("<td></td>").append(item.realName);
            var sexTd=$("<td></td>").append(item.sex);
            var emailTd=$("<td></td>").append(item.email);
            var phoneTd=$("<td></td>").append(item.phone);

            var detailBtn=$("<button class='btn btn-primary btn-sm'></button>").append($("<span class='glyphicon glyphicon-search'></span>"))
                .append("详情").click(function () {
                    detail(item);
                });
            var deleteBtn=$("<button class='btn btn-danger btn-sm'></button>").append($("<span class='glyphicon glyphicon-trash'></span>"))
                .append("删除").click(function () {
                    if(item.email!=null&&item.email!=='')
                        deleteMember(item.email,item.id);
                    else
                        deleteMember(item.phone,item.id);
                });
            var btnTd=$("<td></td>").append(detailBtn).append(" ").append(deleteBtn);

            $("<tr class='text-center'></tr>").append(numTd).append(nicknameTd).append(realnameTd).append(sexTd)
                .append(emailTd).append(phoneTd).append(btnTd).appendTo(tableBody);
        });
    }

    function detail(member) {
        $("#nickname").val(member.nickname);
        $("#realName").val(member.realName);
        $("#email").val(member.email);
        $("#phone").val(member.phone);
        $("#qq").val(member.qq);
        $("#wechat").val(member.wechat);
        $("#sex").val(member.sex);
        $("#birthday").val(member.birthday);
        $("#address").val(member.address);
        $("#hometown").val(member.hometown);
        $("#createTime").val(member.createTime);
        $("#lastModifyTime").val(member.lastModifyTime);
        $("#remark").val(member.remark);

        $("#view-modal").modal("show");
    }

    function deleteMember(account,member) {
        $("#member-id").text("确定要删除帐号为 "+account+" 的用户吗？");
        $("#delete-member-id").val(member);
        $("#delete-modal").modal("show");
    }
    function confirmDelete() {
        $.post("/data/member/delete",{"memberId":$("#delete-member-id").val()},function (data) {
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
