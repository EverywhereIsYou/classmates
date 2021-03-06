package com.strangeman.classmates.dao;

import com.strangeman.classmates.bean.Comment;
import com.strangeman.classmates.bean.CommentExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface CommentMapper {
    String table_name="comment";

    long countByExample(CommentExample example);

    int deleteByExample(CommentExample example);

    int insert(Comment record);

    int insertSelective(Comment record);

    List<Comment> selectByExampleWithBLOBs(CommentExample example);

    List<Comment> selectByExample(CommentExample example);

    int updateByExampleSelective(@Param("record") Comment record, @Param("example") CommentExample example);

    int updateByExampleWithBLOBs(@Param("record") Comment record, @Param("example") CommentExample example);

    int updateByExample(@Param("record") Comment record, @Param("example") CommentExample example);

    @Select("select comment.*,member.nickname as author_name,member.avatar as author_avatar from "
            + table_name
            + " left join member on(comment.member_id=member.id)"
            + " where classmate_id=#{classmateId} order by create_time desc")
    List<Comment> selectCommentsByClassmateId(@Param("classmateId") String classmateId);
}