package com.strangeman.classmates.dao;

import com.strangeman.classmates.bean.Paper;
import com.strangeman.classmates.bean.PaperExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PaperMapper {
    long countByExample(PaperExample example);

    int deleteByExample(PaperExample example);

    List<Paper> selectByExample(PaperExample example);

    int updateByExample(@Param("record") Paper record, @Param("example") PaperExample example);
}