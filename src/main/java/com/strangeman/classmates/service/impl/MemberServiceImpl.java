package com.strangeman.classmates.service.impl;

import com.strangeman.classmates.bean.Member;
import com.strangeman.classmates.bean.MemberExample;
import com.strangeman.classmates.dao.MemberMapper;
import com.strangeman.classmates.service.MemberService;
import com.strangeman.classmates.utils.AES;
import com.strangeman.classmates.utils.DataFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.UUID;

@Service
public class MemberServiceImpl implements MemberService{
    private Logger log= LoggerFactory.getLogger(MemberServiceImpl.class);

    @Autowired
    private MemberMapper memberMapper;

    public boolean register(Member member) {
        member.setId(UUID.randomUUID().toString());
        member.setCreateTime(DataFactory.getCurrentTime());
        member.setLastModifyTime(member.getCreateTime());
        try {
            member.setPwd(AES.encrypt(member.getPwd()));
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

        log.info("register user:"+((member.getPhone()==null)?member.getEmail():member.getPhone()));

        return memberMapper.insert(member)==1;
    }

    public boolean hasExist(String username) {
        return memberMapper.selectByUsername(username)!=null;
    }

    public Member login(String username, String password) {
        Member member=memberMapper.selectByUsername(username);

        if(member!=null){
            String pwd;
            try {
                pwd=AES.decrypt(member.getPwd());
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }

            if(pwd.equals(password)){
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

    public Member getMemberById(String memberId) {
        return StringUtils.isEmpty(memberId)?null:memberMapper.selectById(memberId);
    }

    @Override
    public List<Member> getAllMember() {
        MemberExample example=new MemberExample();
        example.setOrderByClause("last_modify_time desc");
        return memberMapper.selectByExampleWithBLOBs(example);
    }

    @Override
    public boolean deleteMemberById(String memberId) {
        return memberMapper.deleteMemberById(memberId)==1;
    }
}
