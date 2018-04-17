package com.strangeman.classmates.bean;

import java.util.List;

public class Classmate {
    private String id;

    private String school;

    private String clazz;

    private String name;

    private String description;

    private String ownerId;

    private String cover;

    private Integer permission;

    private String createTime;

    private String lastModifyTime;

    private String photoWall;

    private String customizeFiled;

    private List<Paper> papers;

    private List<Comment> comments;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getSchool() {
        return school;
    }

    public void setSchool(String school) {
        this.school = school == null ? null : school.trim();
    }

    public String getClazz() {
        return clazz;
    }

    public void setClazz(String clazz) {
        this.clazz = clazz == null ? null : clazz.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(String ownerId) {
        this.ownerId = ownerId == null ? null : ownerId.trim();
    }

    public String getCover() {
        return cover;
    }

    public void setCover(String cover) {
        this.cover = cover == null ? null : cover.trim();
    }

    public Integer getPermission() {
        return permission;
    }

    public void setPermission(Integer permission) {
        this.permission = permission;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }

    public String getLastModifyTime() {
        return lastModifyTime;
    }

    public void setLastModifyTime(String lastModifyTime) {
        this.lastModifyTime = lastModifyTime == null ? null : lastModifyTime.trim();
    }

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

    public List<Paper> getPapers() {
        return papers;
    }

    public void setPapers(List<Paper> papers) {
        this.papers = papers;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    @Override
    public String toString() {
        return "Classmate{" +
                "id='" + id + '\'' +
                ", school='" + school + '\'' +
                ", clazz='" + clazz + '\'' +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", ownerId='" + ownerId + '\'' +
                ", cover='" + cover + '\'' +
                ", permission=" + permission +
                ", createTime='" + createTime + '\'' +
                ", lastModifyTime='" + lastModifyTime + '\'' +
                ", photoWall='" + photoWall + '\'' +
                ", customizeFiled='" + customizeFiled + '\'' +
                ", papers=" + papers +
                ", comments=" + comments +
                '}';
    }
}