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
                    var desc=classmate.desc;
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

$("#comment-wall").click(function () {
    getComments();
});