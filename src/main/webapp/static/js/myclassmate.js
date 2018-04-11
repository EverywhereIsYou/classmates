var classmateBgColor = ["rgba(95,77,147,1)","rgba(126,87,143,1)","rgba(161,97,138,1)","rgba(203,111,133,1)","rgba(227,118,130,1)"];
var a = 0;
var b = 1;       //a的下一个取值
var OffOn = 0;   //用于判断梯形的开口方向，0为大口向右
var dir = true;  //用于来回循环

// footer的背景颜色
$("footer").css("background-color",classmateBgColor[0]);

$("#new-classmate").click(function(){

});

function createClassmate(id,name,school,clazz,desc,cover) {
    if (OffOn === 0) {
        $("#classmate-wrapper").append("<div data-classmateId='"+id+"' class='my-classmate' id='my-classmate-"+b+"' style='background-color:"+classmateBgColor[a]+"'><div class='container'><div class='col-sm-8 col-xs-8' style='text-align: right;'><h1>"+name+"</h1><h4>"+school+" "+clazz+"</h4><div id='liner'></div><h3>"+desc+"</h3></div><div class='col-sm-4 col-xs-4 classmate-cover'><img src='"+cover+"' alt='图' class='img-circle' id='classmate-cover-1' ></div></div></div><div class='create' id='create"+b+"' style='border-right:"+$(window).width()+"px solid "+classmateBgColor[a]+";border-bottom:100px solid "+classmateBgColor[b]+";'></div>");
        OffOn = 1;
    }else{
        $("#classmate-wrapper").append("<div data-classmateId='"+id+"' class='my-classmate' id='my-classmate-"+b+"' style='background-color:"+classmateBgColor[a]+"'><div class='container'><div class='col-sm-4 col-xs-4 classmate-cover'><img src='"+cover+"' alt='图' class='img-circle' id='classmate-cover-1' ></div><div class='col-sm-8 col-xs-8' style='text-align: left;'><h1>"+name+"</h1><h4>"+school+" "+clazz+"</h4><div id='liner'></div><h3>"+desc+"</h3></div></div></div><div class='create' id='create"+b+"' style='border-left:"+$(window).width()+"px solid "+classmateBgColor[a]+";border-bottom:100px solid "+classmateBgColor[b]+";'></div>");
        OffOn = 0;
    }

    $("footer").css("background-color",classmateBgColor[b]);
    getwidth();
    if (dir) {
        a++;
        b++;
        if (a === 4) {
            dir = false;
            b = 3;  //a为4时，a的下一个取值是3
        }
    }else{
        a--;
        b--;
        if (a === 0) {
            dir = true;
            b = 1;  //a为0时，a的下一个取值是1
        }
    }
}

function getwidth(){
    $("#wrapper").css("height",$(window).height()+100+"px");
    $("#wrapper").css("width",$(window).width()+"px");

    $(".create").css("width",$(window).width()+"px");
    $(".my-classmate").css("width",$(window).width()+"px");

    $("#create0").css("border-left",$(window).width()+"px solid rgba(0,0,0,0)");
    $("#create0").css("border-bottom","100px solid "+classmateBgColor[0]);

    $("#my-classmate-1").css("background-color",classmateBgColor[0]);
    $("#create1").css("border-right",$(window).width()+"px solid "+classmateBgColor[0]);
    $("#create1").css("border-bottom","100px solid "+classmateBgColor[1]);

    $("#my-classmate-2").css("background-color",classmateBgColor[1]);
    $("#create2").css("border-left",$(window).width()+"px solid "+classmateBgColor[1]);
    $("#create2").css("border-bottom","100px solid "+classmateBgColor[2]);

    $("#my-classmate-3").css("background-color",classmateBgColor[2]);
    $("#create3").css("border-right",$(window).width()+"px solid "+classmateBgColor[2]);
    $("#create3").css("border-bottom","100px solid "+classmateBgColor[3]);

    $("#my-classmate-4").css("background-color",classmateBgColor[3]);
    $("#create4").css("border-left",$(window).width()+"px solid "+classmateBgColor[3]);
    $("#create4").css("border-bottom","100px solid "+classmateBgColor[4]);

    $("#my-classmate-5").css("background-color",classmateBgColor[4]);
    $("#create5").css("border-right",$(window).width()+"px solid "+classmateBgColor[4]);
    $("#create5").css("border-bottom","100px solid "+classmateBgColor[3]);

    // 截取h3内容并加以省略号显示
    $(".my-classmate h3").each(function(){
        if ($(window).width()>=630) {
            if ($(this).text().length>100) {
                $(this).attr("value",$(this).text());
                //获取h3的值,进行截取。赋值给text变量保存.
                var text=$(this).text().substring(0,100)+"...";
                //重新为h3赋值;
                $(this).text(text);
            }
        }
        if ($(window).width()<630) {
            if ($(this).text().length>50) {
                $(this).attr("value",$(this).text());
                var text=$(this).text().substring(0,50)+"...";
                $(this).text(text);
            }
        }
    });
}

//菜单框弹出与退出
$("#menu").click(function(){
    $(".menu-content").addClass("menu-content-in");
    $("#menu-wrapper").css("display","block");
});
$("#menu-wrapper").click(function(){
    // 阻止事件冒泡到#menu-wrapper上
    if (event.target === this) {
        $(".menu-content").removeClass("menu-content-in");
        $("#menu-wrapper").css("display","none");
    }
});
$("#close").click(function(){
    $(".menu-content").removeClass("menu-content-in");
    $("#menu-wrapper").css("display","none");
});

// js加载完成后立即执行一次
$(function () {
    getwidth();

    $.ajax({
        type:'POST',
        url:'/classmate/myclassmates',
        success:function (data) {
            console.log(data);
            if(data!==null&&data!==""){
                if(data.statusCode===200){
                    $.each(data.extend.classmates,function (index,item) {
                        var desc=item.desc;
                        var cover=item.cover;
                        if(desc===null){
                            desc="说点什么，让同学了解它吧。";
                        }
                        if(cover===null){
                            cover="/static/images/classmate_cover.jpg";
                        }
                        createClassmate(item.id,item.name,item.school,item.clazz,desc,cover);
                    });
                }
                else {
                    // TODO 请求失败执行的操作
                    alert(data.msg);
                }
            }
        }
    });
});

// 每次改变浏览器窗口都执行一次
$(window).resize(function(){
    getwidth();
});

