package com.strangeman.classmates.service;

import com.strangeman.classmates.bean.Comment;

import java.util.List;

public interface CommentService {
    List<Comment> getCommentsByClassmateId(String classmateId);
    boolean createComment(Comment comment);
    List<Comment> getAllComment();
    boolean deleteComment(String commentId);
}
