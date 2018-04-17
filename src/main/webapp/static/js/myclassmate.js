var classmateBgColor = ["rgba(95,77,147,1)", "rgba(126,87,143,1)", "rgba(161,97,138,1)", "rgba(203,111,133,1)", "rgba(227,118,130,1)"];
var direction = ["right", "left"];
var a = 0;
var b = 1;       //a的下一个取值
var OffOn = 0;   //用于判断梯形的开口方向，0为大口向右
var dir = true;  //用于来回循环

// footer的背景颜色
$("footer").css("background-color", classmateBgColor[0]);

function createClassmate(id, name, school, clazz, desc, cover) {
    var myClassmate = $("<div></div>", {
        class: 'my-classmate',
        id: 'my-classmate-' + b,
        style: 'background-color:' + classmateBgColor[a]
    });
    var myClassmateContainer = $("<div></div>", {class: 'container'});
    var myClassmateInfo = $("<div></div>", {
        class: 'col-sm-8 col-xs-8',
        style: 'text-align: ' + direction[OffOn]
    });
    var toClassmateDetail=$("<a></a>",{
        href:'/classmate/classmateDetail?classmateId='+id,
        style:'text-decoration: none;'
    });
    var toClassmateDetailImage=$("<a></a>",{href:'/classmate/classmateDetail?classmateId='+id});
    var myClassmateName = $("<h1></h1>", {text: name});
    var schoolAndClass = $("<h4></h4>", {text: school + ' ' + clazz});
    var liner = $("<div></div>", {id: 'liner'});
    var description = $("<h3></h3>", {text: desc});
    var classmateCover = $("<div></div>", {
        class: 'col-sm-4 col-xs-4 classmate-cover'
    });
    var coverImage = $("<img>", {
        class: 'img-circle',
        id: 'classmate-cover-1',
        alt: '封面',
        src: cover
    });
    var create = $("<div></div>", {
        class: 'create',
        id: 'create' + b,
        style: 'border-' + direction[OffOn] + ':' + $(window).width() + 'px solid ' + classmateBgColor[a],
        style: 'border-bottom:100px solid ' + classmateBgColor[b]
    });
    if (OffOn === 0) {
        toClassmateDetail.append(myClassmateName).append(schoolAndClass).append(liner).append(description).appendTo(myClassmateInfo);
        toClassmateDetailImage.append(coverImage).appendTo(classmateCover);
        myClassmateContainer.append(myClassmateInfo).append(classmateCover).appendTo(myClassmate);
        $("#classmate-wrapper").append(myClassmate).append(create);
        OffOn = 1;
    } else {
        toClassmateDetail.append(myClassmateName).append(schoolAndClass).append(liner).append(description).appendTo(myClassmateInfo);
        toClassmateDetailImage.append(coverImage).appendTo(classmateCover);
        myClassmateContainer.append(classmateCover).append(myClassmateInfo).appendTo(myClassmate);
        $("#classmate-wrapper").append(myClassmate).append(create);
        OffOn = 0;
    }

    $("footer").css("background-color", classmateBgColor[b]);
    getwidth();
    if (dir) {
        a++;
        b++;
        if (a === 4) {
            dir = false;
            b = 3;  //a为4时，a的下一个取值是3
        }
    } else {
        a--;
        b--;
        if (a === 0) {
            dir = true;
            b = 1;  //a为0时，a的下一个取值是1
        }
    }
}

//获取浏览器的宽度，确定三角形的宽度，根据区域大小改变文字数量。
function getwidth() {
    $("#wrapper").css("height", $(window).height() + 100 + "px");
    $("#wrapper").css("width", $(window).width() + "px");

    $(".create").css("width", $(window).width() + "px");
    $(".my-classmate").css("width", $(window).width() + "px");

    $("#create0").css("border-left", $(window).width() + "px solid rgba(0,0,0,0)");
    $("#create0").css("border-bottom", "100px solid " + classmateBgColor[0]);

    $("#my-classmate-1").css("background-color", classmateBgColor[0]);
    $("#create1").css("border-right", $(window).width() + "px solid " + classmateBgColor[0]);
    $("#create1").css("border-bottom", "100px solid " + classmateBgColor[1]);

    $("#my-classmate-2").css("background-color", classmateBgColor[1]);
    $("#create2").css("border-left", $(window).width() + "px solid " + classmateBgColor[1]);
    $("#create2").css("border-bottom", "100px solid " + classmateBgColor[2]);

    $("#my-classmate-3").css("background-color", classmateBgColor[2]);
    $("#create3").css("border-right", $(window).width() + "px solid " + classmateBgColor[2]);
    $("#create3").css("border-bottom", "100px solid " + classmateBgColor[3]);

    $("#my-classmate-4").css("background-color", classmateBgColor[3]);
    $("#create4").css("border-left", $(window).width() + "px solid " + classmateBgColor[3]);
    $("#create4").css("border-bottom", "100px solid " + classmateBgColor[4]);

    $("#my-classmate-5").css("background-color", classmateBgColor[4]);
    $("#create5").css("border-right", $(window).width() + "px solid " + classmateBgColor[4]);
    $("#create5").css("border-bottom", "100px solid " + classmateBgColor[3]);

    // 截取h3内容并加以省略号显示
    $(".my-classmate h3").each(function () {
        if ($(window).width() >= 630) {
            if ($(this).text().length > 100) {
                $(this).attr("value", $(this).text());
                //获取h3的值,进行截取。赋值给text变量保存.
                var text = $(this).text().substring(0, 100) + "...";
                //重新为h3赋值;
                $(this).text(text);
            }
        }
        if ($(window).width() < 630) {
            if ($(this).text().length > 50) {
                $(this).attr("value", $(this).text());
                var text = $(this).text().substring(0, 50) + "...";
                $(this).text(text);
            }
        }
    });
}

//菜单框弹出与退出
$("#menu").click(function () {
    $(".menu-content").addClass("menu-content-in");
    $("#menu-wrapper").css("display", "block");
});
$("#menu-wrapper").click(function () {
    // 阻止事件冒泡到#menu-wrapper上
    if (event.target === this) {
        $(".menu-content").removeClass("menu-content-in");
        $("#menu-wrapper").css("display", "none");
    }
});
$("#close").click(function () {
    $(".menu-content").removeClass("menu-content-in");
    $("#menu-wrapper").css("display", "none");
});

//创建同学录框的弹出与退出
$("#create-myclassmate").click(function () {
    $(".create-myclassmate-wrapper").removeClass("hidden").addClass("show");
    $(".create-myclassmate-content").addClass("create-myclassmate-content-in");
});
$("#create-myclassmate-close").click(function () {
    $(':input','#myclassmate-fm')
        .not(':button, :submit, :reset, :hidden')
        .val('')
        .removeAttr('checked')
        .removeAttr('selected');
    $("#preview").attr("src","");
    $(".create-myclassmate-wrapper").removeClass("show").addClass("hidden");
    $(".create-myclassmate-content").removeClass("create-myclassmate-content-in");
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

// 页面加载完成后立即执行一次
$(function () {
    getClassmates();
});

function getClassmates() {
    $("input").focus(function () {
        $(this).addClass("glowing");
    });
    $("input").blur(function () {
        $(this).removeClass("glowing");
    });

    getwidth();

    $.ajax({
        type: 'POST',
        url: '/classmate/myclassmates',
        success: function (data) {
            console.log(data);
            if (data !== null && data !== "") {
                if (data.statusCode === 200) {
                    init();
                    $.each(data.extend.classmates, function (index, item) {
                        var desc = item.description;
                        var cover = item.cover;
                        if (desc === null) {
                            desc = "说点什么，让同学了解它吧。";
                        }
                        if (cover === null) {
                            cover = "/static/images/classmate_cover.jpg";
                        }
                        createClassmate(item.id, item.name, item.school, item.clazz, desc, cover);
                    });
                }
                else {
                    // TODO 请求失败执行的操作
                    alert(data.msg);
                }
            }
        }
    });
}

function init() {
    a=0;
    b=1;
    OffOn = 0;
    fir=true;
    $("#classmate-wrapper").html('<div class="create" id="create0"></div>');
}

// 每次改变浏览器窗口都执行一次
$(window).resize(function () {
    getwidth();
});
//点击向下按钮，向下滑动到同学录
$(".mousedown").click(function () {
    $("html,body").animate({scrollTop: $("#new-classmate").offset().top}, 1000);
});

function createNewClassmate() {
    $.post("/classmate/createClassmate",$("#myclassmate-fm").serialize(),
        function (data) {
            console.log(data);
            if(data.statusCode===200){
                alert("同学录创建成功");
                $("#create-myclassmate-close").trigger("click");
                getClassmates();
            }
            else{
                alert(data.msg);
            }
        }
    );
}