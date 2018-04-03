package com.strangeman.classmates.controller;

import com.strangeman.classmates.utils.GraphicVeriCode;
import com.strangeman.classmates.utils.MailSender;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
@RequestMapping("/codeService")
public class CodeController {
    private Log log= LogFactory.getLog(CodeController.class);

    @RequestMapping("/graphicCode")
    @ResponseBody
    public void graphicCode(HttpServletRequest request,HttpServletResponse response) throws IOException {
        GraphicVeriCode code=new GraphicVeriCode();
        request.getSession().setAttribute("graphicCode",code.getText());
        ImageIO.write(code.getImage(),"JPEG",response.getOutputStream());

        log.info("graphicCode:"+request.getSession().getAttribute("graphicCode"));
    }

    @RequestMapping("/dynamicCode")
    @ResponseBody
    public void dynamicCode(HttpServletRequest request,String username){
        HttpSession session=request.getSession();

        request.getSession().setAttribute("dynamicCode",MailSender.sendMail(username));
        request.getSession().setAttribute("username",username);

        log.info("dynamicCode:"+session.getAttribute("dynamicCode"));
        log.info("username:"+session.getAttribute("username"));
    }
}
