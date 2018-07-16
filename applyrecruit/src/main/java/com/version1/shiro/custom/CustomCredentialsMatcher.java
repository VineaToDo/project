package com.version1.shiro.custom;

import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authc.credential.SimpleCredentialsMatcher;

/**
 * @ClassName CustomCredentialsMatcher
 * @Description TODO
 * @Date 2018/5/30 15:16
 * @Version 1.0
 */
@Slf4j
public class CustomCredentialsMatcher extends SimpleCredentialsMatcher {

    @Override
    public boolean doCredentialsMatch(AuthenticationToken token, AuthenticationInfo info) {

        UsernamePasswordToken utoken = (UsernamePasswordToken) token;
        String inPassword = String.valueOf(utoken.getPassword());
        String dbPassword = (String) info.getCredentials();
        log.info("校验密码.........");
        return this.equals(inPassword,dbPassword);
    }
}
