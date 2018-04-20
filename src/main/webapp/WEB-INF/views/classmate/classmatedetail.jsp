<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1, user-scalable=no">

    <title></title>

    <link rel="stylesheet" href="<c:url value="/static/css/bootstrap.min.css" />">
    <link rel="stylesheet" href="<c:url value="/static/css/common.css" />">
    <link rel="stylesheet" href="<c:url value="/static/css/classmatedetail.css" />">

</head>
<body>

<!-- 菜单框 -->
<div class="menu-wrapper" id="menu-wrapper">
    <div class="menu-content" id="menu-content">
        <img src="<c:url value="/static/images/close.png" />" alt="close" class="close" id="close">
        <ul>
            <li id="menu-first"><a href="<c:url value='/member/welcome' />">首页</a></li>
            <li><a href="<c:url value='/classmate/myclassmates' />">我的同学录</a></li>
            <li><a href="#">青春瞬间</a></li>
            <li><a href="#">个人中心</a></li>
            <li><a href="<c:url value='/logout' />">退出账号</a></li>
        </ul>
    </div>
</div>

<div class="wrapper" id="wrapper">
    <a href="javascript:void(0)"><img src="<c:url value="/static/images/menu.png" />" alt="图片" id="menu"></a>
    <div class="container header">
        <h1 id="classmate-name">&nbsp;</h1>
        <h3 id="school-class">&nbsp;</h3>
        <div id="liner"></div>
        <h3 id="classmate-desc">&nbsp;</h3>
        <input id="classmate_id" class="hidden" value="${classmateId}"/>
        <a href="javascript:void(0)">
            <div class="mousedown"><span class="glyphicon glyphicon-menu-down" id="mousedown"></span>
            </div>
        </a>
    </div>

    <div class="container operation-wrapper">
        <div class="row">
            <div class="col-sm-10 col-xs-10 operation"><h3><a href="javascript:void(0)" class="invite">邀请同学填写</a></h3></div>
            <div class="col-sm-2 col-xs-2 invite" id="invite">
                <a href="javascript:void(0)"><img src="<c:url value="/static/images/invite.png" />" alt="邀请" class="icon"></a>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-10 col-xs-10 operation"><h3><a href="javascript:void(0)" class="edit">编辑</a></h3></div>
            <div class="col-sm-2 col-xs-2 edit" id="edit">
                <a href="#"><img src="<c:url value="/static/images/edit.png" />" alt="编辑" class="icon"></a>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-10 col-xs-10 operation"><h3><a href="javascript:void(0)" class="delete">删除</a></h3></div>
            <div class="col-sm-2 col-xs-2 delete" id="delete">
                <a href="#"><img src="<c:url value="/static/images/delete.png" />" alt="删除" class="icon"></a>
            </div>
        </div>
    </div>

    <%--邀请同学填写模态框--%>
    <div class="hidden" id="invite-modal">
        <div class="invite-modal-content center-block">
            <img src="<c:url value="/static/images/close2.png" />" alt="close" class="close" id="invite-close">

            <p id="write-address">localhost:8080/test/write</p>
            <input id="write-address-input" type="text" class="hidden">
            <img src="/static/images/qr_code.png" alt="二维码" id="qr-code">
            <h5>复制链接发给同学，<br/>或者让同学扫描二维码都可以填写！</h5>
            <button class="btn" type="button" id="copy" onclick="copy()">点&nbsp;此&nbsp;复&nbsp;制</button>
        </div>
    </div>

    <%--编辑同学录的模态框--%>
    <div class="edit-myclassmate-wrapper hidden">
        <div class="edit-myclassmate-content">
            <div class="edit-myclassmate-header">
                <img src="<c:url value="/static/images/close2.png" />" alt="close" class="close" id="edit-myclassmate-close">
                <h3 class="edit-myclassmate-title">编辑同学录</h3>
            </div>
            <div class="edit-myclassmate-body">
                <form class="form-horizontal" id="myclassmate-fm" autocomplete="off" onkeydown="if(event.keyCode===13){return false;}">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">同学录封面：</label>
                        <div class="col-sm-8" id="my-classmate-cover">
                            <input type="file" name="cover" class="input-upload" placeholder="" id="cover" accept="image/*" onchange="imgPreview(this)">
                            <a href="javascript:void(0);"><u>＋上传封面</u></a>
                            <img id="preview" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">同学录名称：</label>
                        <div class="col-sm-8">
                            <input type="text" name="name" class="form-control" placeholder="" id="classmatename">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">所属学校：</label>
                        <div class="col-sm-8">
                            <input type="text" name="school" class="form-control" placeholder="" id="school">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">所属班级：</label>
                        <div class="col-sm-8">
                            <input type="text" name="clazz" class="form-control" placeholder="" id="clazz">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">简单说明：</label>
                        <div class="col-sm-8">
                            <textarea type="text" name="description" class="form-control" rows="8" placeholder="" id="description"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">开放权限：</label>
                        <div class="col-sm-8" style="padding-top: 7px">
                            <label class="permission"><input type="radio" name="permission" value="1" />仅自己可见</label>
                            <label class="permission"><input type="radio" name="permission" value="2" />仅作者可见</label>
                            <label class="permission"><input type="radio" name="permission" value="3" />所有人可见</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">个性定制：</label>
                    </div>
                    <div class="form-group edit-btn">
                        <div class="col-sm-10 col-sm-offset-1">
                            <button class="btn" id="sure-edit" type="button" onclick="createNewClassmate()">确&nbsp;&nbsp;认&nbsp;&nbsp;修&nbsp;&nbsp;改</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <%--删除模态框--%>
    <div class="hidden" id="delete-modal">
        <div class="delete-modal-content center-block">
            <img src="<c:url value="/static/images/close2.png" />" alt="close" class="close" id="delete-close">
            <h2>是否删除此本同学录?</h2>
            <div class="alert alert-danger" role="alert" style="font-size: 1.3em">注意！此操作不可撤销</div>
            <button class="btn" type="button" id="sure-delete">确&nbsp;&nbsp;认&nbsp;&nbsp;删&nbsp;&nbsp;除</button>
        </div>
    </div>

</div>

<div class="classmate-detail-wrapper" id="classmate-detail-wrapper">
    <div class="container">
        <input id="paper-number" class="hidden"/>
        <div class="paper" id="paper">
            <input id="paper-id" class="hidden"/>
            <input id="author-id" class="hidden"/>

            <div class="paper-header" id="paper-header">
                <a href="javascript:void(0)"><img src="<c:url value="/static/images/avatar.png" />" alt="头像" id="avatar"
                                                  class="img-circle img-responsive avatar"></a>
                <a href="javascript:void(0)"><h3 id="author-name">&nbsp;</h3></a>
                <h6 id="create-time">&nbsp;</h6>
                <a href="javascript:void(0)"><img src="<c:url value="/static/images/delete_2.png" />" alt="删除"
                                                  id="delete2" data-toggle="tooltip" title="删除本页同学录"></a>
            </div>

            <div class="paper-content" id="paper-content">
                <p id="name">姓名：</p>
                <p id="nickname">昵称：</p>
                <p id="sex">性别：</p>
                <p id="birthday">生日：</p>
                <p id="address">能收到信的地方：</p>
                <p id="phone">常用电话：</p>
                <p id="email">邮箱：</p>
                <p id="qq">QQ：</p>
                <p id="wechat">微信：</p>
                <p id="fav-movie">最喜欢的电影：</p>
                <p id="fav-singer">最喜欢的歌手：</p>
                <p id="fav-book">最爱的书：</p>
                <p id="fav-travel-place">最想去的地方：</p>
                <p id="fav-thing-to-do">最想做的事情：</p>
                <p id="special-in-class">上课做过最奇葩的事情：</p>
                <p id="word-to-me">简单聊聊我吧：</p>

                <img id="photo" class="img-responsive" src="" alt="">
            </div>

            <a href="javascript:void(0)">
                <div class="col-sm-3 col-xs-3 navigation pre" id="pre">上一页</div>
            </a>
            <a href="<c:url value="/classmate/photoWall?classmateId=${classmateId}" />">
                <div class="col-sm-3 col-xs-3 navigation photo-wall" id="photo-wall">照片墙</div>
            </a>
            <a href="javascript:void(0)">
                <div class="col-sm-3 col-xs-3 navigation comment-wall" id="comment-wall">留言墙</div>
            </a>
            <a href="javascript:void(0)">
                <div class="col-sm-3 col-xs-3 navigation next" id="next">下一页</div>
            </a>
        </div>

        <%--留言墙--%>
        <div class="comment-wrapper hidden" id="comment-wrapper">
            <div class="comment-content">
                <div id="comment-header">
                    <h3>我要留言：</h3>
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="说点什么吧！" aria-describedby="sizing-addon1"
                               id="my-comment">
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="button" id="send-comment"
                                    onclick="sendComment()">发送留言</button>
                        </span>
                    </div>
                </div>
                <h4>精彩留言：</h4>
                <div id="other-comment-wrapper">

                </div>
            </div>
            <a href="javascript:void(0)">
                <div class="col-sm-3 col-xs-3 navigation pre" id="comment-pre">上一页</div>
            </a>
            <a href="<c:url value="/classmate/photoWall?classmateId=${classmateId}" />">
                <div class="col-sm-3 col-xs-3 navigation photo-wall" id="comment-photo-wall">照片墙</div>
            </a>
            <a href="javascript:void(0)">
                <div class="col-sm-3 col-xs-3 navigation comment-wall" id="comment-comment-wall">留言墙</div>
            </a>
            <a href="javascript:void(0)">
                <div class="col-sm-3 col-xs-3 navigation next" id="comment-next">下一页</div>
            </a>
        </div>
    </div>
</div>

<script src="<c:url value="/static/js/jquery-3.2.1.js" />"></script>
<script src="<c:url value="/static/js/bootstrap.min.js" />"></script>
<script src="<c:url value="/static/js/common.js" />"></script>
<script src="<c:url value="/static/js/classmatedetail.js" />"></script>
</body>
</html>