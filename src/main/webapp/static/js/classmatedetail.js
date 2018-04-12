$(function () {
    $("#delete2").tooltip({
        placement: "auto bottom",
        delay: {show: 800, hide: 100},
        template: "<div class='tooltip'>" +
        "<div class=''></div>" +
        "<div class=''><h5 style='font-size: 1.1em;color: #d9534f;'>删除本页同学录</h5></div>" +
        "</div>"
    });

    function classmateHeader(){
        var classmateName = $("<h1></h1>",{text: '朝花夕拾'});
        var schoolAndClazz = $("<h3></h3>",{text: '华中科技大学 1401班'});
        var liner = $("<div></div>",{id: 'liner'});
        var description = $("<h3></h3>",{text: '如果你无法简洁的表达你的想法，那只说明你还不够了解它。-- 阿尔伯特·爱因斯坦'});
        $(".header").append(classmateName).append(schoolAndClazz).append(liner).append(description);
    }
    classmateHeader();

    function authorInf() {
        var aA = $("<a></a>",{href: 'javascript:void(0)'});
        var avatar = $("<img>",{
            src: '<c:url value="/static/images/avatar.png" />',
            alt: '头像',
            id: 'avatar',
            class: 'img-circle img-responsive avatar'
        });
        var author = $("<h3></h3>",{text: '李四'});
        var writeTime = $("<h6></h6>",{text: '填写于 2018年4月11日'});

        $(".paper-header").append(aA.append(avatar))
                            .append(aA.append(author))
                            .append(writeTime);
    }
    authorInf();

    $(".classmate-detail-wrapper").css("height",$("#paper").height()+300+"px");
});
