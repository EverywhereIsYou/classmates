package com.strangeman.classmates.controller;

import com.strangeman.classmates.bean.Classmate;
import com.strangeman.classmates.bean.Comment;
import com.strangeman.classmates.bean.Member;
import com.strangeman.classmates.bean.Paper;
import com.strangeman.classmates.service.ClassmateService;
import com.strangeman.classmates.service.CommentService;
import com.strangeman.classmates.service.MemberService;
import com.strangeman.classmates.service.PaperService;
import com.strangeman.classmates.utils.ResultInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
    @Autowired
    private MemberService memberService;
    @Autowired
    private PaperService paperService;
    @Autowired
    private CommentService commentService;

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
    @RequestMapping(value = "/classmateDetail",method = RequestMethod.POST)
    public ResultInfo classmateDetail(HttpSession session,String classmateId){
        ResultInfo result;

        Member member= (Member) session.getAttribute("member");
        if(member!=null){
            Classmate classmate=classmateService.getCompleteClassmateById(classmateId);
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

    @RequestMapping(value = "/classmateDetail",method = RequestMethod.GET)
    public String classmateDetail(Model model,String classmateId){
        model.addAttribute("classmateId",classmateId);

        return "classmate/classmatedetail";
    }

    @ResponseBody
    @RequestMapping(value = "/createClassmate")
    public ResultInfo createClassmate(HttpSession session,Classmate classmate){
        Member member= (Member) session.getAttribute("member");
        String memberId;

        if(member==null){
            return ResultInfo.fail("查不到该用户数据，请重新登录");
        }
        else{
            memberId=member.getId();
        }

        if(classmate==null||StringUtils.isEmpty(classmate.getName())||StringUtils.isEmpty(classmate.getSchool())||StringUtils.isEmpty(classmate.getClazz())){
            return ResultInfo.fail("输入数据不完整，请重试");
        }
        else {
            classmate.setOwnerId(memberId);
        }

        if(classmateService.createClassmate(classmate)){
            return ResultInfo.success("创建同学录成功");
        }
        return ResultInfo.fail("创建同学录失败");
    }

    @ResponseBody
    @RequestMapping("/updateClassmate")
    public ResultInfo updateClassmate(HttpSession session,Classmate classmate){
        if(classmate==null||classmate.getId()==null||classmate.getId().equals(""))
            return ResultInfo.fail("同学录ID不能为空");

        Member member= (Member) session.getAttribute("member");
        if(member==null)
            return ResultInfo.fail("为查询到用户信息，请重新登录");

        Classmate classmateOld=classmateService.getSimpleClassmateById(classmate.getId());
        if(classmateOld==null)
            return ResultInfo.fail("无法查询到当前同学录");

        if(!classmateOld.getOwnerId().equals(member.getId()))
            return ResultInfo.fail("当前用户没有修改权限");

        classmate.setOwnerId(classmateOld.getOwnerId());
        if(classmateService.modifyClassmate(classmate))
            return ResultInfo.success("同学录修改成功");

        return ResultInfo.fail("修改失败，请稍后重试");
    }

    @ResponseBody
    @RequestMapping("/deleteClassmate")
    public ResultInfo deleteClassmate(HttpSession session,String classmateId){
        if(StringUtils.isEmpty(classmateId))
            return ResultInfo.fail("同学录ID为空");

        Member member= (Member) session.getAttribute("member");
        if(member==null)
            return ResultInfo.fail("无法查询用户信息，请重新登录");

        Classmate classmate=classmateService.getSimpleClassmateById(classmateId);
        if(classmate==null)
            return ResultInfo.fail("无法查询到该同学录信息");

        if(classmate.getOwnerId()==null||!classmate.getOwnerId().equals(member.getId()))
            return ResultInfo.fail("没有该同学录删除权限");

        ResultInfo result;
        if(classmateService.deleteClassmate(classmateId)){
            result=ResultInfo.success("删除同学录成功");
        }
        else {
            result=ResultInfo.fail("删除同学录失败，请稍后重试");
        }
        return result;
    }

    @RequestMapping(value = "/writePaper",method = RequestMethod.GET)
    public String writePaper(Model model,HttpSession session,String classmateId){
        if(StringUtils.isEmpty(classmateId)){
            model.addAttribute("not_found_msg","同学录ID为空");
            return "404";
        }

        Classmate classmate=classmateService.getSimpleClassmateById(classmateId);
        if(classmate==null){
            model.addAttribute("not_found_msg","未查询到同学录信息，请确认链接");
            return "404";
        }
        model.addAttribute("classmate",classmate);

        Member classmateAuthor=memberService.getMemberById(classmate.getOwnerId());
        if(classmateAuthor!=null){
            String classmateAuthorName="";
            if(!StringUtils.isEmpty(classmateAuthor.getNickname())){
                classmateAuthorName=classmateAuthor.getNickname();
            }
            else if(!StringUtils.isEmpty(classmateAuthor.getRealName())){
                classmateAuthorName=classmateAuthor.getRealName();
            }
            else if(!StringUtils.isEmpty(classmateAuthor.getPhone())){
                classmateAuthorName=classmateAuthor.getPhone();
            }
            else if(!StringUtils.isEmpty(classmateAuthor.getEmail())){
                classmateAuthorName=classmateAuthor.getEmail();
            }

            model.addAttribute("classmateAuthorName",classmateAuthorName);
        }

        Member paperAuthor= (Member) session.getAttribute("member");
        if(paperAuthor!=null){
            model.addAttribute("paperAuthor",paperAuthor);
        }

        return "classmate/write";
    }

    @ResponseBody
    @RequestMapping(value = "/writePaper",method = RequestMethod.POST)
    public ResultInfo writePaper(HttpSession session,Paper paper){
        ResultInfo result;
        if(paper==null)
            result=ResultInfo.fail("提交的内容为空");
        else {
            Member member= (Member) session.getAttribute("member");
            if(member!=null&&member.getId()!=null){
                paper.setAuthorId(member.getId());
            }

            if (paperService.createPaper(paper)) {
                result = ResultInfo.success("");

                if(member!=null){
                    result.add("nextPage","welcome");
                }
            } else {
                result = ResultInfo.fail("数据错误");
            }
        }

        return result;
    }

    @ResponseBody
    @RequestMapping("/deletePaper")
    public ResultInfo deletePaper(HttpSession session,String paperId){
        if(StringUtils.isEmpty(paperId))
            return ResultInfo.fail("同学录详情页ID为空");

        Member member= (Member) session.getAttribute("member");
        if(member==null)
            return ResultInfo.fail("无法查询用户信息，请重新登录");

        Paper paper=paperService.getPaperById(paperId);
        if(paper==null)
            return ResultInfo.fail("找不到该同学录详情页");

        Classmate classmate=classmateService.getSimpleClassmateById(paper.getClassmateId());
        if(classmate==null)
            return ResultInfo.fail("无法查询到该同学录信息");

        if(classmate.getOwnerId()==null||!classmate.getOwnerId().equals(member.getId()))
            return ResultInfo.fail("没有该同学录删除权限");

        ResultInfo result;
        if(paperService.deletePaper(paperId)){
            result=ResultInfo.success("删除同学录详情页成功").add("papers",paperService.getPapersByClassmateId(classmate.getId()));
        }
        else{
            result=ResultInfo.fail("删除同学录详情页失败，请稍后重试");
        }
        return result;
    }

    @ResponseBody
    @RequestMapping(value = "/writeComment",method = RequestMethod.POST)
    public ResultInfo writeComment(HttpSession session,String commentContent,String classmateId){
        if(StringUtils.isEmpty(classmateId))
            return ResultInfo.fail("同学录ID为空");
        if(StringUtils.isEmpty(commentContent))
            return ResultInfo.fail("留言内容不能为空");

        Member member= (Member) session.getAttribute("member");
        if(member==null)
            return ResultInfo.fail("登录信息失效，请重新登录");

        Comment comment=new Comment();
        comment.setClassmateId(classmateId);
        comment.setContent(commentContent);
        comment.setMemberId(member.getId());

        if(!commentService.createComment(comment)){
            return ResultInfo.fail("留言失败，请稍后重试");
        }

        return ResultInfo.success("").add("comments",commentService.getCommentsByClassmateId(classmateId));
    }

    @ResponseBody
    @RequestMapping(value = "/photoWall",method = RequestMethod.POST)
    public ResultInfo getPhotoWall(HttpSession session,String classmateId){
        ResultInfo result;

        Member member= (Member) session.getAttribute("member");
        if(member==null) {
            result=ResultInfo.fail("查不到用户数据，请重新登录");
        }
        else {
            if (StringUtils.isEmpty(classmateId))
                result=ResultInfo.fail("同学录ID为空");
            else {
                Classmate classmate = classmateService.getSimpleClassmateById(classmateId);
                if (classmate != null) {
                    if (haveReadPermission(member, classmate)) {
                        result = ResultInfo.success("").add("classmate", classmate);
                    } else {
                        result = ResultInfo.fail("无该同学录查看权限");
                    }
                } else {
                    result = ResultInfo.fail("无法查询该同学录数据");
                }
            }
        }
        return result;
    }

    @RequestMapping(value = "/photoWall",method = RequestMethod.GET)
    public String getPhotoWall(Model model,String classmateId){
        model.addAttribute("classmateId",classmateId);

        return "classmate/photowall";
    }

    @ResponseBody
    @RequestMapping(value = "/inviteLink")
    public ResultInfo inviteLink(HttpSession session,String classmateId){
        if(StringUtils.isEmpty(classmateId))
            return ResultInfo.fail("同学录ID为空");

        Member member= (Member) session.getAttribute("member");
        if(member==null)
            return ResultInfo.fail("为查询到用户信息，请重新登录");

        Classmate classmate=classmateService.getSimpleClassmateById(classmateId);
        if(classmate==null)
            return ResultInfo.fail("无法查询到该同学录信息，请稍后重试");
        if(classmate.getOwnerId()==null||!classmate.getOwnerId().equals(member.getId()))
            return ResultInfo.fail("当前用户无该同学录分享权限");

        return ResultInfo.success("").add("url",createInviteLink(classmateId));
    }

    private boolean haveReadPermission(Member member,Classmate classmate) {
        return member != null && classmate != null && classmate.getOwnerId() != null && classmate.getOwnerId().equals(member.getId());
    }

    private String createInviteLink(String classmateId){
        if(StringUtils.isEmpty(classmateId))
            return "";
        return "http://127.0.0.1:8080/classmate/writePaper?classmateId="+classmateId;
    }
}
