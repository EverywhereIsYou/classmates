package com.strangeman.classmates.service.impl;

import com.strangeman.classmates.bean.Paper;
import com.strangeman.classmates.bean.PaperExample;
import com.strangeman.classmates.dao.PaperMapper;
import com.strangeman.classmates.service.PaperService;
import com.strangeman.classmates.utils.DataFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
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

    @Override
    public boolean deletePaper(String paperId) {
        return paperId != null && !paperId.equals("") && paperMapper.deletePaperById(paperId) > 0;
    }

    @Override
    public Paper getPaperById(String paperId) {
        if(paperId==null||paperId.equals(""))
            return null;
        return paperMapper.selectPaperById(paperId);
    }

    @Override
    public List<Paper> getPapersByClassmateId(String classmateId) {
        if(classmateId==null||classmateId.equals(""))
            return null;
        return paperMapper.selectPapersByClassmateId(classmateId);
    }

    @Override
    public List<Paper> getAllPaper() {
        PaperExample example=new PaperExample();
        example.setOrderByClause("create_time desc");
        return paperMapper.selectByExampleWithBLOBs(example);
    }
}
