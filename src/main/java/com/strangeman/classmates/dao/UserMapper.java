package com.strangeman.classmates.dao;

import com.strangeman.classmates.bean.User;
import com.strangeman.classmates.bean.UserExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface UserMapper {
    String table_name="user";

    long countByExample(UserExample example);

    int deleteByExample(UserExample example);

    int insert(User record);

    int insertSelective(User record);

    List<User> selectByExample(UserExample example);

    int updateByExampleSelective(@Param("record") User record, @Param("example") UserExample example);

    int updateByExample(@Param("record") User record, @Param("example") UserExample example);

    @Select("select * from "
            + table_name
            + " where work_id=#{workId}")
    User selectByWorkId(@Param("workId") String workId);
}