package com.strangeman.classmates.bean;

public class ClassmateWithBLOBs extends Classmate {
    private String photoWall;

    private String customizeFiled;

    public String getPhotoWall() {
        return photoWall;
    }

    public void setPhotoWall(String photoWall) {
        this.photoWall = photoWall == null ? null : photoWall.trim();
    }

    public String getCustomizeFiled() {
        return customizeFiled;
    }

    public void setCustomizeFiled(String customizeFiled) {
        this.customizeFiled = customizeFiled == null ? null : customizeFiled.trim();
    }
}