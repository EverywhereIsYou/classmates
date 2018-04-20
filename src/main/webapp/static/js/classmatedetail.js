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

    $(".classmate-detail-wrapper").css("height",$("#paper").height()+300+"px");
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
                        $("#paper-header").html($("<p></p>",{
                            class:"text-center",
                            text:"暂时没有同学填写，邀请同学来填写吧"
                        }));
                        $("#paper-content").html("");
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
}

function classmateHeader(name,school_clazz,desc){
    $("#classmate-name").text(name);
    $("#school-class").text(school_clazz);
    $("#classmate-desc").text(desc);
    $("title").text(name+"_一起同过窗");
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
}

function getComments() {
    if(classmate===undefined||classmate===null){
        alert("没有查询到该同学录数据");
        return;
    }
    $("#paper-number").text(classmate.papers.length);
    alert("comments");
}

$(".mousedown").click(function () {
    $("html,body").animate({scrollTop: $("#classmate-detail-wrapper").offset().top}, 1000);
});

$("#pre").click(function () {
    if(classmate===undefined||classmate===null){
        alert("没有查询到该同学录数据");
        return;
    }
    if(classmate.papers.length===0){
        alert("还没有同学填写该同学录");
        return;
    }
    var paperNumber=parseInt($("#paper-number").text());
    if(paperNumber===0){
        alert("已经是第一页了");
        return;
    }
    setPaper(paperNumber-1);
    $("html,body").animate({scrollTop: $("#classmate-detail-wrapper").offset().top}, 1000);
});

$("#next").click(function () {
    if(classmate===undefined||classmate===null){
        alert("没有查询到该同学录数据");
        return;
    }
    if(classmate.papers.length===0){
        alert("还没有同学填写该同学录");
        return;
    }
    var paperNumber=parseInt($("#paper-number").text());
    if(paperNumber===classmate.papers.length-1){
        getComments();
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

$("#comment-wall").click(function () {
    getComments();
    $("#paper").addClass("hidden");

    var commentWrapper = $("#comment-wrapper");
    commentWrapper.removeClass("hidden").addClass("show");
    $(".classmate-detail-wrapper").css("height",commentWrapper.height()+300+"px");
    $("html,body").animate({scrollTop: $("#classmate-detail-wrapper").offset().top}, 1000);

});
//点击发送留言
function sendComment() {
// <div class="comment">
//     <div class="liner"></div>
//     <a href="#">
//         <img src="<c:url value="/static/images/avatar.png" />" alt="头像" class="img-circle img-responsive comment-avatar">
//     </a>
//     <div class="other-comment">
//         <a href="#"><h4 class="write-author">李四：</h4></a>
//         <p class="write-content">如果你无法简洁的表达你的想法，那只说明你还不够了解它。如果你无法简洁的表达你的想法，那只说明你还不够了解它。如果你无法简洁的表达你的想法，那只说明你还不够了解它。如果你无法简洁的表达你的想法，那只说明你还不够了解它。
//         </p>
//         <p class="write-time">2018-4-18</p>
//     </div>
// </div>
    var commentDiv = $("<div></div>",{class: "comment"});
    var linerDiv = $("<div></div>",{class: "liner"});
    var A = $("<a></a>",{href: "#"});
    var avatarImg = $("<img>",{
        src: "/static/images/avatar.png",
        class: "img-circle img-responsive comment-avatar",
        alt: "头像"
    });
    var otherCommentDiv = $("<div></div>",{class: "other-comment"});
    var writeAuthorH4 = $("<h4></h4>",{class: "write-author",text: "李四："});
    var writeContent = $("#my-comment").val();
    var writeContentP = $("<p></p>",{
        class: "write-content",
        text: writeContent
    });
    var nowTime = new Date();
    var nowYear = nowTime.getFullYear();
    var nowMonth = nowTime.getMonth()+1;
    var nowDay = nowTime.getDate();
    var writeTimeP = $("<p></p>",{
        class: "write-time",
        text: nowMonth+"月"+nowDay+"日"+nowYear+"年"
    });
    if (writeContent != "" && writeContent != null){
        var otherCommentWrapper = $("#other-comment-wrapper");
        var oldHtml = otherCommentWrapper.html();  //将之前的html内容存起来
        otherCommentWrapper.html("");
        otherCommentWrapper.append(commentDiv
            .append(linerDiv)
            .append(A.append(avatarImg))
            .append(otherCommentDiv
                .append(A.append(writeAuthorH4))
                .append(writeContentP)
                .append(writeTimeP)
            )
        ).append(oldHtml);

        $("#my-comment").val("");
    }
    else {
        alert("请输入内容");
    }

    $(".classmate-detail-wrapper").css("height",$("#comment-wrapper").height()+300+"px");
}

//邀请同学填写模态框
$(".invite").click(function () {
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