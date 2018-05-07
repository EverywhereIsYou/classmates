<%--
  Created by IntelliJ IDEA.
  User: li
  Date: 2018/5/7
  Time: 15:00
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
            <h3>同学录详情页信息</h3>
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
                    <th class="text-center">真实姓名</th>
                    <th class="text-center">昵称</th>
                    <th class="text-center">电话</th>
                    <th class="text-center">邮箱</th>
                    <th class="text-center">生日</th>
                    <th class="text-center">填写时间</th>
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
                <h3 id="author-name">&nbsp;</h3>
            </div>
            <input type="hidden" id="delete-paper-id">
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
                <h3>同学录详情页信息</h3>
            </div>
            <div class="modal-body container-fluid">
                <form>
                    <div class="form-group row">
                        <div class="col-xs-6">
                            <label for="name">名字</label>
                            <input type="text" class="form-control" id="name" placeholder="名字" name="name">
                        </div>
                        <div class="col-xs-6">
                            <label for="nickname">昵称</label>
                            <input type="text" class="form-control" id="nickname" placeholder="昵称" name="nickname">
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-xs-6">
                            <label for="birthday">生日</label>
                            <input type="text" class="form-control" id="birthday" placeholder="生日" name="birthday">
                        </div>
                        <div class="col-xs-6">
                            <label for="sex">性别</label>
                            <input type="text" class="form-control" id="sex" placeholder="性别" name="sex">
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-xs-6">
                            <label for="phone">电话</label>
                            <input type="text" class="form-control" id="phone" placeholder="电话" name="phone">
                        </div>
                        <div class="col-xs-6">
                            <label for="email">邮箱</label>
                            <input type="text" class="form-control" id="email" placeholder="邮箱" name="email">
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-xs-6">
                            <label for="qq">QQ</label>
                            <input type="text" class="form-control" id="qq" placeholder="QQ" name="qq">
                        </div>
                        <div class="col-xs-6">
                            <label for="wechat">微信</label>
                            <input type="text" class="form-control" id="wechat" placeholder="微信" name="wechat">
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-xs-12">
                            <label for="address">地址</label>
                            <input type="text" class="form-control" id="address" placeholder="地址" name="address">
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-xs-6">
                            <label for="favMovie">最喜欢的电影</label>
                            <input type="text" class="form-control" id="favMovie" placeholder="最喜欢的电影" name="favMovie">
                        </div>
                        <div class="col-xs-6">
                            <label for="favSinger">最喜欢的歌手</label>
                            <input type="text" class="form-control" id="favSinger" placeholder="最喜欢的歌手" name="favSinger">
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-xs-6">
                            <label for="favBook">最喜欢的书籍</label>
                            <input type="text" class="form-control" id="favBook" placeholder="最喜欢的书籍" name="favBook">
                        </div>
                        <div class="col-xs-6">
                            <label for="favTravelPlace">最想去的地方</label>
                            <input type="text" class="form-control" id="favTravelPlace" placeholder="最想去的地方" name="favTravelPlace">
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-xs-6">
                            <label for="createTime">填写时间</label>
                            <input type="text" class="form-control" id="createTime" placeholder="填写时间" name="createTime">
                        </div>
                        <div class="col-xs-6">
                            <label for="permission">查看权限</label>
                            <input type="text" class="form-control" id="permission" placeholder="查看权限" name="permission">
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-xs-12">
                            <label for="favThingToDo">最想做的事</label>
                            <textarea rows="3" class="form-control" id="favThingToDo" placeholder="最想做的事" name="favThingToDo"></textarea>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-xs-12">
                            <label for="specialInClass">上课做过最奇葩的事</label>
                            <textarea rows="5" class="form-control" id="specialInClass" placeholder="上课做过最奇葩的事" name="specialInClass"></textarea>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-xs-12">
                            <label for="wordToMe">最想对我说的话</label>
                            <textarea rows="5" class="form-control" id="wordToMe" placeholder="最想对我说的话" name="wordToMe"></textarea>
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
        $.post("/data/paper/list",{"page":page,"limit":limit},function (data) {
            if(data.statusCode===200){
                setPaper(data.extend.pageInfo.list);
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

    function setPaper(paperList) {
        var tableBody=$(".table tbody");
        if(paperList===undefined||paperList===null||paperList.length===0){
            tableBody.html("暂无数据");
            return;
        }
        tableBody.html("");

        $.each(paperList,function (index,item) {
            var numTd=$("<td></td>").append(index+1);
            var realNameTd=$("<td></td>").append(item.name);
            var nacknameTd=$("<td></td>").append(item.nickname);
            var phoneTd=$("<td></td>").append(item.phone);
            var emailTd=$("<td></td>").append(item.email);
            var birthdayTd=$("<td></td>").append(item.birthday);
            var createTimeTd=$("<td></td>").append(item.createTime);

            var detailBtn=$("<button class='btn btn-primary btn-sm'></button>").append($("<span class='glyphicon glyphicon-search'></span>"))
                .append("详情").click(function () {
                    detail(item);
                });
            var deleteBtn=$("<button class='btn btn-danger btn-sm'></button>").append($("<span class='glyphicon glyphicon-trash'></span>"))
                .append("删除").click(function () {
                    if(item.nickname===undefined||item.nickname===null||item.nickname==='')
                        deleteClassmate(item.name,item.id);
                    else
                        deleteClassmate(item.nickname,item.id);
                });
            var btnTd=$("<td></td>").append(detailBtn).append(" ").append(deleteBtn);

            $("<tr class='text-center'></tr>").append(numTd).append(realNameTd).append(nacknameTd).append(phoneTd)
                .append(emailTd).append(birthdayTd).append(createTimeTd).append(btnTd).appendTo(tableBody);
        });
    }

    function detail(paper) {
        $("#name").val(paper.name);
        $("#nickname").val(paper.nickname);
        $("#birthday").val(paper.birthday);
        $("#sex").val(paper.sex);
        $("#phone").val(paper.phone);
        $("#email").val(paper.email);
        $("#qq").val(paper.qq);
        $("#wechat").val(paper.wechat);
        $("#address").val(paper.address);
        $("#favMovie").val(paper.favMovie);
        $("#favSinger").val(paper.favSinger);
        $("#favBook").val(paper.favBook);
        $("#favTravelPlace").val(paper.favTravelPlace);
        $("#favThingToDo").val(paper.favThingToDo);
        $("#specialInClass").val(paper.specialInClass);
        $("#wordToMe").val(paper.wordToMe);
        $("#customizeFiled").val(paper.customizeFiled);
        $("#createTime").val(paper.createTime);

        var permission=paper.permission;
        if(permission===2){
            $("#permission").val("参与人可见");
        }
        else if(permission===1){
            $("#permission").val("拥有者可见");
        }
        else if(permission===3){
            $("#permission").val("所有人可见");
        }

        $("#view-modal").modal("show");
    }

    function deleteClassmate(name,paperId) {
        $("#author-name").text("确定要删除名字为 "+name+" 的同学录详情页吗？");
        $("#delete-paper-id").val(paperId);
        $("#delete-modal").modal("show");
    }
    function confirmDelete() {
        $.post("/data/paper/delete",{"paperId":$("#delete-paper-id").val()},function (data) {
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
