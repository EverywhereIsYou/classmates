package com.strangeman.classmates.utils;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class MailSender {
    private static final String emailPrefix="您的验证码是：";
    private static final String emailSuffix="，请在5分钟内填写，过期无效。";

    public static int sendMail(String targetAddress){
        int randomVeriNum=DataFactory.getRandomVeriNum();

        Properties prop=new Properties();
        prop.setProperty("mail.smtp.host","smtp.qq.com");
        prop.setProperty("mail.smtp.port","587");
        prop.setProperty("mail.transport.protocol", "SMTP");
        prop.setProperty("mail.smtp.auth", "true");

        Authenticator authenticator=new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("312764843@qq.com","zpazrmayvmfzbiah");
            }
        };

        Session session=Session.getInstance(prop, authenticator);

        MimeMessage message=new MimeMessage(session);
        try {
            Address fromAddress=new InternetAddress("312764843@qq.com","同学录团队");
            message.setText(emailPrefix+randomVeriNum+emailSuffix);
            message.setFrom(fromAddress);

            message.setRecipients(Message.RecipientType.TO,targetAddress);

            Transport.send(message);
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }

        return randomVeriNum;
    }
}
