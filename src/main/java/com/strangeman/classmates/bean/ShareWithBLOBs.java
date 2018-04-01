package com.strangeman.classmates.bean;

public class ShareWithBLOBs extends Share {
    private String content;

    private String collectorId;

    private String likerId;

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public String getCollectorId() {
        return collectorId;
    }

    public void setCollectorId(String collectorId) {
        this.collectorId = collectorId == null ? null : collectorId.trim();
    }

    public String getLikerId() {
        return likerId;
    }

    public void setLikerId(String likerId) {
        this.likerId = likerId == null ? null : likerId.trim();
    }
}