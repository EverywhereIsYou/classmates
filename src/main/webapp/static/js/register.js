$("input").focus(function () {
    $(this).addClass("glowing");
});
$("input").blur(function () {
    $(this).removeClass("glowing");
});

$("footer a").focus(function () {
    $(this).css("text-decoration", "none");
    $(this).css("color", "#e67777");
});

$("form a").focus(function () {
    $(this).css("text-decoration", "none");
    $(this).css("color", "white");
});

$("#regest").click(function () {
    $.ajax({
        type: 'POST',
        url: "/register",
        data: $("#fm").serialize(),
        error: function (request) {
            alert(request.toString());
        },
        success: function (data) {
            alert(data.toString());
            window.location.href = "#";
        }
    });
});

$("#getDynamicCode").click(function () {
    var username=$("#username").val();
    $.ajax({
        type: 'POST',
        url: "/codeService/dynamicCode",
        data: {"username":username}
    });
});
