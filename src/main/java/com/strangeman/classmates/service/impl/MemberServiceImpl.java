package com.strangeman.classmates.service.impl;

import com.strangeman.classmates.bean.Member;
import com.strangeman.classmates.dao.MemberMapper;
import com.strangeman.classmates.service.MemberService;
import com.strangeman.classmates.utils.DataFactory;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public class MemberServiceImpl implements MemberService{
    private Log log= LogFactory.getLog(MemberServiceImpl.class);

    @Autowired
    private MemberMapper memberMapper;

    public boolean register(Member member) {
        member.setId(UUID.randomUUID().toString());
        member.setCreateTime(DataFactory.getCurrentTime());

        log.info("register user:"+((member.getPhone()==null)?member.getEmail():member.getPhone()));

        return memberMapper.insert(member)==1;
    }

    public boolean hasExist(String username) {
        return memberMapper.selectByUsername(username)!=null;
    }

    public Member login(String username, String password) {
        Member member=memberMapper.selectByUsername(username);

        if(member!=null){
            if(member.getPwd().equals(password)){
                log.info("user:"+username+" login successfully");
                return member;
            }
            else{
                log.info("user:"+username+" password error");
                return null;
            }
        }

        return null;
    }
}
