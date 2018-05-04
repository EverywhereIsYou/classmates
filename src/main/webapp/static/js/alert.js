//弹出自定义提示窗口
var showAlert= function(msg){
    //弹框存在
    if ( $(".alert_box").length > 0) {
        $('#alert-msg').html(msg);
    }
    else {
        var alertHtml =
            '<div class="alert-box hidden">\n' +
            '    <div class="alert-content text-center">\n' +
            '        <div class="alert-body">\n' +
            '            <p id="alert-msg">'+msg+'</p>\n' +
            '        </div>\n' +
            '    </div>\n' +
            '</div>';

        $("body").append(alertHtml);
    }

    $(".alert-box").removeClass("hidden").removeClass("alert-box-out").addClass("show").addClass("alert-box-in");
    $(".alert-content").removeClass("alert-content-out").addClass("alert-content-in");

    //3s后弹框消失
    setTimeout(function () {
        $(".alert-content").removeClass("alert-content-in").addClass("alert-content-out");
        $(".alert-box").removeClass("alert-box-in").removeClass("show").addClass("alert-box-out");
    },3000);

    $(".alert-box").on("webkitAnimationEnd", function() {
        if ($(".alert-box").hasClass("alert-box-out")){
            $(".alert-box").addClass("hidden");
        }
    });

    //点击罩层后立即消失
    $(".alert-box").click(function () {
        // 阻止事件冒泡到.alert-content上
        if (event.target === this) {
            $(".alert-box").removeClass("alert-box-in").removeClass("show").addClass("hidden").addClass("alert-box-out");
        }
    });

};

//重定义alert
window.alert=showAlert;
