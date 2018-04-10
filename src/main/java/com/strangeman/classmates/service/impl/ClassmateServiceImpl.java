package com.strangeman.classmates.service.impl;

import com.strangeman.classmates.bean.Classmate;
import com.strangeman.classmates.dao.ClassmateMapper;
import com.strangeman.classmates.dao.CommentMapper;
import com.strangeman.classmates.dao.PaperMapper;
import com.strangeman.classmates.service.ClassmateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClassmateServiceImpl implements ClassmateService{
    @Autowired
    private ClassmateMapper classmateMapper;
    @Autowired
    private PaperMapper paperMapper;
    @Autowired
    private CommentMapper commentMapper;

    public List<Classmate> getClassmatesByUserId(String userId) {
        return classmateMapper.selectClassmatesByUserId(userId);
    }

    public Classmate getClassmateById(String classmateId) {
        Classmate classmate=classmateMapper.selectClassmateById(classmateId);
        if(classmate!=null){
            classmate.setPapers(paperMapper.selectPapersByClassmateId(classmateId));
            classmate.setComments(commentMapper.selectCommentsByClassmateId(classmateId));
            return classmate;
        }

        return null;
    }
}
