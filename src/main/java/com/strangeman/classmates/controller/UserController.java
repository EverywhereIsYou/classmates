package com.strangeman.classmates.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.strangeman.classmates.bean.User;
import com.strangeman.classmates.service.UserService;
import com.strangeman.classmates.utils.AES;
import com.strangeman.classmates.utils.ResultInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/data/user")
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping("/manager")
    public String manager(){
        return "management/manager";
    }

    @RequestMapping("/list")
    @ResponseBody
    public ResultInfo userList(@RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "10") Integer limit){
        ResultInfo result=null;

        PageHelper.startPage(page,limit);
        List<User> users=userService.getAllUser();
        if(users!=null){
            for(User user:users){
                user.setPwd("");
            }
            result=ResultInfo.success("").add("pageInfo",new PageInfo<>(users,5));
        }
        return result;
    }

    @RequestMapping("/add")
    @ResponseBody
    public ResultInfo addUser(HttpSession session,User user){
        User loginUser= (User) session.getAttribute("user");
        if(loginUser==null)
            return ResultInfo.fail("未查询到登录信息，请重新登录");
        if(!"超级管理员".equals(loginUser.getRole()))
            return ResultInfo.fail("没有添加管理员权限");
        if(user==null|| StringUtils.isEmpty(user.getWorkId())|| StringUtils.isEmpty(user.getPwd()))
            return ResultInfo.fail("要添加的用户信息不能为空");

        user.setRole("普通管理员");
        if(userService.createUser(user))
            return ResultInfo.success("创建管理员成功");
        return ResultInfo.fail("创建管理员失败，请稍后重试");
    }

    @RequestMapping("/delete")
    @ResponseBody
    public ResultInfo deleteUser(HttpSession session,String userId){
        User loginUser= (User) session.getAttribute("user");
        if(loginUser==null)
            return ResultInfo.fail("未查询到登录信息，请重新登录");
        if(!"超级管理员".equals(loginUser.getRole()))
            return ResultInfo.fail("没有删除管理员权限");

        User user=userService.getUserById(userId);
        if(user==null)
            return ResultInfo.fail("未查询到该管理员，请确认后重试");
        if("超级管理员".equals(user.getRole()))
            return ResultInfo.fail("无法删除超级管理员");

        if(userService.deleteUser(userId))
            return ResultInfo.success("管理员删除成功");
        return ResultInfo.fail("管理员删除失败，请稍后重试");
    }

    @RequestMapping("/modifyPwd")
    @ResponseBody
    public ResultInfo modifyPwd(HttpSession session,String oldPassword,String newPassword){
        User user= (User) session.getAttribute("user");
        if(user==null)
            return ResultInfo.fail("未查询到登录信息，请重新登录");
        if(StringUtils.isEmpty(oldPassword)||StringUtils.isEmpty(newPassword))
            return ResultInfo.fail("新旧密码均不能为空");

        String originPassword;
        try {
            originPassword=AES.decrypt(user.getPwd());
        } catch (Exception e) {
            e.printStackTrace();
            return ResultInfo.fail("系统发生错误，请稍后重试");
        }

        if(originPassword.equals(oldPassword)){
            try {
                user.setPwd(AES.encrypt(newPassword));
            } catch (Exception e) {
                e.printStackTrace();
                return ResultInfo.fail("系统发生错误，请稍后重试");
            }

            if(userService.modifyUser(user))
                return ResultInfo.success("");
            return ResultInfo.fail("修改密码失败，请稍后重试");
        }

        return ResultInfo.fail("旧密码错误");
    }
}
