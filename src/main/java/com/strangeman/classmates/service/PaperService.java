package com.strangeman.classmates.service;

import com.strangeman.classmates.bean.Paper;

import java.util.List;

public interface PaperService {
    boolean createPaper(Paper paper);
    boolean deletePaper(String paperId);
    Paper getPaperById(String paperId);
    List<Paper> getPapersByClassmateId(String classmateId);
}
