package com.strangeman.classmates.controller;

import com.strangeman.classmates.utils.GraphicVeriCode;
import com.strangeman.classmates.utils.MailSender;
import com.strangeman.classmates.utils.QRCode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;

@Controller
@RequestMapping("/codeService")
public class CodeController {
    private Logger log= LoggerFactory.getLogger(CodeController.class);

    @RequestMapping("/graphicCode")
    @ResponseBody
    public void graphicCode(HttpSession session,HttpServletResponse response) throws IOException {
        response.setDateHeader("expires",-1);
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Pragma", "no-cache");

        GraphicVeriCode code=new GraphicVeriCode();
        session.setAttribute("graphicCode",code.getText());
        ImageIO.write(code.getImage(),"JPEG",response.getOutputStream());

        log.info("graphicCode:"+session.getAttribute("graphicCode"));
    }

    @RequestMapping("/dynamicCode")
    @ResponseBody
    public void dynamicCode(HttpSession session,String username){
        int dynamicCode=MailSender.sendMail(username);
        if(dynamicCode!=-1){
            session.setAttribute("dynamicCode",dynamicCode);
            session.setAttribute("dynamicCodeTime",System.currentTimeMillis());
            session.setAttribute("username",username);
        }

        log.info("dynamicCode:"+session.getAttribute("dynamicCode"));
        log.info("username:"+session.getAttribute("username"));
    }

    @RequestMapping("/QRCode")
    @ResponseBody
    public void qrCode(HttpServletResponse response,String url) throws IOException {
        if(StringUtils.isEmpty(url))
            return;

        BufferedImage image= QRCode.getQRCode(url);
        if(image!=null)
            ImageIO.write(image,"JPEG",response.getOutputStream());
    }
}
