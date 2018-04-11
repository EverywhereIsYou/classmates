package com.strangeman.classmates.utils;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

public class AES {
    private static final String ALGORITHM = "AES";
    private static final String SEED="542541";
    private static final String KEY_PATH="D:\\work\\project\\classmates\\aestest.txt";

    private static SecretKey secretKey;

    public static String encrypt(String original) throws Exception{
        if(original==null||"".equals(original)){
            return "";
        }

        Cipher cipher=Cipher.getInstance(ALGORITHM);
        SecretKey secretKey=getKey();
        cipher.init(Cipher.ENCRYPT_MODE,secretKey);
        cipher.update(original.getBytes());
        byte[] result=cipher.doFinal();

        return Base64.getEncoder().encodeToString(result);
    }

    public static String decrypt(String cipherText) throws Exception{
        if(cipherText==null||"".equals(cipherText)){
            return "";
        }

        Cipher cipher=Cipher.getInstance(ALGORITHM);
        SecretKey secretKey=getKey();
        cipher.init(Cipher.DECRYPT_MODE,secretKey);
        byte[] encodedBytes=Base64.getDecoder().decode(cipherText.getBytes());
        cipher.update(encodedBytes);

        return new String(cipher.doFinal());
    }

    private static SecretKey getKey(){
        if(AES.secretKey==null) {
            SecretKey secretKey = readKey();
            if (secretKey == null) {
                secretKey = generateKey();
            }
            if (secretKey == null) {
                throw new RuntimeException("无法获取到密钥");
            }
            AES.secretKey=secretKey;
        }

        return secretKey;
    }

    private static SecretKey generateKey(){
        KeyGenerator generator;
        try {
            generator = KeyGenerator.getInstance(ALGORITHM);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
        SecureRandom random=new SecureRandom();
        random.setSeed(SEED.getBytes());
        generator.init(random);
        SecretKey secretKey=generator.generateKey();

        if(secretKey!=null) {
            try {
                Files.write(Paths.get(KEY_PATH), secretKey.getEncoded());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return secretKey;
    }

    private static SecretKey readKey(){
        byte[] keyBytes;
        try {
            keyBytes = Files.readAllBytes(Paths.get(KEY_PATH));
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }

        return keyBytes.length==0?null:new SecretKeySpec(keyBytes,ALGORITHM);
    }
}
