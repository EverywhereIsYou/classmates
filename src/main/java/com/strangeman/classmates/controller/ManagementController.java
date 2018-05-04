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
        return "management/login";
    }

    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public String login(String workId, String password, String graphicCode, Model model, HttpSession session){
        if(StringUtils.isEmpty(graphicCode)){
            model.addAttribute("errorMsg","验证码不能为空");
            return "management/login";
        }
        if(!graphicCode.equalsIgnoreCase((String) session.getAttribute("graphicCode"))){
            model.addAttribute("errorMsg","验证码错误");
            return "management/login";
        }
        if(StringUtils.isEmpty(workId)||StringUtils.isEmpty(password)){
            model.addAttribute("errorMsg","用户名和密码不能为空");
            return "management/login";
        }

        User user=userService.login(workId,password);
        if(user==null){
            model.addAttribute("errorMsg","用户名或密码错误");
            return "management/login";
        }

        session.setAttribute("user",user);
        session.setMaxInactiveInterval(30*60);

        return "redirect:/management/index";
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session){
        session.removeAttribute("user");
        return "redirect:/management/login";
    }

    @RequestMapping("/index")
    public String index(HttpSession session, Model model){
        User loginUser= (User) session.getAttribute("user");
        if(loginUser==null)
            return "redirect:/management/login";

        User user=new User();
        user.setWorkId(loginUser.getWorkId());
        user.setLastModifyTime(loginUser.getLastModifyTime());
        user.setCreateTime(loginUser.getCreateTime());
        user.setId(loginUser.getId());
        user.setRole(loginUser.getRole());

        model.addAttribute("user",user);
        return "management/index";
    }

    @RequestMapping("/welcome")
    public String welcome(){
        return "management/welcome";
    }
}
