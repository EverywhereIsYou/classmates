package com.strangeman.classmates.utils;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class QRCode {
    public static BufferedImage getQRCode(String content){
        if(content==null||content.equals(""))
            return null;

        BufferedImage image=null;

        int size=200;
        Map<EncodeHintType,Object> hints=new HashMap<>();
        hints.put(EncodeHintType.CHARACTER_SET,"utf-8");
        hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H);
        hints.put(EncodeHintType.MARGIN,2);

        try {
            BitMatrix bitMatrix=new MultiFormatWriter().encode(content, BarcodeFormat.QR_CODE,size,size,hints);

            image=new BufferedImage(size,size,BufferedImage.TYPE_INT_BGR);
            for(int i=0;i<size;i++)
                for(int j=0;j<size;j++)
                    image.setRGB(i,j,bitMatrix.get(i,j)?Color.BLACK.getRGB():Color.WHITE.getRGB());

            File logoFile=new File(QRCode.class.getResource("/logo.png").getPath());
            if(logoFile.exists()){
                BufferedImage logo= ImageIO.read(logoFile);

                int logoSize=logo.getWidth()>size*2/10?size*2/10:logo.getWidth();
                int coordinate=(size-logoSize)/2;

                Graphics2D pen=image.createGraphics();
                pen.drawImage(logo,coordinate,coordinate,logoSize,logoSize,null);

                pen.dispose();
                logo.flush();
                image.flush();
            }
        } catch (WriterException | IOException e) {
            e.printStackTrace();
        }

        return image;
    }
}
