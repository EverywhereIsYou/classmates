package com.strangeman.classmates.service;

import com.strangeman.classmates.bean.Member;

public interface MemberService {
    boolean register(Member member);
    boolean hasExist(String username);
}
