package com.strangeman.classmates.utils;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.util.Random;

public class GraphicVeriCode {
    private BufferedImage image;
    private String text;

    private static Random random=new Random();

    private static char[] chars={
            '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
            'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U',
            'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i',
            'j', 'k', 'm', 'n', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
    };
    private static String[] fonts={
            "宋体","华文楷体", "黑体", "微软雅黑", "楷体_GB2312"
    };

    public GraphicVeriCode(){
        createImage();
    }

    public BufferedImage getImage(){
        return image;
    }

    public String getText(){
        return text;
    }

    private void createImage(){
        int width=100,height=50;

        //创建画布并获取画笔
        BufferedImage image=new BufferedImage(width,height,BufferedImage.TYPE_INT_BGR);
        Graphics2D pen= (Graphics2D) image.getGraphics();
        pen.setColor(Color.LIGHT_GRAY);
        pen.fillRect(0,0,width,height);

        //画字符
        StringBuilder text=new StringBuilder();
        for(int i=1;i<6;i++){
            float x=i*width/7;
            char c=chars[random.nextInt(chars.length)];
            text.append(c);
            pen.setColor(new Color(random.nextInt(155),random.nextInt(155),random.nextInt(155)));
            pen.setFont(new Font(fonts[random.nextInt(fonts.length)],Font.ITALIC,random.nextInt(5)+24));
            pen.drawString(String.valueOf(c),x,random.nextInt(height/2)+25);
        }
        this.text=text.toString();

        //画干扰线
        for(int i=0;i<5;i++){
            int x1=random.nextInt(width);
            int y1=random.nextInt(height);
            int x2=random.nextInt(width);
            int y2=random.nextInt(height);

            pen.setColor(new Color(random.nextInt(200),random.nextInt(200),random.nextInt(200)));
            pen.drawLine(x1,y1,x2,y2);
        }

        this.image=image;
    }
}
