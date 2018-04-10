package com.strangeman.classmates.dao;

import com.strangeman.classmates.bean.Classmate;
import com.strangeman.classmates.bean.ClassmateExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface ClassmateMapper {
    String table_name="classmate";

    long countByExample(ClassmateExample example);

    int deleteByExample(ClassmateExample example);

    int insert(Classmate record);

    int insertSelective(Classmate record);

    List<Classmate> selectByExample(ClassmateExample example);

    int updateByExampleSelective(@Param("record") Classmate record, @Param("example") ClassmateExample example);

    int updateByExampleWithBLOBs(@Param("record") Classmate record, @Param("example") ClassmateExample example);

    int updateByExample(@Param("record") Classmate record, @Param("example") ClassmateExample example);

    @Select("select * from "
            + table_name
            + " where owner_id=#{userId}")
    List<Classmate> selectClassmatesByUserId(@Param("userId") String userId);

    @Select("select * from "
            +table_name
            +" where id=#{classmateId}")
    Classmate selectClassmateById(@Param("classmateId") String classmateId);
}