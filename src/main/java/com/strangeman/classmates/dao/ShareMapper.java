package com.strangeman.classmates.dao;

import com.strangeman.classmates.bean.Share;
import com.strangeman.classmates.bean.ShareExample;
import com.strangeman.classmates.bean.ShareWithBLOBs;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ShareMapper {
    long countByExample(ShareExample example);

    int deleteByExample(ShareExample example);

    int insert(ShareWithBLOBs record);

    int insertSelective(ShareWithBLOBs record);

    List<ShareWithBLOBs> selectByExampleWithBLOBs(ShareExample example);

    List<Share> selectByExample(ShareExample example);

    int updateByExampleSelective(@Param("record") ShareWithBLOBs record, @Param("example") ShareExample example);

    int updateByExampleWithBLOBs(@Param("record") ShareWithBLOBs record, @Param("example") ShareExample example);

    int updateByExample(@Param("record") Share record, @Param("example") ShareExample example);
}