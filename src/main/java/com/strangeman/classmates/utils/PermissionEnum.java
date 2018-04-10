package com.strangeman.classmates.utils;

public enum PermissionEnum {
    OWNER(1),
    WRITER(2),
    ALL(3);

    private int num;

    PermissionEnum(int num){
        this.num=num;
    }

    public int getNum(){
        return num;
    }
}
