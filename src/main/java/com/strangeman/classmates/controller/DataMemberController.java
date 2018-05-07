package com.strangeman.classmates.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.strangeman.classmates.bean.Member;
import com.strangeman.classmates.bean.User;
import com.strangeman.classmates.service.MemberService;
import com.strangeman.classmates.utils.ResultInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/data/member")
public class DataMemberController {
    @Autowired
    private MemberService memberService;

    @RequestMapping("/member")
    public String member(){
        return "management/member";
    }

    @RequestMapping("/list")
    @ResponseBody
    public ResultInfo memberList(@RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "10") Integer limit){
        PageHelper.startPage(page,limit);
        List<Member> members=memberService.getAllMember();
        if(members!=null&&members.size()!=0){
            for(Member member:members){
                member.setPwd("");
            }
            return ResultInfo.success("").add("pageInfo",new PageInfo<>(members,5));
        }
        return ResultInfo.fail("未查询到数据，请稍后重试");
    }

    @RequestMapping("/delete")
    @ResponseBody
    public ResultInfo deleteMember(HttpSession session,String memberId){
        User user=(User) session.getAttribute("user");
        if(user==null)
            return ResultInfo.fail("未查询到登录信息，请重新登录");

        if(memberService.deleteMemberById(memberId))
            return ResultInfo.success("删除用户成功");
        return ResultInfo.fail("删除用户失败，请稍后重试");
    }
}
