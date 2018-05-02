package com.strangeman.classmates.service.impl;

import com.strangeman.classmates.bean.User;
import com.strangeman.classmates.bean.UserExample;
import com.strangeman.classmates.dao.UserMapper;
import com.strangeman.classmates.service.UserService;
import com.strangeman.classmates.utils.AES;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService{
    @Autowired
    private UserMapper userMapper;

    private Logger logger= LoggerFactory.getLogger(UserServiceImpl.class);

    @Override
    public User login(String workId, String password) {
        User user=userMapper.selectByWorkId(workId);

        if(user==null)
            return null;

        String pwd;
        try {
            pwd=AES.decrypt(user.getPwd());
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

        if(pwd.equals(password)){
            logger.info("user:"+workId+" login successfully");
            return user;
        }

        logger.info("user:"+workId+" password error");
        return null;
    }

    @Override
    public List<User> getAllUser() {
        UserExample example=new UserExample();
        example.setOrderByClause("role desc,last_modify_time desc");
        return userMapper.selectByExample(example);
    }
}
