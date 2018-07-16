package com.version1.shiro.config;

import com.version1.service.UserService;
import com.version1.shiro.custom.CustomCredentialsMatcher;
import com.version1.shiro.custom.CustomRealm;
import com.version1.shiro.custom.RememberAuthenticationFilter;
import org.apache.shiro.codec.Base64;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.spring.LifecycleBeanPostProcessor;
import org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.CookieRememberMeManager;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.apache.shiro.web.servlet.SimpleCookie;
import org.springframework.aop.framework.autoproxy.DefaultAdvisorAutoProxyCreator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.servlet.Filter;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * @ClassName ShiroConfiguration
 * @Description TODO
 * @Date 2018/5/30 14:03
 * @Version 1.0
 */
@Configuration
public class ShiroConfiguration {

    @Bean(name="shiroFilter")
    public ShiroFilterFactoryBean shiroFilter(@Qualifier("securityManager") SecurityManager manager) {
        ShiroFilterFactoryBean bean=new ShiroFilterFactoryBean();
        bean.setSecurityManager(manager);

        // 自定义过滤器
        Map<String, Filter> filterMap = bean.getFilters();
        filterMap.put("rememberMe", new RememberAuthenticationFilter());
        bean.setFilters(filterMap);

        //配置登录的url和登录成功的url
        bean.setLoginUrl("/user/getLogin");
        bean.setUnauthorizedUrl("/user/error");
        bean.setSuccessUrl("/index/");
        //配置访问权限
        LinkedHashMap<String, String> filterChainDefinitionMap=new LinkedHashMap<>();
        filterChainDefinitionMap.put("/index/","anon");
        filterChainDefinitionMap.put("/bootstrap/*","anon");
        filterChainDefinitionMap.put("/css/*","anon");
        filterChainDefinitionMap.put("/fonts/*","anon");
        filterChainDefinitionMap.put("/images/*","anon");
        filterChainDefinitionMap.put("/img/*","anon");
        filterChainDefinitionMap.put("/insdep/*","anon");
        filterChainDefinitionMap.put("/js/*","anon");
        filterChainDefinitionMap.put("/json/*","anon");
        filterChainDefinitionMap.put("/**/*.jpg","anon");
        filterChainDefinitionMap.put("/**/*.png","anon");
        filterChainDefinitionMap.put("/**/*.jpeg","anon");
        filterChainDefinitionMap.put("/user/login","anon");
        filterChainDefinitionMap.put("/user/register","anon");
        filterChainDefinitionMap.put("/user/getRegister","anon");
        filterChainDefinitionMap.put("/user/checkUsername","anon");
        filterChainDefinitionMap.put("/user/uploadImage","anon");
        filterChainDefinitionMap.put("/user/getGifCode","anon");
        filterChainDefinitionMap.put("/resume/jsonInfo","anon");
        filterChainDefinitionMap.put("/position/position*","anon");
        filterChainDefinitionMap.put("/index/getPositionsByType","anon");
        filterChainDefinitionMap.put("/index/searchPosition","anon");
        // 配置退出过滤器,其中的具体的退出代码Shiro已经实现了
        filterChainDefinitionMap.put("/user/logout", "logout");
        filterChainDefinitionMap.put("/*", "rememberMe");//表示需要认证才可以访问
        filterChainDefinitionMap.put("/**", "rememberMe");//表示需要认证才可以访问
        bean.setFilterChainDefinitionMap(filterChainDefinitionMap);
        return bean;
    }

    //配置核心安全事务管理器
    @Bean(name="securityManager")
    public SecurityManager securityManager(@Qualifier("customRealm") CustomRealm customRealm,@Qualifier("cookieRememberMeManager") CookieRememberMeManager cookieRememberMeManager) {
        System.err.println("--------------shiro已经加载----------------");
        DefaultWebSecurityManager manager = new DefaultWebSecurityManager();
        manager.setRealm(customRealm);
        manager.setRememberMeManager(cookieRememberMeManager);
        return manager;
    }
    @Bean(name = "simpleCookie")
    public SimpleCookie rememberMeCookie(){
        //这个参数是cookie的名称，对应前端的checkbox的name = rememberMe
        SimpleCookie simpleCookie = new SimpleCookie("rememberMe");
        //<!-- 记住我cookie有效时间 ,单位秒;-->
        simpleCookie.setMaxAge(60);
        return simpleCookie;
    }
    /**
     * cookie管理对象;记住我功能
     * @return
     */
    @Bean(name = "cookieRememberMeManager")
    public CookieRememberMeManager rememberMeManager(@Qualifier("simpleCookie") SimpleCookie simpleCookie){
        CookieRememberMeManager cookieRememberMeManager = new CookieRememberMeManager();
        cookieRememberMeManager.setCookie(simpleCookie);
        //rememberMe cookie加密的密钥 建议每个项目都不一样 默认AES算法 密钥长度(128 256 512 位)
        cookieRememberMeManager.setCipherKey(Base64.decode("3AvVhmFLUs0KTA3Kprsdag=="));
        return cookieRememberMeManager;
    }
    //配置自定义的权限登录器
    @Bean(name="customRealm")
    public CustomRealm authRealm(@Qualifier("customMatcher") CustomCredentialsMatcher matcher) {
        CustomRealm customRealm = new CustomRealm();
        customRealm.setCredentialsMatcher(matcher);
        return customRealm;
    }
    //配置自定义的密码比较器
    @Bean(name="customMatcher")
    public CustomCredentialsMatcher credentialsMatcher() {
        return new CustomCredentialsMatcher();
    }
    @Bean
    public LifecycleBeanPostProcessor lifecycleBeanPostProcessor(){
        return new LifecycleBeanPostProcessor();
    }
    @Bean
    public DefaultAdvisorAutoProxyCreator defaultAdvisorAutoProxyCreator(){
        DefaultAdvisorAutoProxyCreator creator=new DefaultAdvisorAutoProxyCreator();
        creator.setProxyTargetClass(true);
        return creator;
    }
    @Bean
    public AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor(@Qualifier("securityManager") SecurityManager manager) {
        AuthorizationAttributeSourceAdvisor advisor=new AuthorizationAttributeSourceAdvisor();
        advisor.setSecurityManager(manager);
        return advisor;
    }

}
