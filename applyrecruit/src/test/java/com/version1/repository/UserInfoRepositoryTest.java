package com.version1.repository;

import com.version1.entity.UserInfo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class UserInfoRepositoryTest {

    @Autowired
    private UserRepository userRepository;

    @Test
    public void findOneTest(){
        UserInfo userInfo = userRepository.findOne(1);
        System.out.println(userInfo.toString());
    }

    @Test
    public void saveTest(){
        UserInfo userInfo = new UserInfo();
        userInfo.setUserName("test01");
        userInfo.setPassword("test01");
        userRepository.save(userInfo);

    }


}