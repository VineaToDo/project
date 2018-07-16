package com.version1.shiro.custom;

import com.version1.entity.UserInfo;
import com.version1.service.UserService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @ClassName CustomRealm
 * @Description TODO
 * @Date 2018/5/30 14:13
 * @Version 1.0
 */
public class CustomRealm extends AuthorizingRealm {

    @Autowired
    private UserService userService;

    /**
     * @Description 认证登录
     * @Date 14:16 2018/5/30
     * @Param [authenticationToken]
     * @return org.apache.shiro.authc.AuthenticationInfo
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {

        UsernamePasswordToken utoken = (UsernamePasswordToken) authenticationToken;
        String username = utoken.getUsername();
        UserInfo userInfo = userService.findByUsername(username);
        if(userInfo == null) throw new UnknownAccountException("用户名不存在");
        else if(userInfo.getIsLocked()) throw new LockedAccountException("用户已锁定");
        return new SimpleAuthenticationInfo(userInfo.getUserName(),userInfo.getPassword(),getName());
    }
    /**
     * @Description 授权
     * @Date 14:16 2018/5/30
     * @Param [principalCollection]
     * @return org.apache.shiro.authz.AuthorizationInfo
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {

        return null;
    }

    //重写shiro的密码验证，让shiro用我自己的验证
//    @PostConstruct
//    public void initCredentialsMatcher() {
//        setCredentialsMatcher(new CustomCredentialsMatcher());
//    }


}
