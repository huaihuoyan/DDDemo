package com.huai.shiro;



import org.apache.shiro.spring.LifecycleBeanPostProcessor;
import org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.springframework.aop.framework.autoproxy.DefaultAdvisorAutoProxyCreator;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * @Author: laiyunjing
 * @Date: 2019/7/24 0024 11:49
 * @Version 1.0
 **/
@Configuration
public class ShiroConfiguration {

    @Bean
    public ShiroFilterFactoryBean shirFilter(SecurityManager securityManager) {
        ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean();
        shiroFilterFactoryBean.setSecurityManager(securityManager);


        // 拦截器。匹配原则是最上面的最优先匹配
        Map<String,String> filterChainDefinitionMap = new LinkedHashMap<String,String>();
        // 配置不会被拦截的链接
        //登出
        filterChainDefinitionMap.put("/logout", "logout");
        /*静态资源*/
        filterChainDefinitionMap.put("/huai/**", "anon");

        filterChainDefinitionMap.put("/login*", "anon"); //表示可以匿名访问
        filterChainDefinitionMap.put("/loginUser", "anon");

//        filterChainDefinitionMap.put("/ddl/login", "anon");
//        filterChainDefinitionMap.put("/ddl/doRegister", "anon");
//        filterChainDefinitionMap.put("/ddl/look3", "anon");
//        filterChainDefinitionMap.put("/ddl/look4", "anon");
//
//        filterChainDefinitionMap.put("share/look2", "anon");
//        filterChainDefinitionMap.put("index2", "anon");
        // 剩余请求需要身份认证
        filterChainDefinitionMap.put("/jsp/login.jsp*","authc");
        filterChainDefinitionMap.put("/*", "authc");//表示需要认证才可以访问
        filterChainDefinitionMap.put("/**", "authc");//表示需要认证才可以访问
        filterChainDefinitionMap.put("/*.*", "authc");

        //未授权界面;
        shiroFilterFactoryBean.setUnauthorizedUrl("/403");

        // 如果不设置默认会自动寻找Web工程根目录下的"/login.jsp"页面
        //配置登录的url和登录成功的url
        shiroFilterFactoryBean.setLoginUrl("/ddl/look3");
        shiroFilterFactoryBean.setSuccessUrl("/share/look2");

        // 未授权界面;
//        shiroFilterFactoryBean.setUnauthorizedUrl("/403");
        shiroFilterFactoryBean.setFilterChainDefinitionMap(filterChainDefinitionMap);
        return shiroFilterFactoryBean;
    }
    //配置核心安全事务管理器
    @Bean(name="securityManager")
    public SecurityManager securityManager(@Qualifier("authRealm") AuthRealm authRealm) {
        System.err.println("--------------shiro已经加载----------------");
        DefaultWebSecurityManager manager=new DefaultWebSecurityManager();
        manager.setRealm(authRealm);
        return manager;
    }
    //配置自定义的权限登录器
    @Bean(name="authRealm")
    public AuthRealm authRealm(@Qualifier("credentialsMatcher") CredentialsMatcher matcher) {
        AuthRealm authRealm=new AuthRealm();
        authRealm.setCredentialsMatcher(matcher);
        return authRealm;
    }


    //配置自定义的密码比较器
    @Bean(name="credentialsMatcher")
    public CredentialsMatcher credentialsMatcher() {
        return new CredentialsMatcher();
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
