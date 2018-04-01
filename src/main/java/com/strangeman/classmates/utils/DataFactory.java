package com.strangeman.classmates.utils;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

public class DataFactory {
    public static int getRandomVeriNum(){
        double temp;

        do{
            temp=Math.random()*1000000;
        } while (temp==0);

        while(temp<100000){
            temp*=10;
        }
        return (int)temp;
    }

    public static String getCurrentTime(){
        DateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return format.format(System.currentTimeMillis());
    }
}
