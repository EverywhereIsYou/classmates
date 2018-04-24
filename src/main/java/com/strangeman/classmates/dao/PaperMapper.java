package com.strangeman.classmates.dao;

import com.strangeman.classmates.bean.Paper;
import com.strangeman.classmates.bean.PaperExample;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
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

    @Select("select paper.*,member.nickname as author_name,member.avatar as author_avatar from "
            + table_name
            + " left join member on(paper.author_id=member.id) where classmate_id=#{classmateId} "
            + " order by create_time desc")
    List<Paper> selectPapersByClassmateId(@Param("classmateId") String classmateId);

    @Select("select * from "
            +table_name
            +" where id=#{paperId}")
    Paper selectPaperById(@Param("paperId") String paperId);

    @Delete("delete from "
            +table_name
            +" where id=#{paperId}")
    int deletePaperById(@Param("paperId") String paperId);
}