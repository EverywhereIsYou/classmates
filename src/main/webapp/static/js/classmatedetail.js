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
                    var desc=classmate.description;
                    if(desc===null||desc===''){
                        desc=' ';
                    }
                    classmateHeader(classmate.name,classmate.school+' '+classmate.clazz,desc);

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

function classmateHeader(name,school_clazz,desc){
    $("#classmate-name").text(name);
    $("#school-class").text(school_clazz);
    $("#classmate-desc").text(desc);
    $("title").text(name+"_一起同过窗");
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

    $(".classmate-detail-wrapper").css("height",$("#paper").height()+300+"px");
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

    $(".classmate-detail-wrapper").css("height",$("#paper").height()+300+"px");
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

    $(".classmate-detail-wrapper").css("height",$("#comment-wrapper").height()+300+"px");
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

    $("#paper").addClass("hidden");

    setComments();

    commentWrapper.removeClass("hidden").addClass("show");
    $(".classmate-detail-wrapper").css("height",commentWrapper.height()+300+"px");
    $("html,body").animate({scrollTop: $("#classmate-detail-wrapper").offset().top}, 1000);

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