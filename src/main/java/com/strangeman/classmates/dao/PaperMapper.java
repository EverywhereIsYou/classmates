package com.strangeman.classmates.dao;

import com.strangeman.classmates.bean.Paper;
import com.strangeman.classmates.bean.PaperExample;
import com.strangeman.classmates.bean.PaperWithBLOBs;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface PaperMapper {
    long countByExample(PaperExample example);

    int deleteByExample(PaperExample example);

    int insert(PaperWithBLOBs record);

    int insertSelective(PaperWithBLOBs record);

    List<PaperWithBLOBs> selectByExampleWithBLOBs(PaperExample example);

    List<Paper> selectByExample(PaperExample example);

    int updateByExampleSelective(@Param("record") PaperWithBLOBs record, @Param("example") PaperExample example);

    int updateByExampleWithBLOBs(@Param("record") PaperWithBLOBs record, @Param("example") PaperExample example);

    int updateByExample(@Param("record") Paper record, @Param("example") PaperExample example);
}