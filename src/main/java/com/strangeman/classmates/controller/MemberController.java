package com.strangeman.classmates.controller;

import com.strangeman.classmates.bean.Member;
import com.strangeman.classmates.service.AttentionService;
import com.strangeman.classmates.service.MemberService;
import com.strangeman.classmates.utils.AES;
import com.strangeman.classmates.utils.MyStringUtil;
import com.strangeman.classmates.utils.ResultInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
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
                               String nickname,HttpSession session){
        ResultInfo result;

        if(username==null||!username.equals(session.getAttribute("username"))){
            result=ResultInfo.fail("请输入获取验证码时所用帐号");
        }
        else if(dynamicCode==null||!dynamicCode.equals(session.getAttribute("dynamicCode"))
                ||session.getAttribute("dynamicCodeTime")==null
                ||System.currentTimeMillis()-(Long)session.getAttribute("dynamicCodeTime")>5*60*1000){
            result=ResultInfo.fail("动态验证码错误或已过时");
        }
        else if(graphicCode==null||!graphicCode.equalsIgnoreCase((String) session.getAttribute("graphicCode"))){
            result=ResultInfo.fail("图形验证码错误");
        }
        else if(StringUtils.isEmpty(nickname)){
            result=ResultInfo.fail("昵称不能为空");
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
                member.setNickname(nickname);
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
    public ResultInfo logout(HttpSession session){
        session.removeAttribute("member");

        return ResultInfo.success("退出登录成功");
    }

    @RequestMapping(value = "/logout",method = RequestMethod.GET)
    public String logoutWithPage(HttpSession session){
        session.removeAttribute("member");

        return "redirect:/login";
    }

    @ResponseBody
    @RequestMapping(value = "/member/welcome",method = RequestMethod.POST)
    public ResultInfo welcome(HttpSession session){
        Member member= (Member) session.getAttribute("member");
        if(member==null)
            return ResultInfo.fail("请重新登录");

        int fans=attentionService.countFans(member.getId());
        int attentions=attentionService.countAttentions(member.getId());

        Member member1=member.cloneWithoutPwd();
        if(member1==null)
            return ResultInfo.fail("网络错误，请稍后重试");
        return ResultInfo.success("").add("member",member1).add("fans",fans).add("attentions",attentions);
    }

    @RequestMapping(value = "/member/welcome",method = RequestMethod.GET)
    public String welcome(){
        return "member/welcome";
    }

    @RequestMapping(value = "/member/baseInfo",method = RequestMethod.POST)
    @ResponseBody
    public ResultInfo baseInfo(HttpSession session){
        Member member= (Member) session.getAttribute("member");
        if(member==null)
            return ResultInfo.fail("未查询到登录信息，请重新登录");

        Member member1=member.cloneWithoutPwd();
        if(member1==null)
            return ResultInfo.fail("网络错误，请稍后重试");
        return ResultInfo.success("查询成功").add("member",member1);
    }

    @RequestMapping(value = "/member/modifyInfo",method = RequestMethod.POST)
    @ResponseBody
    public ResultInfo modifyMemberInfo(HttpSession session,Member member){
        Member loginMember= (Member) session.getAttribute("member");
        if(loginMember==null)
            return ResultInfo.fail("未查询到登录信息，请重新登录");
        if(member==null)
            return ResultInfo.fail("修改内容不能为空");

        member.setPwd(null);
        member.setId(loginMember.getId());

        if(memberService.modifyMember(member)){
            member.setPwd(loginMember.getPwd());
            session.setAttribute("member",member);
            return ResultInfo.success("修改成功");
        }
        return ResultInfo.fail("修改信息失败，请稍后重试");
    }

    @RequestMapping(value = "/member/modifyAvatar",method = RequestMethod.POST)
    @ResponseBody
    public ResultInfo modifyAvatar(HttpSession session,String avatar){
        Member member= (Member) session.getAttribute("member");
        if(member==null)
            return ResultInfo.fail("未查询到登录信息，请重新登录");
        if(StringUtils.isEmpty(avatar))
            return ResultInfo.fail("上传的照片不能为空");

        Member member1=new Member();
        member1.setId(member.getId());
        member1.setAvatar(avatar);

        if(memberService.modifyMember(member1)){
            member.setAvatar(avatar);
            return ResultInfo.success("头像上传成功");
        }
        return ResultInfo.fail("上传头像失败，请稍后重试");
    }

    @RequestMapping(value = "/member/modifyPwd",method = RequestMethod.POST)
    @ResponseBody
    public ResultInfo modifyPwd(HttpSession session,String oldPassword,String newPassword,String graphicCode){
        if(graphicCode==null||!graphicCode.equalsIgnoreCase((String) session.getAttribute("graphicCode")))
            return ResultInfo.fail("验证码错误");
        if(StringUtils.isEmpty(oldPassword)||StringUtils.isEmpty(newPassword))
            return ResultInfo.fail("新旧密码均不能为空");

        Member member= (Member) session.getAttribute("member");
        if(member==null)
            return ResultInfo.fail("未查询到登录信息，请重新登录");

        String originPwd;
        try {
            originPwd = AES.decrypt(member.getPwd());
        } catch (Exception e) {
            e.printStackTrace();
            return ResultInfo.fail("系统发生错误，请稍后重试");
        }

        if(originPwd.equals(oldPassword)){
            Member memberTemp=new Member();
            memberTemp.setId(member.getId());
            try {
                memberTemp.setPwd(AES.encrypt(newPassword));
            } catch (Exception e) {
                e.printStackTrace();
                return ResultInfo.fail("系统发生错误，请稍后重试");
            }

            if(memberService.modifyMember(memberTemp)){
                member.setPwd(memberTemp.getPwd());
                return ResultInfo.success("");
            }
            return ResultInfo.fail("修改密码失败，请稍后重试");
        }
        return ResultInfo.fail("旧密码错误");
    }

    @RequestMapping(value = "/member/personCenter",method = RequestMethod.GET)
    public String personCenter(HttpSession session, Model model){
        Member member= (Member) session.getAttribute("member");
        if(member==null)
            return "redirect:/login";

        model.addAttribute("nickname",member.getNickname());

        return "member/member";
    }

    @RequestMapping(value = "/member/modifyPwd",method = RequestMethod.GET)
    public String modifyPwd(){
        return "member/member_modifyPwd";
    }

    @RequestMapping(value = "/member/baseInfo",method = RequestMethod.GET)
    public String baseInfo(){
        return "member/member_myInfo";
    }

    @RequestMapping(value = "/member/avatar",method = RequestMethod.GET)
    public String avatar(){
        return "member/member_myAvatar";
    }
}
