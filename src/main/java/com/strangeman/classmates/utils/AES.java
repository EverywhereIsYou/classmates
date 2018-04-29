package com.strangeman.classmates.utils;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class AES {
    private static final String ALGORITHM = "AES";
    private static final String SEED="542541";
    private static SecretKey secretKey;

    private static final Lock lock=new ReentrantLock();

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
        lock.lock();
        if(AES.secretKey==null) {
            secretKey = generateKey();

            if (secretKey == null) {
                lock.unlock();
                throw new RuntimeException("无法获取到密钥");
            }
        }
        lock.unlock();

        return secretKey;
    }

    private static SecretKey generateKey(){
        KeyGenerator generator;
        SecureRandom random;
        try {
            generator = KeyGenerator.getInstance(ALGORITHM);
            random=SecureRandom.getInstance("SHA1PRNG");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
        random.setSeed(SEED.getBytes());
        generator.init(random);
        return generator.generateKey();
    }
}
