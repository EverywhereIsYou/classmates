package com.strangeman.classmates.controller;

import com.strangeman.classmates.bean.Member;
import com.strangeman.classmates.service.AttentionService;
import com.strangeman.classmates.service.MemberService;
import com.strangeman.classmates.utils.MyStringUtil;
import com.strangeman.classmates.utils.ResultInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
public class MemberController {
    @Autowired
    private MemberService memberService;
    @Autowired
    private AttentionService attentionService;

    @ResponseBody
    @RequestMapping(value = "/register",method = RequestMethod.POST)
    public ResultInfo register(String username,String password,Integer dynamicCode,String graphicCode,
                               HttpSession session){
        ResultInfo result;

        if(username==null||!username.equals(session.getAttribute("username"))){
            result=ResultInfo.fail("请输入获取验证码时所用帐号");
        }
        else if(dynamicCode==null||!dynamicCode.equals(session.getAttribute("dynamicCode"))
                ||session.getAttribute("dynamicCodeTime")==null
                ||System.currentTimeMillis()-(Integer)session.getAttribute("dynamicCodeTime")>5*60*1000){
            result=ResultInfo.fail("动态验证码错误或已过时");
        }
        else if(graphicCode==null||!graphicCode.equalsIgnoreCase((String) session.getAttribute("graphicCode"))){
            result=ResultInfo.fail("图形验证码错误");
        }
        else{
            if(memberService.hasExist(username)){
                result=ResultInfo.fail("用户名已存在");
                return result;
            }
            else{
                Member member=new Member();
                if(MyStringUtil.isPhone(username)){
                    member.setPhone(username);
                }
                else if(MyStringUtil.isEmail(username)){
                    member.setEmail(username);
                }
                else{
                    result=ResultInfo.fail("用户名格式不正确");
                    return result;
                }

                member.setPwd(password);
                if(memberService.register(member)){
                    result=ResultInfo.success("注册成功");
                }
                else{
                    result=ResultInfo.fail("注册失败，请稍后重试");
                }
            }
        }

        return result;
    }

    @RequestMapping(value = "/register",method = RequestMethod.GET)
    public String register(){
        return "register";
    }

    @ResponseBody
    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public ResultInfo login(String username,String password,String graphicCode,HttpSession session){
        ResultInfo result;

        session.removeAttribute("member");

        if(graphicCode!=null&&graphicCode.equalsIgnoreCase((String) session.getAttribute("graphicCode"))){
            Member member=memberService.login(username,password);
            if(member==null){
                result=ResultInfo.fail("用户名或密码不正确");
            }
            else{
                member.setPwd("");

                result=ResultInfo.success("登录成功");
                session.setAttribute("member",member);
                session.setMaxInactiveInterval(30*60);
            }
        }
        else {
            result=ResultInfo.fail("验证码错误");
        }

        return result;
    }

    @RequestMapping(value = "/login",method = RequestMethod.GET)
    public String login(){
        return "login";
    }

    @RequestMapping(value = "/logout",method = RequestMethod.POST)
    @ResponseBody
    public ResultInfo logout(HttpSession session, Model model){
        session.removeAttribute("member");

        return ResultInfo.success("退出登录成功");
    }

    @RequestMapping(value = "/logout",method = RequestMethod.GET)
    public String logout(HttpSession session){
        session.removeAttribute("member");

        return "login";
    }

    @ResponseBody
    @RequestMapping(value = "/member/welcome",method = RequestMethod.POST)
    public ResultInfo welcome(HttpSession session){
        ResultInfo result;

        if(session.getAttribute("member")==null){
            result=ResultInfo.fail("请重新登录");
        }
        else {
            String userId=((Member) session.getAttribute("member")).getId();
            int fans=attentionService.countFans(userId);
            int attentions=attentionService.countAttentions(userId);

            result=ResultInfo.success("").add("member",session.getAttribute("member"))
                    .add("fans",fans).add("attentions",attentions);
        }

        return result;
    }

    @RequestMapping(value = "/member/welcome",method = RequestMethod.GET)
    public String welcome(){
        return "member/welcome";
    }
}
