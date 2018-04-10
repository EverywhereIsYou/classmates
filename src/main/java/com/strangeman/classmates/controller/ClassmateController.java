package com.strangeman.classmates.controller;

import com.strangeman.classmates.bean.Classmate;
import com.strangeman.classmates.bean.Member;
import com.strangeman.classmates.service.ClassmateService;
import com.strangeman.classmates.utils.ResultInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/classmate")
public class ClassmateController {
    @Autowired
    private ClassmateService classmateService;

    @RequestMapping(value = "/myclassmates",method = RequestMethod.GET)
    public String myClassmates(){
        return "classmate/myclassmate";
    }

    @ResponseBody
    @RequestMapping(value = "/myclassmates",method = RequestMethod.POST)
    public ResultInfo myClassamtes(HttpSession session){
        ResultInfo result;

        Member member= (Member) session.getAttribute("member");
        if(member!=null&&!StringUtils.isEmpty(member.getId())){
            List<Classmate> classmates=classmateService.getClassmatesByUserId(member.getId());
            result=ResultInfo.success("").add("classmates",classmates);
        }
        else {
            result=ResultInfo.fail("无法获取用户数据");
        }

        return result;
    }

    @ResponseBody
    @RequestMapping(value = "/classmateDetail")
    public ResultInfo classmateDetail(HttpSession session,String classmateId){
        ResultInfo result;

        Member member= (Member) session.getAttribute("member");
        if(member!=null){
            Classmate classmate=classmateService.getClassmateById(classmateId);
            if(classmate!=null){
                if(haveReadPermission(member,classmate)){
                    result=ResultInfo.success("").add("classmate",classmate);
                }
                else{
                    result=ResultInfo.fail("无查看权限");
                }
            }
            else {
                result=ResultInfo.fail("无法查询该同学录数据");
            }
        }
        else{
            result=ResultInfo.fail("无法查询用户数据，请重新登录");
        }

        return result;
    }

    private boolean haveReadPermission(Member member,Classmate classmate) {
        return member != null && classmate != null && classmate.getOwnerId() != null && classmate.getOwnerId().equals(member.getId());
    }
}
