package com.strangeman.classmates.service.impl;

import com.strangeman.classmates.bean.Paper;
import com.strangeman.classmates.dao.PaperMapper;
import com.strangeman.classmates.service.PaperService;
import com.strangeman.classmates.utils.DataFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public class PaperServiceImpl implements PaperService{
    @Autowired
    private PaperMapper paperMapper;

    public boolean createPaper(Paper paper) {
        if(paper==null)
            return false;
        if(paper.getClassmateId()==null||"".equals(paper.getClassmateId()))
            return false;

        paper.setId(UUID.randomUUID().toString());
        paper.setCreateTime(DataFactory.getCurrentTime());

        return paperMapper.insertSelective(paper)==1;
    }
}
