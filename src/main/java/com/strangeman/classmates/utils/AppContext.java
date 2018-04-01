package com.strangeman.classmates.utils;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public interface AppContext {
    ApplicationContext context=new ClassPathXmlApplicationContext("applicationContext.xml");
}
