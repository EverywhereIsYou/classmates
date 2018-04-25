var classmate;

$(function () {
    $("#delete2").tooltip({
        placement: "auto bottom",
        delay: {show: 800, hide: 100},
        template: "<div class='tooltip'>" +
        "<div class=''></div>" +
        "<div class=''><h5 style='font-size: 1.1em;color: #d9534f;'>删除本页同学录</h5></div>" +
        "</div>"
    });

    getDetailInfo();
});

function getDetailInfo() {
    var data = {"classmateId":$("#classmate_id").val()};
    var result;

    $.ajax({
        type:'POST',
        url:'/classmate/classmateDetail',
        data:data,
        success:function (data) {
            console.log(data);
            if(data.statusCode===200){
                classmate=data.extend.classmate;
                if(classmate!==undefined&&classmate!=null){
                    classmateHeader();

                    if(classmate.papers===null||classmate.papers.length===0){
                        setEmptyPaper();
                    }
                    else {
                        setPaper(0);
                    }
                }
            }
            else{
                // TODO 请求数据失败的提示
                alert(data.msg);
            }
        }
    });

    $(".classmate-detail-wrapper").css("height",$("#paper").height()+300+"px");
}

function classmateHeader(){
    $("#classmate-name").text(classmate.name);
    $("#school-class").text(classmate.school+" "+classmate.clazz);
    if(classmate.description===null||classmate.description===''){
        $("#classmate-desc").text(" ");
    }
    else {
        $("#classmate-desc").text(classmate.description);
    }
    $("title").text(classmate.name+"_一起同过窗");
}

function setEmptyPaper() {
    $("#paper-number").text(0);

    $("#paper-header").html($("<p></p>",{
        class:"text-center",
        text:"暂时没有同学填写，邀请同学来填写吧"
    }));
    $("#paper-content").html("");

    $("#paper").removeClass("hidden").addClass("show");
    $("#comment-wrapper").addClass("hidden").removeClass("show");
}

function setPaper(number) {
    if(number<0||number>=classmate.papers.length){
        return;
    }
    var paper=classmate.papers[number];

    $("#paper-number").text(number);
    $("#paper-id").text(paper.id);
    $("#author-id").text(paper.authorId);

    var authorName=paper.authorName;
    if(authorName===null||authorName===''){
        authorName=paper.name;
    }
    if(authorName===null||authorName===''){
        authorName='游客';
    }
    $("#author-name").text(authorName);

    var authorAvatar=paper.authorAvatar;
    if(authorAvatar===null||authorAvatar===''){
        authorAvatar='/static/images/avatar.png';
    }
    $("#avatar").attr("src",authorAvatar);

    $("#create-time").text("填写于 "+paper.createTime);

    $("#name").text("姓名："+paper.name);
    $("#nickname").text("昵称："+paper.nickname);
    $("#sex").text("性别："+paper.sex);
    $("#birthday").text("生日："+paper.birthday);
    $("#address").text("能收到信的地方："+paper.address);
    $("#phone").text("常用电话："+paper.phone);
    $("#email").text("邮箱："+paper.email);
    $("#qq").text("QQ："+paper.qq);
    $("#wechat").text("微信："+paper.wechat);
    $("#fav-movie").text("最喜欢的电影："+paper.favMovie);
    $("#fav-singer").text("最喜欢的歌手："+paper.favSinger);
    $("#fav-book").text("最爱的书："+paper.favBook);
    $("#fav-travel-place").text("最想去的地方："+paper.favTravelPlace);
    $("#fav-thing-to-do").text("最想做的事情："+paper.favThingToDo);
    $("#special-in-class").text("上课做过最奇葩的事情："+paper.specialInClass);
    $("#word-to-me").text("简单聊聊我吧："+paper.wordToMe);

    $("#paper").removeClass("hidden").addClass("show");
    $("#comment-wrapper").addClass("hidden").removeClass("show");
}

function setComments() {
    if(classmate===undefined||classmate===null){
        alert("没有查询到该同学录数据");
        return;
    }

    var comments=classmate.comments;
    if(comments!=null||comments.length!==0){
        $("#other-comment-wrapper").html("");
        $.each(comments,function (index,item) {
            var comment=$("<div class='comment'></div>");

            var avatarAddress=item.authorAvatar;
            if(avatarAddress===undefined||avatarAddress===null||avatarAddress===''){
                avatarAddress="/static/images/avatar.png";
            }
            var liner=$("<div class='liner'></div>");
            var avatar=$("<a href='#'></a>").append($("<img src='"+avatarAddress+"' alt='头像' class='img-circle img-responsive comment-avatar'>"));
            var commentContent=$("<div class='other-comment'></div>");

            var authorName=$("<a href='#'></a>").append($("<h4 class='write-author'>"+item.authorName+"</h4>"));
            var content=$("<p class='write-content'>"+item.content+"</p>");
            var commentTime=$("<p class='write-time'>"+item.createTime+"</p>");

            commentContent.append(avatar).append(authorName).append(content).append(commentTime);
            comment.append(liner).append(commentContent).appendTo($("#other-comment-wrapper"));
        });
    }
    else{
        $("#other-comment-wrapper").html($("<p></p>",{
            class:"text-center",
            text:"暂时没有留言，说点什么吧"
        }));
    }

    $("#paper").addClass("hidden").removeClass("show");
    $("#comment-wrapper").removeClass("hidden").addClass("show");

    $(".classmate-detail-wrapper").css("height",$("#comment-wrapper").height()+300+"px");
    $("html,body").animate({scrollTop: $("#classmate-detail-wrapper").offset().top}, 1000);
}

$(".mousedown").click(function () {
    $("html,body").animate({scrollTop: $("#classmate-detail-wrapper").offset().top}, 1000);
});

$(".pre").click(function () {
    if(classmate===undefined||classmate===null){
        alert("没有查询到该同学录数据");
        return;
    }

    var paperNumber=parseInt($("#paper-number").text());
    if(paperNumber===0){
        alert("已经是第一页了");
        return;
    }

    if(classmate.papers.length===0){
        setEmptyPaper();
    }
    else{
        setPaper(paperNumber-1);
    }

    $(".classmate-detail-wrapper").css("height",$("#paper").height()+300+"px");
    $("html,body").animate({scrollTop: $("#classmate-detail-wrapper").offset().top}, 1000);
});

$(".next").click(function () {
    if(classmate===undefined||classmate===null){
        alert("没有查询到该同学录数据");
        return;
    }

    var paperNumber=parseInt($("#paper-number").text());
    if(paperNumber===classmate.papers.length-1){
        $("#comment-wall").trigger("click");
        return;
    }

    if(classmate.papers.length===0){
        if(paperNumber===0){
            $("#comment-wall").trigger("click");
        }
        else{
            alert("已经是最后一页了");
        }
        return;
    }

    if(paperNumber===classmate.papers.length){
        alert("已经是最后一页了");
        return;
    }

    setPaper(paperNumber+1);

    $(".classmate-detail-wrapper").css("height",$("#paper").height()+300+"px");
    $("html,body").animate({scrollTop: $("#classmate-detail-wrapper").offset().top}, 1000);
});

//留言墙功能
$(".comment-wall").click(function () {
    if(classmate===undefined||classmate===null){
        alert("没有查询到该同学录数据");
        return;
    }
    var commentWrapper = $("#comment-wrapper");
    if(commentWrapper.hasClass("show")){
        alert("当前已在留言墙页咯");
        return;
    }

    $("#paper-number").text(Math.max(classmate.papers.length,1));

    setComments();
});
//点击发送留言
function sendComment() {
    var sendCommentBtn=$("#send-comment");
    sendCommentBtn.attr("disabled",true);
    sendCommentBtn.text("正在留言");

    var writeContent=$("#my-comment");
    if(writeContent.val()===null||writeContent.val()===''){
        alert("请输入留言内容");
        return;
    }

    $.post("/classmate/writeComment",{"commentContent":writeContent.val(),"classmateId":classmate.id},function (data) {
        if(data.statusCode===200){
            var comments=data.extend.comments;
            if(comments!==undefined&&comments!==null&&comments.length>0){
                classmate.comments=comments;
                setComments();
            }

            writeContent.val("");
        }
        else if(data.statusCode===400){
            alert(data.msg);
        }
        else{
            alert("网络错误，请稍后重试");
        }

        sendCommentBtn.attr("disabled",false);
        sendCommentBtn.text("发送留言");
    });
}

//邀请同学填写模态框
$(".invite").click(function () {
    $.post("/classmate/inviteLink",{"classmateId":classmate.id},function (data) {
        if(data.statusCode===200){
            var url=data.extend.url;
            if(url!==undefined&&url!==null&&url!==''){
                $("#write-address").text(url);
                $("#qr-code").attr("src","/codeService/QRCode?url="+url);
            }
            else{
                alert("生成链接错误，请稍后重试");
            }
        }
        else if(data.statusCode===400){
            alert(data.msg);
        }
        else{
            alert("网络错误，请稍后重试");
        }
    });

    $("#invite-modal").removeClass("hidden").addClass("show");
    $(".invite-modal-content").addClass("invite-modal-content-in");
});
$("#invite-close").click(function () {
    $("#invite-modal").removeClass("show").addClass("hidden");
});

//点击复制功能
function  copy() {
    var text = $("#write-address").html();
    var address = $("#write-address-input");
    address.val(text); // 修改文本框的内容
    address.select(); //选择对象
    document.execCommand("Copy"); //执行浏览器复制命令
    alert(address.val());
}

//编辑同学录框的弹出与退出
$(".edit").click(function () {
    $("#preview").attr("src",classmate.cover);
    $("#classmatename").val(classmate.name);
    $("#school").val(classmate.school);
    $("#clazz").val(classmate.clazz);
    $("#description").val(classmate.description);

    $(".edit-myclassmate-wrapper").removeClass("hidden").addClass("show");
    $(".edit-myclassmate-content").addClass("edit-myclassmate-content-in");
});
$("#edit-myclassmate-close").click(function () {
    $(':input','#myclassmate-fm')
        .not(':button, :submit, :reset, :hidden')
        .val('')
        .removeAttr('checked')
        .removeAttr('selected');
    $("#preview").attr("src","");
    $(".edit-myclassmate-wrapper").removeClass("show").addClass("hidden");
    $(".edit-myclassmate-content").removeClass("edit-myclassmate-content-in");
});

function modifyClassmate() {
    var confirmModifyBtn=$("#sure-edit");
    confirmModifyBtn.attr("disabled",true);
    confirmModifyBtn.html("正&nbsp;&nbsp;在&nbsp;&nbsp;修&nbsp;&nbsp;改");

    var imgAddress=$("#preview")[0].src;
    if(imgAddress===classmate.cover||(imgAddress===""&&classmate.cover===null)){
        modifyClassmateData(null);
    }
    else {
        var imageData=new FormData($("#myclassmate-fm")[0]);
        $.ajax({
            url:"/file/classmateCover",
            data:imageData,
            type:'POST',
            processData:false,
            contentType:false,
            error:function () {
                modifyClassmateData(null);
                alert("上传同学录封面失败");
            },
            success:function (data) {
                if(data.statusCode===200){
                    modifyClassmateData(data.extend.fileName);
                }
                else{
                    modifyClassmateData(null);
                    alert(data.msg);
                }
            }
        });
    }
}
function modifyClassmateData(coverName) {
    var contentData;

    var classmateName=$("#classmatename").val();
    var school=$("#school").val();
    var clazz=$("#clazz").val();
    var description=$("#description").val();

    contentData={
        "id":classmate.id,
        "cover":coverName,
        "name":classmateName,
        "school":school,
        "clazz":clazz,
        "description":description
    };


    $.post("/classmate/updateClassmate",contentData,function (data) {
        if(data.statusCode===200){
            alert("同学录修改成功");
            $("#edit-myclassmate-close").trigger("click");

            classmate.name=classmateName;
            classmate.school=school;
            classmate.clazz=clazz;
            classmate.description=description;
            if(coverName!=null){
                classmate.cover=coverName;
            }

            classmateHeader();
        }
        else if(data.statusCode===400){
            alert(data.msg);
        }
        else{
            alert("网络错误，请稍后重试");
        }
    });

    var confirmModifyBtn=$("#sure-edit");
    confirmModifyBtn.attr("disabled",false);
    confirmModifyBtn.html("确&nbsp;&nbsp;认&nbsp;&nbsp;修&nbsp;&nbsp;改");
}

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
        img.css("max-width","200px");
        img.css("max-height","200px");
    };
    reader.readAsDataURL(file);
}

//删除模态框的弹出与关闭
$(".delete").click(function () {
    $("#delete-modal").removeClass("hidden").addClass("show");
    $(".delete-modal-content").addClass("delete-modal-content-in");
});
$("#delete-close").click(function () {
    $("#delete-modal").removeClass("show").addClass("hidden");
});
$("#delete-modal").click(function(){
    // 阻止事件冒泡到.delete-modal-content上
    if (event.target === this) {
        $(".delete-modal-content").removeClass("menu-content-in");
        $("#delete-modal").removeClass("show").addClass("hidden");
    }
});

//删除同学录详情页模态框的弹出与关闭
$("#delete2").click(function () {
    $("#paper-delete-modal").removeClass("hidden").addClass("show");
    $(".delete-modal-content").addClass("delete-modal-content-in");
});
$("#paper-delete-close").click(function () {
    $("#paper-delete-modal").removeClass("show").addClass("hidden");
});
$("#paper-delete-modal").click(function(){
    // 阻止事件冒泡到.delete-modal-content上
    if (event.target === this) {
        $(".delete-modal-content").removeClass("menu-content-in");
        $("#paper-delete-modal").removeClass("show").addClass("hidden");
    }
});

function confirmDeleteClassmate() {
    var deleteBtn=$("#sure-delete");
    deleteBtn.attr("disabled",true);
    deleteBtn.html("正&nbsp;&nbsp;在&nbsp;&nbsp;删&nbsp;&nbsp;除");

    $.post("/classmate/deleteClassmate",{"classmateId":classmate.id},function (data) {
        if(data.statusCode===200){
            alert("删除成功");
            $(location).attr("href","/classmate/myclassmates");
        }
        else if(data.statusCode===400){
            alert(data.msg);
        }
        else{
            alert("网络错误，请稍后重试");
        }

        deleteBtn.attr("disabled",false);
        deleteBtn.html("确&nbsp;&nbsp;认&nbsp;&nbsp;删&nbsp;&nbsp;除");
    });
}

function confirmDeletePaper() {
    var deleteBtn=$("#paper-delete");
    deleteBtn.attr("disabled",true);
    deleteBtn.html("正&nbsp;&nbsp;在&nbsp;&nbsp;删&nbsp;&nbsp;除");

    $.post("/classmate/deletePaper",{"paperId":$("#paper-id").text()},function (data) {
        if(data.statusCode===200){
            alert("删除成功");
            $("#paper-delete-close").trigger("click");

            var papers=data.extend.papers;
            if(papers===undefined||papers===null||papers.length===0){
                classmate.papers=null;
                setEmptyPaper();
            }
            else {
                classmate.papers=papers;
                setPaper(Math.max(parseInt($("#paper-number").text())-1,0));
            }
        }
        else if(data.statusCode===400){
            alert(data.msg);
        }
        else{
            alert("网络错误，请稍后重试");
        }

        deleteBtn.attr("disabled",false);
        deleteBtn.html("确&nbsp;&nbsp;认&nbsp;&nbsp;删&nbsp;&nbsp;除");
    });
}