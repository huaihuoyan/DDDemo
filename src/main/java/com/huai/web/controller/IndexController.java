package com.huai.web.controller;

import com.huai.web.entity.User;
import com.huai.web.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

/**
 * @Author: laiyunjing
 * @Date: 2019/7/26 0026 11:09
 * @Version 1.0
 */
@Controller
@RequestMapping("/ddl")
public class IndexController {
    @Autowired
    private UserService userService;


    @RequestMapping("/look3")
    public ModelAndView look3(){
        ModelAndView mav   =   new ModelAndView();
        mav.setViewName("logining/singon");
        return mav;
    }
    @RequestMapping("/look4")
    public ModelAndView look4(){
        ModelAndView mav   =   new ModelAndView();
        mav.setViewName("logining/singup2");
        return mav;
    }

    private final Logger logger = LoggerFactory.getLogger(IndexController.class);

    @RequestMapping("/login")
    public String doLogin(String username,
                          String password, HttpSession session) {

        // 创建Subject实例
        Subject currentUser = SecurityUtils.getSubject();

        // 将用户名及密码封装到UsernamePasswordToken
        UsernamePasswordToken token = new UsernamePasswordToken(username, password);
        try {
            currentUser.login(token);
            User user = (User) currentUser.getPrincipal();
            session.setAttribute("user", user);

            // 判断当前用户是否登录

                return "index2";

        } catch (AuthenticationException e) {
            e.printStackTrace();
            System.out.println("登录失败");
        }
        return "logining/singon";
    }

//    @RequestMapping("/doRegister")
//    public String doRegister( String username,
//                            String password) {
//        boolean result = userService.insertData(username, password);
//        if (result) {
//            return "redirect: /logining/singon";
//        }
//        return "redirect: /logining/singon";
//
//    }
}
