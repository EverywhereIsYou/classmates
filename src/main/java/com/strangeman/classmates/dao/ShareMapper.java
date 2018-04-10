package com.strangeman.classmates.dao;

import com.strangeman.classmates.bean.Share;
import com.strangeman.classmates.bean.ShareExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ShareMapper {
    long countByExample(ShareExample example);

    int deleteByExample(ShareExample example);

    int insert(Share record);

    int insertSelective(Share record);

    List<Share> selectByExampleWithBLOBs(ShareExample example);

    List<Share> selectByExample(ShareExample example);

    int updateByExampleSelective(@Param("record") Share record, @Param("example") ShareExample example);

    int updateByExampleWithBLOBs(@Param("record") Share record, @Param("example") ShareExample example);

    int updateByExample(@Param("record") Share record, @Param("example") ShareExample example);
}