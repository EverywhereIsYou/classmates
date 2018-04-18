package com.strangeman.classmates.bean;

public class Comment {
    private String id;

    private String classmateId;

    private String memberId;

    private String createTime;

    private String content;

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

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId == null ? null : memberId.trim();
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
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
        return "Comment{" +
                "id='" + id + '\'' +
                ", classmateId='" + classmateId + '\'' +
                ", memberId='" + memberId + '\'' +
                ", createTime='" + createTime + '\'' +
                ", content='" + content + '\'' +
                ", authorName='" + authorName + '\'' +
                ", authorAvatar='" + authorAvatar + '\'' +
                '}';
    }
}