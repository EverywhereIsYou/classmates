package com.strangeman.classmates.controller;

import com.strangeman.classmates.utils.ResultInfo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

@Controller
@RequestMapping("/file")
public class FileController {
    private static final String CLASSMATE_COVER_PATH="/static/images/classmate/cover/";

    @ResponseBody
    @RequestMapping("/classmateCover")
    public ResultInfo setClassmateCover(HttpSession session,MultipartFile cover){
        if(cover==null)
            return ResultInfo.fail("封面为空");

        String path=session.getServletContext().getRealPath(CLASSMATE_COVER_PATH);
        String OriginalFileName=cover.getOriginalFilename();
        String suffix=OriginalFileName.substring(OriginalFileName.lastIndexOf("."));
        String fileName= UUID.randomUUID().toString()+suffix;

        File file=new File(path,fileName);
        if(!file.exists()){
            if(!file.mkdirs()){
                return ResultInfo.fail("无法创建文件，请稍后重试");
            }
        }

        ResultInfo result;
        try {
            cover.transferTo(file);
            result=ResultInfo.success("").add("fileName", CLASSMATE_COVER_PATH+fileName);
        } catch (IOException e) {
            e.printStackTrace();
            result=ResultInfo.fail("上传图片错误，请稍后重试");
        }

        return result;
    }
}
