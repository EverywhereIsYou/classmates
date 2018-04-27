$(".mousedown").click(function () {
    $("html,body").animate({scrollTop: $("#photo-wall-wrapper").offset().top}, 1000);
});

//获取照片墙背后div的高度
function photoWallWrapperHeight() {
    $("#photo-wall-wrapper").css("height", $(".photo-cntent").height() + 300 + "px");
}

photoWallWrapperHeight();
$(window).resize(function () {
    photoWallWrapperHeight();
});

//往照片墙动态添加照片
var a = 0;  //四个一循环，判断添加photoWrapper7还是photoWrapper5
var b = 0;  //用于添加照片上的颜色，photoColor的脚标
var c = 1;  //photo-wrapper的id
var photoColor = ["#d95252", "#db53ad", "#53dbb3", "#dbbd53", "#5653db", "#db8453", "#db53a5", "#97db53"];

function addTag7(photoAddress) {
    var photoWrapper7 = $("<div></div>", {
        class: "col-sm-7 photo-wrapper",
        id: "photo" + c
    });
    var photoA = $("<a></a>", {href: "javascript:void (0)"}); //套在照片外的a标签
    var myPhoto = $("<div></div>", {
        class: "myphoto",
        style: "background-image: url("+photoAddress+");"
    });
    var photoColorDiv = $("<div></div>", {
        class: "photo-color",
        style: "background-color: " + photoColor[b] + ";"
    });
    $(".photo-cntent").append(photoWrapper7.append(photoA.append(myPhoto.append(photoColorDiv))));
}

function addTag5(photoAddress) {
    var photoWrapper5 = $("<div></div>", {
        class: "col-sm-5 photo-wrapper",
        id: "photo" + c
    });
    var photoA = $("<a></a>", {href: "javascript:void (0)"}); //套在照片外的a标签
    var myPhoto = $("<div></div>", {
        class: "myphoto",
        style: "background-image: url("+photoAddress+");"
    });
    var photoColorDiv = $("<div></div>", {
        class: "photo-color",
        style: "background-color: " + photoColor[b] + ";"
    });
    $(".photo-cntent").append(photoWrapper5.append(photoA.append(myPhoto.append(photoColorDiv))));
}

function addPhoto(photoAddress) {
    if (b < photoColor.length) {
        if (a === 0) {
            addTag7(photoAddress);
            a = 1;
        }
        else if (a === 1) {
            addTag5(photoAddress);
            a = 2;
        }
        else if (a === 2) {
            addTag5(photoAddress);
            a = 3;
        }
        else if (a === 3) {
            addTag7(photoAddress);
            a = 0;
        }
        b++;
        c++;
        if (b === photoColor.length) {
            b = 0;
        }
    }
}

//图片放大全屏显示效果
var gifNumber = 1;   //动画类型，一共2种

function photoToLarge(photoAddress) {
    var largePhoto = $("#large-photo");
    var photoWidth = largePhoto.width();
    var photoHeight = largePhoto.height();
    largePhoto.attr("src",photoAddress);

    if (gifNumber === 1) {
        if (photoHeight <= $(window).height() || photoHeight > photoWidth) {
            largePhoto.css("height", 10 + "px")
                .removeClass("large-photo-3");
            largePhoto.stop().animate({
                height: $(window).height() - 100
            }, 1100, "swing");
        }
        else {
            largePhoto.css("width", 10 + "px")
                .removeClass("large-photo-3");
            largePhoto.stop().animate({
                width: $(window).width() - 200
            }, 1100, "swing");
        }
        gifNumber = 2;
    }
    else if (gifNumber === 2){
        if (photoHeight <= $(window).height() || photoHeight > photoWidth){
            largePhoto.css("height",$(window).height() - 100 + "px")
                .css("opacity","0")
                .removeClass("large-photo-3");
            largePhoto.stop().animate({
                opacity: "1"
            },1100,"swing");
        }
        else{
            largePhoto.css("width",$(window).width() - 200 + "px")
                .css("opacity","0")
                .removeClass("large-photo-3");
            largePhoto.stop().animate({
                opacity: "1"
            },1100,"swing");
        }
        gifNumber = 1;
    }
}

$("#photo-close").click(function () {
    $(".show-wrapper").removeClass("show").addClass("hidden");
});

$(function () {
    $.post("/classmate/photoWall",{"classmateId":$("#classmateId").val()},
        function (data) {
            if(data.statusCode===200){
                $("#classmate-name").text(data.extend.classmate.name);
                $("#classmate-shcool").text(data.extend.classmate.school+" "+data.extend.classmate.clazz);
                $("#classmate-description").text(data.extend.classmate.description);

                $("title").html(data.extend.classmate.name+"_一起同过窗");

                parsePhoto(data.extend.classmate.photoWall);
            }
            else if(data.statusCode===400){
                alert(data.msg);
            }
            else{
                alert("网络错误，请稍后重试");
            }
        });
});

function parsePhoto(data) {
    if(data!==undefined&&data!==null&&data!==''){
        $("#photo-area").html("");
    }
    else {
        return;
    }

    a=0;
    b=0;
    c=1;

    var photos=data.split("|");
    $.each(photos,function (index,item) {
        addPhoto(item);
    });
    $(".myphoto").click(function () {
        $(".show-wrapper").removeClass("hidden").addClass("show");
        var url=$(this).css('background-image');
        photoToLarge(url.split('"')[1].split('"')[0]);
    });
    photoWallWrapperHeight();
}

//上传照片模态框
$("#add-new-photo").click(function () {
    $(".upload-photo-wrapper").removeClass("hidden").addClass("show");
    $(".upload-photo-content").addClass("upload-photo-content-in");
});
$("#upload-photo-close").click(function () {
    $("#upload-photo-body").html("");
    $(".upload-photo-wrapper").removeClass("show").addClass("hidden");
    $(".upload-photo-content").removeClass("upload-photo-content-in");
});

function addImage() {
    $("#addImageBtn").attr("disabled",true);
    var fileInput=$("<input type='file' name='cover' class='input-upload' accept='image/*' onchange='imgPreview(this)'>");
    fileInput.click();
    // TODO 当窗口失去焦点时，可以再次点击添加照片按钮(无法获取打开文件选择框事件)
    $(window).blur(function () {
        $("#addImageBtn").attr("disabled",false);
    });
}
//上传图片的预览
function imgPreview(fileDom){
    $("#addImageBtn").attr("disabled",false);

    //获取文件
    var file = fileDom.files[0];
    var imageType = /^image\//;
    //是否是图片
    if (!imageType.test(file.type)) {
        alert("请选择图片！");
        return;
    }
    if(file.size>2*1024*1024){
        alert("图片大小不能超过2M");
        return;
    }

    //判断是否支持FileReader
    if (window.FileReader) {
        var reader = new FileReader();
        //读取完成
        reader.onload = function(e) {
            //获取图片dom
            var img=$("<img src='"+e.target.result+"'>");
            //图片路径设置为读取的图片
            img.css("max-width","200px")
                .css("max-height","150px");

            $("#upload-photo-body").append(fileDom).append(img);
        };
        reader.readAsDataURL(file);
    } else {
        alert("您的设备不支持图片预览功能，如需该功能请升级您的设备！");
    }
}

function uploadImages() {
    var uploadBtn=$("#do-upload");
    uploadBtn.attr("disabled",true);
    uploadBtn.text("正 在 上 传");

    var imageData=new FormData();

    for(var i=0;;i++){
        var file=$(".upload-photo-body input:file")[i];
        if(file!==undefined&&file!==null){
            imageData.append("images",file.files[0]);
        }
        else if(i===0){
            alert("请先添加图片");
            uploadBtn.attr("disabled",false);
            uploadBtn.text("确 认 上 传");
            return;
        }
        else{
            break;
        }
    }

    $.ajax({
        url:"/file/photoWall",
        data:imageData,
        type:'POST',
        processData:false,
        contentType:false,
        error:function () {
            alert("上传照片失败，请稍后重试");
            uploadBtn.attr("disabled",false);
            uploadBtn.text("确 认 上 传");
        },
        success:function (imageBack) {
            if(imageBack.statusCode===200){
                $.post("/classmate/addPhoto",{"classmateId":$("#classmateId").val(),"photos":imageBack.extend.fileNames},
                    function (data) {
                        if(data.statusCode===200){
                            if(imageBack.extend.failNum!==0){
                                alert("部分照片上传成功，失败个数："+imageBack.extend.failNum);
                            }
                            else {
                                alert("照片上传成功");
                            }

                            parsePhoto(data.extend.photos);
                            $("#upload-photo-close").click();
                        }
                        else if(data.statusCode===400){
                            alert(data.msg);
                        }
                        else{
                            alert("照片上传失败，请稍后重试");
                        }

                        uploadBtn.attr("disabled",false);
                        uploadBtn.text("确 认 上 传");
                });
            }
            else{
                alert(imageBack.msg);
                uploadBtn.attr("disabled",false);
                uploadBtn.text("确 认 上 传");
            }
        }
    });
}