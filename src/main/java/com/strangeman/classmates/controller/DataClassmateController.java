package com.strangeman.classmates.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.strangeman.classmates.bean.Classmate;
import com.strangeman.classmates.bean.User;
import com.strangeman.classmates.service.ClassmateService;
import com.strangeman.classmates.utils.ResultInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/data/classmate")
public class DataClassmateController {
    @Autowired
    private ClassmateService classmateService;

    @RequestMapping("/classmate")
    public String classmate(){
        return "/management/classmate";
    }

    @RequestMapping("/list")
    @ResponseBody
    public ResultInfo list(@RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "10") Integer limit){
        PageHelper.startPage(page,limit);
        List<Classmate> classmates=classmateService.getAllClassmate();
        if(classmates==null||classmates.size()==0)
            return ResultInfo.fail("未查询到数据，请稍后重试");
        return ResultInfo.success("").add("pageInfo",new PageInfo<>(classmates,5));
    }

    @RequestMapping("/delete")
    @ResponseBody
    public ResultInfo delete(HttpSession session,String classmateId){
        User user=(User) session.getAttribute("user");
        if(user==null)
            return ResultInfo.fail("未查询到登录信息，请重新登录");

        if(classmateService.deleteClassmate(classmateId))
            return ResultInfo.success("删除同学录成功");
        return ResultInfo.fail("删除用户失败,请稍后重试");
    }
}
