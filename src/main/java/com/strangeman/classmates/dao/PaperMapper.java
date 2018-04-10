package com.strangeman.classmates.dao;

import com.strangeman.classmates.bean.Paper;
import com.strangeman.classmates.bean.PaperExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface PaperMapper {
    String table_name="paper";

    long countByExample(PaperExample example);

    int deleteByExample(PaperExample example);

    int insert(Paper record);

    int insertSelective(Paper record);

    List<Paper> selectByExampleWithBLOBs(PaperExample example);

    List<Paper> selectByExample(PaperExample example);

    int updateByExampleSelective(@Param("record") Paper record, @Param("example") PaperExample example);

    int updateByExampleWithBLOBs(@Param("record") Paper record, @Param("example") PaperExample example);

    int updateByExample(@Param("record") Paper record, @Param("example") PaperExample example);

    @Select("select * from "
            + table_name
            + " where classmate_id=#{classmateId}")
    List<Paper> selectPapersByClassmateId(@Param("classmateId") String classmateId);
}