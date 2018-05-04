function setPageInfo(pageInfo) {
    if(pageInfo===undefined||pageInfo===null)
        return;

    $("#page-info").text("总共 "+pageInfo.total+" 条记录，"+pageInfo.pages+" 页");
}

function setNavArea(pageInfo) {
    var navArea=$("#nav-area");
    navArea.html("");

    var nav=$("<nav></nav>");
    var ul=$("<ul class='pagination'></ul>");

    var firstLi=$("<li></li>").append($("<a href='javascript:void(0)'></a>").append("首页"));
    var preLi=$("<li></li>").append($("<a href='javascript:void(0)'></a>").append($("<span></span>").append("&laquo;")));
    if(pageInfo.isFirstPage===true){
        firstLi.addClass("disabled",true);
        preLi.addClass("disabled",true);
    }
    else{
        firstLi.click(function () {
            getDataByPage(1);
        });
        preLi.click(function () {
            getDataByPage(pageInfo.prePage);
        });
    }

    ul.append(firstLi).append(preLi);

    $.each(pageInfo.navigatepageNums,function () {
        var pageLi=$("<li></li>").append($("<a href='javascript:void(0)'></a>").append(this));
        var currentPage=parseInt(this);
        if(currentPage===pageInfo.pageNum){
            pageLi.addClass("active");
        }
        else{
            pageLi.click(function () {
                getDataByPage(currentPage);
            });
        }

        ul.append(pageLi);
    });

    var nextLi=$("<li></li>").append($("<a href='javascript:void(0)'></a>").append($("<span></span>").append("&raquo;")));
    var lastLi=$("<li></li>").append($("<a href='javascript:void(0)'></a>").append("末页"));
    if(pageInfo.hasNextPage===false){
        nextLi.addClass("disabled",true);
        lastLi.addClass("disabled",true);
    }
    else{
        nextLi.click(function () {
            getDataByPage(pageInfo.nextPage);
        });
        lastLi.click(function () {
            getDataByPage(pageInfo.pages);
        });
    }

    ul.append(nextLi).append(lastLi).appendTo(nav);
    nav.appendTo(navArea);
}