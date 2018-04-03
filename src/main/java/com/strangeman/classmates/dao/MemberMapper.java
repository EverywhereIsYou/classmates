package com.strangeman.classmates.dao;

import com.strangeman.classmates.bean.Member;
import com.strangeman.classmates.bean.MemberExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface MemberMapper {
    String table_name="member";

    long countByExample(MemberExample example);

    int deleteByExample(MemberExample example);

    int insert(Member record);

    int insertSelective(Member record);

    List<Member> selectByExampleWithBLOBs(MemberExample example);

    List<Member> selectByExample(MemberExample example);

    int updateByExampleSelective(@Param("record") Member record, @Param("example") MemberExample example);

    int updateByExampleWithBLOBs(@Param("record") Member record, @Param("example") MemberExample example);

    int updateByExample(@Param("record") Member record, @Param("example") MemberExample example);

    @Select("select * from "
            + table_name
            + " where phone=#{username} or email=#{username}")
    Member selectByUsername(@Param("username") String username);
}