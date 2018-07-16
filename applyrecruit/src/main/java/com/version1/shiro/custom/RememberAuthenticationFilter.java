package com.version1.shiro.custom;

import com.version1.commons.utils.FilterUtil;
import com.version1.entity.UserInfo;
import com.version1.service.UserService;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/**
 * @ClassName RememberAuthenticationFilter
 * @Description TODO
 * @Date 2018/5/31 22:36
 * @Version 1.0
 */
public class RememberAuthenticationFilter extends FormAuthenticationFilter {

    @Override
    protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) {
        Subject subject = getSubject(request, response);
        //如果 isAuthenticated 为 false 证明不是登录过的，同时 isRememberd 为true 证明是没登陆直接通过记住我功能进来的
        if(!subject.isAuthenticated() && subject.isRemembered()){
            //获取session看看是不是空的
            Session session = subject.getSession(true);
            //随便拿session的一个属性来看session当前是否是空的，我用userId，你们的项目可以自行发挥
            if(session.getAttribute("user") == null){
                //如果是空的才初始化，否则每次都要初始化
                //这边根据前面的前提假设，拿到的是username
                String username = subject.getPrincipal().toString();
                System.out.println(username);
                //在这个方法里面做初始化用户上下文的事情，比如通过查询数据库来设置session值
                FilterUtil.initUserContext(username,subject);

            }
        }
        //这个方法本来只返回 subject.isAuthenticated() 加上 subject.isRemembered() 让它同时也兼容remember这种情况
        return subject.isAuthenticated() || subject.isRemembered();
    }
}
