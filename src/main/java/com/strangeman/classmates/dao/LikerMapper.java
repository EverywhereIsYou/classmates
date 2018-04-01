package com.strangeman.classmates.dao;

import com.strangeman.classmates.bean.Liker;
import com.strangeman.classmates.bean.LikerExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface LikerMapper {
    long countByExample(LikerExample example);

    int deleteByExample(LikerExample example);

    int insert(Liker record);

    int insertSelective(Liker record);

    List<Liker> selectByExample(LikerExample example);

    int updateByExampleSelective(@Param("record") Liker record, @Param("example") LikerExample example);

    int updateByExample(@Param("record") Liker record, @Param("example") LikerExample example);
}