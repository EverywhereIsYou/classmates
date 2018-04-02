package com.strangeman.classmates.controller;

import com.strangeman.classmates.utils.GraphicVeriCode;
import com.strangeman.classmates.utils.MailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
@RequestMapping("/codeService")
public class CodeController {
    @RequestMapping("/graphicCode")
    @ResponseBody
    public void graphicCode(HttpServletRequest request,HttpServletResponse response) throws IOException {
        GraphicVeriCode code=new GraphicVeriCode();
        request.getSession().setAttribute("graphicCode",code.getText());
        ImageIO.write(code.getImage(),"JPEG",response.getOutputStream());
    }

    @RequestMapping("/dynamicCode")
    @ResponseBody
    public void dynamicCode(HttpServletRequest request,String username){
        request.getSession().setAttribute("dynamicCode",MailSender.sendMail(username));
        request.getSession().setAttribute("username",username);
    }
}
