package com.strangeman.classmates.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.strangeman.classmates.bean.Comment;
import com.strangeman.classmates.bean.User;
import com.strangeman.classmates.service.CommentService;
import com.strangeman.classmates.utils.ResultInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/data/comment")
public class DataCommentController {
    @Autowired
    private CommentService commentService;

    @RequestMapping("/comment")
    public String comment(){
        return "management/comment";
    }

    @RequestMapping("/list")
    @ResponseBody
    public ResultInfo list(@RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "10") Integer limit){
        PageHelper.startPage(page,limit);
        List<Comment> comments=commentService.getAllComment();
        if(comments==null||comments.size()==0)
            return ResultInfo.fail("未查询到数据");
        return ResultInfo.success("").add("pageInfo",new PageInfo<>(comments,5));
    }

    @RequestMapping("/delete")
    @ResponseBody
    public ResultInfo delete(HttpSession session,String commentId){
        User user=(User) session.getAttribute("user");
        if(user==null)
            return ResultInfo.fail("未查询到登录信息，请重新登录");

        if(commentService.deleteComment(commentId))
            return ResultInfo.success("删除同学录成功");
        return ResultInfo.fail("删除用户失败,请稍后重试");
    }
}
