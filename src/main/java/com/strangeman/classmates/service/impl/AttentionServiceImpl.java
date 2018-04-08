package com.strangeman.classmates.service.impl;

import com.strangeman.classmates.dao.AttentionMapper;
import com.strangeman.classmates.service.AttentionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AttentionServiceImpl implements AttentionService{
    @Autowired
    private AttentionMapper attentionMapper;

    public int countFans(String userId) {
        return attentionMapper.countFans(userId);
    }

    public int countAttentions(String userId) {
        return attentionMapper.countAttentions(userId);
    }
}
