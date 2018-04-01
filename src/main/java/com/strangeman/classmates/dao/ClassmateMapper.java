package com.strangeman.classmates.dao;

import com.strangeman.classmates.bean.Classmate;
import com.strangeman.classmates.bean.ClassmateExample;
import com.strangeman.classmates.bean.ClassmateWithBLOBs;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ClassmateMapper {
    long countByExample(ClassmateExample example);

    int deleteByExample(ClassmateExample example);

    int insert(ClassmateWithBLOBs record);

    int insertSelective(ClassmateWithBLOBs record);

    List<ClassmateWithBLOBs> selectByExampleWithBLOBs(ClassmateExample example);

    List<Classmate> selectByExample(ClassmateExample example);

    int updateByExampleSelective(@Param("record") ClassmateWithBLOBs record, @Param("example") ClassmateExample example);

    int updateByExampleWithBLOBs(@Param("record") ClassmateWithBLOBs record, @Param("example") ClassmateExample example);

    int updateByExample(@Param("record") Classmate record, @Param("example") ClassmateExample example);
}