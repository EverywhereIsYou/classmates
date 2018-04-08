package com.strangeman.classmates.controller;

import com.strangeman.classmates.bean.Member;
import com.strangeman.classmates.service.AttentionService;
import com.strangeman.classmates.service.MemberService;
import com.strangeman.classmates.utils.MyStringUtil;
import com.strangeman.classmates.utils.ResultInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
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
                               HttpServletRequest request){
        ResultInfo result;

        HttpSession session=request.getSession();
        if(username!=null&&username.equals(session.getAttribute("username"))&&
                dynamicCode!=null&&dynamicCode.equals(session.getAttribute("dynamicCode"))&&
                graphicCode!=null&&graphicCode.equals(session.getAttribute("graphicCode"))){
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
        else {
            result=ResultInfo.fail("数据格式错误");
        }
        return result;
    }

    @RequestMapping(value = "/register",method = RequestMethod.GET)
    public String register(){
        return "register";
    }

    @ResponseBody
    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public ResultInfo login(String username,String password,String graphicCode,HttpServletRequest request){
        ResultInfo result;

        if(graphicCode!=null&&graphicCode.equals(request.getSession().getAttribute("graphicCode"))){
            Member member=memberService.login(username,password);
            if(member==null){
                result=ResultInfo.fail("用户名或密码不正确");
            }
            else{
                member.setPwd("");

                result=ResultInfo.success("登录成功");
                request.getSession().setAttribute("member",member);
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

    @ResponseBody
    @RequestMapping(value = "/member/welcome",method = RequestMethod.POST)
    public ResultInfo welcome(HttpServletRequest request){
        ResultInfo result;

        if(request.getSession().getAttribute("member")==null){
            result=ResultInfo.fail("请重新登录");
        }
        else {
            String userId=((Member)request.getSession().getAttribute("member")).getId();
            int fans=attentionService.countFans(userId);
            int attentions=attentionService.countAttentions(userId);

            result=ResultInfo.success("").add("member",request.getSession().getAttribute("member"))
                    .add("fans",fans).add("attentions",attentions);
        }

        return result;
    }

    @RequestMapping(value = "/member/welcome",method = RequestMethod.GET)
    public String welcome(){
        return "member/welcome";
    }
}
