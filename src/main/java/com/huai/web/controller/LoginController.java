package com.huai.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Author: laiyunjing
 * @Date: 2019/7/23 0023 10:24
 * @Version 1.0
 */
@Controller
@RequestMapping("/dl")
public class LoginController {

    @RequestMapping("/look")
    public ModelAndView look(){
        ModelAndView mav   =   new ModelAndView();
        mav.setViewName("login");
        return mav;
    }

    @RequestMapping("/look1")
    public ModelAndView look1(){
        ModelAndView mav   =   new ModelAndView();
        mav.setViewName("logining/login");
        return mav;
    }
    @RequestMapping("/look2")
    public ModelAndView look2(){
        ModelAndView mav   =   new ModelAndView();
        mav.setViewName("logining/singup");
        return mav;
    }


    @RequestMapping("/look5")
    public ModelAndView look5(){
        ModelAndView mav   =   new ModelAndView();
        mav.setViewName("logining/singon1");
        return mav;
    }
    @RequestMapping("/look6")
    public ModelAndView look6(){
        ModelAndView mav   =   new ModelAndView();
        mav.setViewName("logining/singon2");
        return mav;
    }
    @RequestMapping("/look7")
    public ModelAndView look7(){
        ModelAndView mav   =   new ModelAndView();
        mav.setViewName("logining/login");
        return mav;
    }
    @RequestMapping("/look8")
    public ModelAndView look8(){
        ModelAndView mav   =   new ModelAndView();
        mav.setViewName("logining/singup");
        return mav;
    }
}
