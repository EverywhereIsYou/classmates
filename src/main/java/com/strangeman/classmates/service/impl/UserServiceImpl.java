package com.strangeman.classmates.service.impl;

import com.strangeman.classmates.bean.User;
import com.strangeman.classmates.bean.UserExample;
import com.strangeman.classmates.dao.UserMapper;
import com.strangeman.classmates.service.UserService;
import com.strangeman.classmates.utils.AES;
import com.strangeman.classmates.utils.DataFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

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
        example.setOrderByClause("CONVERT(role USING gbk) asc,last_modify_time desc");
        return userMapper.selectByExample(example);
    }

    @Override
    public boolean createUser(User user) {
        if (user==null)
            return false;

        user.setId(UUID.randomUUID().toString());
        user.setCreateTime(DataFactory.getCurrentTime());
        user.setLastModifyTime(user.getCreateTime());
        try {
            user.setPwd(AES.encrypt(user.getPwd()));
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

        return userMapper.insertSelective(user)==1;
    }

    @Override
    public boolean modifyUser(User user) {
        if(user==null)
            return false;

        user.setLastModifyTime(DataFactory.getCurrentTime());

        UserExample example=new UserExample();
        UserExample.Criteria criteria=example.createCriteria();
        criteria.andIdEqualTo(user.getId());

        return userMapper.updateByExampleSelective(user,example)==1;
    }

    @Override
    public boolean deleteUser(String userId) {
        UserExample example=new UserExample();
        UserExample.Criteria criteria=example.createCriteria();
        criteria.andIdEqualTo(userId);

        return userMapper.deleteByExample(example)==1;
    }

    @Override
    public User getUserById(String userId) {
        return userMapper.selectByUserId(userId);
    }
}
