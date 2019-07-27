package com.huai.shiro;

import com.huai.web.service.UserService;
import org.apache.shiro.authc.*;
import org.apache.shiro.realm.AuthenticatingRealm;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Map;

/**
 * @Author: laiyunjing
 * @Date: 2019/7/26 0026 09:58
 * @Version 1.0
 */
public class ShiroRealm extends AuthenticatingRealm {

    @Autowired
    private UserService userService;

    private SimpleAuthenticationInfo info = null;

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {

        UsernamePasswordToken upToken = (UsernamePasswordToken) authenticationToken;
        // 获取用户名即可
        String username = upToken.getUsername();
        // 查询数据库，是否查询到用户名和密码的用户
        Map<String, Object> userInfo =  userService.selectbyname(username);
        if(userInfo != null) {
            // 如果查询到了，封装查询结果，返回给我们的调用
            Object principal =  userInfo.get("username");
            Object credentials = userInfo.get("password");

            // 获取盐值，即用户名
            ByteSource salt = ByteSource.Util.bytes(username);
            String realmName = this.getName();
            // 将账户名，密码，盐值，realmName实例化到SimpleAuthenticationInfo中交给Shiro来管理
            info = new SimpleAuthenticationInfo(principal, credentials, salt,realmName);
        }else {
            // 如果没有查询到，抛出一个异常
            throw new AuthenticationException();
        }
        return info;



    }
}
