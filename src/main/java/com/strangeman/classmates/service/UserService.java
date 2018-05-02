package com.strangeman.classmates.service;

import com.strangeman.classmates.bean.User;

import java.util.List;

public interface UserService {
    User login(String workId,String password);
    List<User> getAllUser();
}
