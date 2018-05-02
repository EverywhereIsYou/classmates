package com.strangeman.classmates.controller;

import com.strangeman.classmates.bean.User;
import com.strangeman.classmates.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/management")
public class ManagementController {
    @Autowired
    private UserService userService;

    @RequestMapping(value = "/login",method = RequestMethod.GET)
    public String login(){
        return "management/login_manager";
    }

    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public String login(String workId, String password, String graphicCode, Model model, HttpSession session){
        if(StringUtils.isEmpty(graphicCode)){
            model.addAttribute("errorMsg","验证码不能为空");
            return "management/login_manager";
        }
        if(!graphicCode.equalsIgnoreCase((String) session.getAttribute("graphicCode"))){
            model.addAttribute("errorMsg","验证码错误");
            return "management/login_manager";
        }
        if(StringUtils.isEmpty(workId)||StringUtils.isEmpty(password)){
            model.addAttribute("errorMsg","用户名和密码不能为空");
            return "management/login_manager";
        }

        User user=userService.login(workId,password);
        if(user==null){
            model.addAttribute("errorMsg","用户名或密码错误");
            return "management/login_manager";
        }

        session.setAttribute("user",user);
        session.setMaxInactiveInterval(30*60);

        return "redirect:/management/index";
    }

    @RequestMapping("/index")
    public String index(HttpSession session, Model model){
        User user= (User) session.getAttribute("user");
        if(user==null)
            return "redirect:management/login";

        user.setPwd("");
        model.addAttribute("user",user);
        return "management/index";
    }
}
