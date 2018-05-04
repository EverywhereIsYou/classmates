package com.strangeman.classmates.service;

import com.strangeman.classmates.bean.Member;

import java.util.List;

public interface MemberService {
    boolean register(Member member);
    boolean hasExist(String username);
    Member login(String username,String password);
    Member getMemberById(String memberId);
    List<Member> getAllMember();
    boolean deleteMemberById(String memberId);
}
