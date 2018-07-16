package com.version1.commons.utils;

import com.version1.entity.UserInfo;
import com.version1.service.UserService;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

/**
 * @ClassName FilterUtil
 * @Description TODO
 * @Date 2018/6/1 0:22
 * @Version 1.0
 */
@Component
public class FilterUtil {

    @Autowired
    private UserService userService;
    private static FilterUtil filterUtil;
    @PostConstruct
    public void init(){
        filterUtil = this;
        filterUtil.userService = userService;
    }

    public static void initUserContext(String username, Subject subject){
        Session session = subject.getSession(true);
        UserInfo userInfo = filterUtil.userService.findByUsername(username);
        session.setAttribute("user",userInfo);
    }

}
