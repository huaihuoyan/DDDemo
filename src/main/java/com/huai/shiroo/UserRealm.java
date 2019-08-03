package com.huai.shiroo;

import com.huai.web.entity.User;
import com.huai.web.service.UserService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthenticatingRealm;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashSet;
import java.util.Set;

/**
 * @Author: laiyunjing
 * @Date: 2019/8/3 0003 09:10
 * @Version 1.0
 */
public class UserRealm extends AuthorizingRealm {

    @Autowired
    private UserService userService;

    /**
     * 获取身份验证信息
     * Shiro中，最终是通过 Realm 来获取应用程序中的用户、角色及权限信息的。
     *
     * @param authenticationToken 用户身份信息 token
     * @return 返回封装了用户信息的 AuthenticationInfo 实例
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        System.out.println("————身份认证方法————");
        UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;
        User user = userService.selectUsername(token.getUsername());
        String oringnPassword = new String((char[]) token.getCredentials());
        String salt = user.getUsername();
        System.out.println(token.getUsername()+"===="+oringnPassword);
        String encodedPassword = ShiroEncryption.shiroEncryption(oringnPassword,salt);
        System.out.println("密码："+encodedPassword);
        //String password = null;
        // 从数据库获取对应用户名密码的用户
        // usermapperservice.getPasswordByUsername(token.getUsername()).getPassword() --> 获取用户名对应的密码
        if (null == userService.selectUsername(token.getUsername())) {
            throw new AccountException("用户名不正确");
        } else if (!(userService.selectUsername(token.getUsername()).getPassword()).equals(encodedPassword)) {
            throw new AccountException("密码不正确");
        }else {
            //password = usermapperservice.getPasswordByUsername(token.getUsername()).getPassword();
        }
        return new SimpleAuthenticationInfo(user.getUsername(), oringnPassword, ByteSource.Util.bytes(salt) , getName());
    }

    // 用于授权
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {

        System.out.println("MyShiroRealm的doGetAuthorizationInfo授权方法执行");

        // User user=(User)
        // principals.fromRealm(this.getClass().getName()).iterator().next();//获取session中的用户
        // System.out.println("在MyShiroRealm中AuthorizationInfo（授权）方法中从session中获取的user对象:"+user);

        // 从PrincipalCollection中获得用户信息
        Object principal = principals.getPrimaryPrincipal();
        System.out.println("ShiroRealm  AuthorizationInfo:" + principal.toString());

        // 根据用户名来查询数据库赋予用户角色,权限（查数据库）
        Set<String> roles = new HashSet<>();
        Set<String> permissions = new HashSet<>();
//		2018.09.14更新
        //		给用户添加user权限 (没有进行判断、对所有的用户给user权限)
        if("user".equals(principal)){
            roles.add("user");
            permissions.add("user:query");
        }
//		当用户名为admin时 为用户添加权限admin  两个admin可以理解为连个字段
        if ("admin".equals(principal)) {
            roles.add("admin");
            permissions.add("admin:query");
        }
//		为用户添加visit游客权限，在url中没有为visit权限，所以，所有的操作都没权限
        if("visit".equals(principal)){
            roles.add("visit");
            permissions.add("visit:query");
        }
//              更新以上代码
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo(roles);
        //添加权限
        info.setStringPermissions(permissions);
        return info;
        // return null;
    }


}
