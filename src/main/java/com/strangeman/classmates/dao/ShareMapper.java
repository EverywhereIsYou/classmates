package com.strangeman.classmates.dao;

import com.strangeman.classmates.bean.Share;
import com.strangeman.classmates.bean.ShareExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ShareMapper {
    long countByExample(ShareExample example);

    int deleteByExample(ShareExample example);

    List<Share> selectByExample(ShareExample example);

    int updateByExample(@Param("record") Share record, @Param("example") ShareExample example);
}