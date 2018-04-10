package com.strangeman.classmates.service;

import com.strangeman.classmates.bean.Classmate;

import java.util.List;

public interface ClassmateService {
    List<Classmate> getClassmatesByUserId(String userId);
    Classmate getClassmateById(String classmateId);
}
