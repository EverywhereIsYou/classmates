package com.strangeman.classmates.dao;

import com.strangeman.classmates.bean.Classmate;
import com.strangeman.classmates.bean.ClassmateExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ClassmateMapper {
    long countByExample(ClassmateExample example);

    int deleteByExample(ClassmateExample example);

    List<Classmate> selectByExample(ClassmateExample example);

    int updateByExample(@Param("record") Classmate record, @Param("example") ClassmateExample example);
}