package com.strangeman.classmates.dao;

import com.strangeman.classmates.bean.Attention;
import com.strangeman.classmates.bean.AttentionExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface AttentionMapper {
    String table_name="attention";

    long countByExample(AttentionExample example);

    int deleteByExample(AttentionExample example);

    int insert(Attention record);

    int insertSelective(Attention record);

    List<Attention> selectByExample(AttentionExample example);

    int updateByExampleSelective(@Param("record") Attention record, @Param("example") AttentionExample example);

    int updateByExample(@Param("record") Attention record, @Param("example") AttentionExample example);

    @Select("select count(*) from "
            + table_name
            + " where attention_id=#{userId}")
    int countFans(@Param("userId") String userId);

    @Select("select count(*) from "
            +table_name
            +" where fan_id=#{userId}")
    int countAttentions(@Param("userId") String userid);
}