function getwidth() {
    $("#wrapper").css("height", $(window).height() + "px").css("width", $(window).width() + "px");
}

// js加载完成后立即执行一次
$(function () {
    getwidth();
});
// 每次改变浏览器窗口都执行一次
$(window).resize(function(){
    getwidth();
});

//菜单框弹出与关闭
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