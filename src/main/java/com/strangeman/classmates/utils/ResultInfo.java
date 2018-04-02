package com.strangeman.classmates.utils;

import java.util.HashMap;
import java.util.Map;

public class ResultInfo {
    private int statusCode;
    private String msg;
    private Map<String,Object> extend=new HashMap<String, Object>();

    public int getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(int statusCode) {
        this.statusCode = statusCode;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }

    private ResultInfo(int statusCode,String msg){
        this.statusCode=statusCode;
        this.msg=msg;
    }

    public static ResultInfo success(String msg){
        return new ResultInfo(200,msg);
    }
    public static ResultInfo fail(String msg){
        return new ResultInfo(400,msg);
    }

    public ResultInfo add(String key,Object value){
        extend.put(key,value);
        return this;
    }
}
