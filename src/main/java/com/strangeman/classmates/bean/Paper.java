package com.strangeman.classmates.bean;

public class Paper {
    private String id;

    private String classmateId;

    private String authorId;

    private String name;

    private String nickname;

    private String sex;

    private String birthday;

    private String address;

    private String phone;

    private String email;

    private String qq;

    private String wechat;

    private String photo;

    private String favMovie;

    private String favSinger;

    private String favBook;

    private String favTravelPlace;

    private String createTime;

    private Integer permission;

    private String favThingToDo;

    private String specialInClass;

    private String wordToMe;

    private String customizeFiled;

    private String authorName;

    private String authorAvatar;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getClassmateId() {
        return classmateId;
    }

    public void setClassmateId(String classmateId) {
        this.classmateId = classmateId == null ? null : classmateId.trim();
    }

    public String getAuthorId() {
        return authorId;
    }

    public void setAuthorId(String authorId) {
        this.authorId = authorId == null ? null : authorId.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname == null ? null : nickname.trim();
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex == null ? null : sex.trim();
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday == null ? null : birthday.trim();
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq == null ? null : qq.trim();
    }

    public String getWechat() {
        return wechat;
    }

    public void setWechat(String wechat) {
        this.wechat = wechat == null ? null : wechat.trim();
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo == null ? null : photo.trim();
    }

    public String getFavMovie() {
        return favMovie;
    }

    public void setFavMovie(String favMovie) {
        this.favMovie = favMovie == null ? null : favMovie.trim();
    }

    public String getFavSinger() {
        return favSinger;
    }

    public void setFavSinger(String favSinger) {
        this.favSinger = favSinger == null ? null : favSinger.trim();
    }

    public String getFavBook() {
        return favBook;
    }

    public void setFavBook(String favBook) {
        this.favBook = favBook == null ? null : favBook.trim();
    }

    public String getFavTravelPlace() {
        return favTravelPlace;
    }

    public void setFavTravelPlace(String favTravelPlace) {
        this.favTravelPlace = favTravelPlace == null ? null : favTravelPlace.trim();
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }

    public Integer getPermission() {
        return permission;
    }

    public void setPermission(Integer permission) {
        this.permission = permission;
    }

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

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public String getAuthorAvatar() {
        return authorAvatar;
    }

    public void setAuthorAvatar(String authorAvatar) {
        this.authorAvatar = authorAvatar;
    }

    @Override
    public String toString() {
        return "Paper{" +
                "id='" + id + '\'' +
                ", classmateId='" + classmateId + '\'' +
                ", authorId='" + authorId + '\'' +
                ", name='" + name + '\'' +
                ", nickname='" + nickname + '\'' +
                ", sex='" + sex + '\'' +
                ", birthday='" + birthday + '\'' +
                ", address='" + address + '\'' +
                ", phone='" + phone + '\'' +
                ", email='" + email + '\'' +
                ", qq='" + qq + '\'' +
                ", wechat='" + wechat + '\'' +
                ", photo='" + photo + '\'' +
                ", favMovie='" + favMovie + '\'' +
                ", favSinger='" + favSinger + '\'' +
                ", favBook='" + favBook + '\'' +
                ", favTravelPlace='" + favTravelPlace + '\'' +
                ", createTime='" + createTime + '\'' +
                ", permission=" + permission +
                ", favThingToDo='" + favThingToDo + '\'' +
                ", specialInClass='" + specialInClass + '\'' +
                ", wordToMe='" + wordToMe + '\'' +
                ", customizeFiled='" + customizeFiled + '\'' +
                ", authorName='" + authorName + '\'' +
                ", authorAvatar='" + authorAvatar + '\'' +
                '}';
    }
}