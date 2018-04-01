package com.strangeman.classmates.bean;

public class PaperWithBLOBs extends Paper {
    private String favThingToDo;

    private String specialInClass;

    private String wordToMe;

    private String customizeFiled;

    public String getFavThingToDo() {
        return favThingToDo;
    }

    public void setFavThingToDo(String favThingToDo) {
        this.favThingToDo = favThingToDo == null ? null : favThingToDo.trim();
    }

    public String getSpecialInClass() {
        return specialInClass;
    }

    public void setSpecialInClass(String specialInClass) {
        this.specialInClass = specialInClass == null ? null : specialInClass.trim();
    }

    public String getWordToMe() {
        return wordToMe;
    }

    public void setWordToMe(String wordToMe) {
        this.wordToMe = wordToMe == null ? null : wordToMe.trim();
    }

    public String getCustomizeFiled() {
        return customizeFiled;
    }

    public void setCustomizeFiled(String customizeFiled) {
        this.customizeFiled = customizeFiled == null ? null : customizeFiled.trim();
    }
}