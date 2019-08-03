package com.huai.web.controller;

import com.huai.web.entity.User;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

/**
 * @Author: laiyunjing
 * @Date: 2019/8/1 0001 10:27
 * @Version 1.0
 */
@Controller
public class Login1Controller {

    @RequestMapping("/login")
    public String login() {
        return "logining/singon";
    }

    @RequestMapping("/loginUser")
    public String loginUser(String username,String password,HttpSession session) {
        //授权认证
        UsernamePasswordToken usernamePasswordToken=new UsernamePasswordToken(username,password);
        Subject subject = SecurityUtils.getSubject();
        try {
            //完成登录
            subject.login(usernamePasswordToken);
            //获得用户对象
            User user=(User) subject.getPrincipal();
            //存入session
            session.setAttribute("user", user);
            return "index2";
        } catch(Exception e) {
            return "/logining/singon";//返回登录页面
        }

    }
    @RequestMapping("/logOut")
    public String logOut(HttpSession session) {
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
//        session.removeAttribute("user");
        return "login";
    }



}
