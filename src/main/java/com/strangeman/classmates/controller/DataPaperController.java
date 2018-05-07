package com.strangeman.classmates.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.strangeman.classmates.bean.Paper;
import com.strangeman.classmates.bean.User;
import com.strangeman.classmates.service.PaperService;
import com.strangeman.classmates.utils.ResultInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/data/paper")
public class DataPaperController {
    @Autowired
    private PaperService paperService;

    @RequestMapping("/paper")
    public String paper(){
        return "management/paper";
    }

    @RequestMapping("/list")
    @ResponseBody
    public ResultInfo list(@RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "10") Integer limit){
        PageHelper.startPage(page,limit);
        List<Paper> papers=paperService.getAllPaper();
        if(papers==null||papers.size()==0)
            return ResultInfo.fail("未查询到数据");
        return ResultInfo.success("").add("pageInfo",new PageInfo<>(papers,5));
    }

    @RequestMapping("/delete")
    @ResponseBody
    public ResultInfo delete(HttpSession session,String paperId){
        User user=(User) session.getAttribute("user");
        if(user==null)
            return ResultInfo.fail("未查询到登录信息，请重新登录");

        if(paperService.deletePaper(paperId))
            return ResultInfo.success("删除同学录详情页成功");
        return ResultInfo.fail("删除同学录详情页失败，请稍后重试");
    }
}
