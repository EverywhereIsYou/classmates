package com.strangeman.classmates.dao;

import com.strangeman.classmates.bean.Attention;
import com.strangeman.classmates.bean.AttentionExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AttentionMapper {
    long countByExample(AttentionExample example);

    int deleteByExample(AttentionExample example);

    int insert(Attention record);

    int insertSelective(Attention record);

    List<Attention> selectByExample(AttentionExample example);

    int updateByExampleSelective(@Param("record") Attention record, @Param("example") AttentionExample example);

    int updateByExample(@Param("record") Attention record, @Param("example") AttentionExample example);
}