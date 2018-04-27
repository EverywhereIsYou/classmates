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
    private static final String CLASSMATE_PHOTO_WALL="/static/images/classmate/photoWall/";

    @ResponseBody
    @RequestMapping("/classmateCover")
    public ResultInfo setClassmateCover(HttpSession session,MultipartFile cover){
        if(cover==null)
            return ResultInfo.fail("封面为空");

        String path=session.getServletContext().getRealPath(CLASSMATE_COVER_PATH);

        String fileName=createFile(path,cover);
        if(fileName!=null)
            return ResultInfo.success("").add("fileName",CLASSMATE_COVER_PATH+fileName);

        return ResultInfo.fail("上传图片失败，请稍后重试");
    }

    @ResponseBody
    @RequestMapping("/photoWall")
    public ResultInfo addPhotoWall(HttpSession session,MultipartFile[] images){
        if(images==null||images.length==0)
            return ResultInfo.fail("未获取到图片");

        String path=session.getServletContext().getRealPath(CLASSMATE_PHOTO_WALL);

        StringBuilder success=new StringBuilder();
        int failNum=0;
        for(MultipartFile file:images){
            String fileName=createFile(path,file);
            if(fileName!=null){
                success.append(CLASSMATE_PHOTO_WALL).append(fileName).append("|");
            }
            else {
                failNum++;
            }
        }

        if(success.length()>0)
            return ResultInfo.success("").add("fileNames",success.toString()).add("failNum",failNum);

        return ResultInfo.fail("上传图片失败，请稍后重试");
    }

    private String createFile(String path,MultipartFile originalFile){
        String originalFileName=originalFile.getOriginalFilename();
        String suffix=originalFileName.substring(originalFileName.lastIndexOf("."));
        String fileName= UUID.randomUUID().toString()+suffix;

        File file=new File(path,fileName);
        if(!file.exists()){
            if(!file.mkdirs()){
                return null;
            }
        }

        try {
            originalFile.transferTo(file);
            return fileName;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
}