package com.version1.commons.cfg;

import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

/**
 * @ClassName WebConfig
 * @Description TODO
 * @Date 2018/4/23 17:54
 * @Version 1.0
 */
@Configuration
public class WebConfig extends WebMvcConfigurerAdapter {

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/").setViewName("index");
        registry.setOrder(Ordered.HIGHEST_PRECEDENCE);
        super.addViewControllers(registry);
    }

//    @Bean
//    public FilterRegistrationBean registration(RememberAuthenticationFilter cfg) {
//        FilterRegistrationBean registration = new FilterRegistrationBean(cfg);
//        registration.setEnabled(false);
//        return registration;
//    }
}
