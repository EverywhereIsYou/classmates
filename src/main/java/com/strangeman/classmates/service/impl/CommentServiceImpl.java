package com.strangeman.classmates.service.impl;

import com.strangeman.classmates.bean.Comment;
import com.strangeman.classmates.dao.CommentMapper;
import com.strangeman.classmates.service.CommentService;
import com.strangeman.classmates.utils.DataFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.UUID;

@Service
public class CommentServiceImpl implements CommentService{
    @Autowired
    private CommentMapper commentMapper;

    public List<Comment> getCommentsByClassmateId(String classmateId) {
        if(StringUtils.isEmpty(classmateId))
            return null;

        return commentMapper.selectCommentsByClassmateId(classmateId);
    }

    public boolean createComment(Comment comment) {
        if(comment==null)
            return false;

        comment.setId(UUID.randomUUID().toString());
        comment.setCreateTime(DataFactory.getCurrentTime());

        return commentMapper.insertSelective(comment)==1;
    }
}
