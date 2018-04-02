package com.strangeman.classmates.utils;

public class MyStringUtil {
    public static boolean isEmail(String source){
        return source!=null&&!source.equals("")&&source.matches("^([a-z0-9A-Z_.-]+)@([\\da-zA-Z_.-]+)\\.([\\da-zA-Z_.-]+)$");
    }
    public static boolean isPhone(String source){
        return source!=null&&!source.equals("")&&source.matches("^((13[0-9])|(14[5|7])|(15([0-3]|[5-9]))|(17[013678])|(18[0,5-9]))\\d{8}$");
    }
}
