package com.huai.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Author: laiyunjing
 * @Date: 2019/7/13 0013 10:32
 * @Version 1.0
 */
@RequestMapping("/share")
@Controller
public class shareController {
    @RequestMapping("/OAlook")
    public ModelAndView lookday(){
        ModelAndView mav   =   new ModelAndView();
        mav.setViewName("index2");
        return mav;
    }

}
