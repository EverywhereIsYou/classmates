package com.strangeman.classmates.dao;

import com.strangeman.classmates.bean.Member;
import com.strangeman.classmates.bean.MemberExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MemberMapper {
    long countByExample(MemberExample example);

    int deleteByExample(MemberExample example);

    int insert(Member record);

    int insertSelective(Member record);

    List<Member> selectByExampleWithBLOBs(MemberExample example);

    List<Member> selectByExample(MemberExample example);

    int updateByExampleSelective(@Param("record") Member record, @Param("example") MemberExample example);

    int updateByExampleWithBLOBs(@Param("record") Member record, @Param("example") MemberExample example);

    int updateByExample(@Param("record") Member record, @Param("example") MemberExample example);
}