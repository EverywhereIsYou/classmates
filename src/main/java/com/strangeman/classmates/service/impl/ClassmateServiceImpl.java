package com.strangeman.classmates.service.impl;

import com.strangeman.classmates.bean.Classmate;
import com.strangeman.classmates.bean.ClassmateExample;
import com.strangeman.classmates.dao.ClassmateMapper;
import com.strangeman.classmates.dao.CommentMapper;
import com.strangeman.classmates.dao.PaperMapper;
import com.strangeman.classmates.service.ClassmateService;
import com.strangeman.classmates.utils.DataFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.UUID;

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

    public Classmate getSimpleClassmateById(String classmateId) {
        return classmateMapper.selectClassmateById(classmateId);
    }

    public Classmate getCompleteClassmateById(String classmateId) {
        Classmate classmate=classmateMapper.selectClassmateById(classmateId);
        if(classmate!=null){
            classmate.setPapers(paperMapper.selectPapersByClassmateId(classmateId));
            classmate.setComments(commentMapper.selectCommentsByClassmateId(classmateId));
        }

        return classmate;
    }

    public boolean createClassmate(Classmate classmate) {
        if (classmate==null)
            return false;
        if(StringUtils.isEmpty(classmate.getSchool())||StringUtils.isEmpty(classmate.getClazz())
                ||StringUtils.isEmpty(classmate.getName())||StringUtils.isEmpty(classmate.getOwnerId()))
            return false;

        classmate.setId(UUID.randomUUID().toString());
        classmate.setCreateTime(DataFactory.getCurrentTime());
        classmate.setLastModifyTime(classmate.getCreateTime());

        return classmateMapper.insertSelective(classmate)==1;
    }

    @Override
    public boolean deleteClassmate(String classmateId) {
        return !StringUtils.isEmpty(classmateId) && classmateMapper.deleteClassmateById(classmateId) > 0;

    }

    @Override
    public boolean modifyClassmate(Classmate classmate) {
        if(classmate==null||StringUtils.isEmpty(classmate.getId()))
            return false;

        classmate.setLastModifyTime(DataFactory.getCurrentTime());

        ClassmateExample example=new ClassmateExample();
        ClassmateExample.Criteria criteria=example.createCriteria();
        criteria.andIdEqualTo(classmate.getId());

        return classmateMapper.updateByExampleSelective(classmate,example)==1;
    }

    @Override
    public List<Classmate> getAllClassmate() {
        ClassmateExample example=new ClassmateExample();
        example.setOrderByClause("last_modify_time desc");
        return classmateMapper.selectByExample(example);
    }
}
