package com.huai.web.controller;

import com.huai.web.service.ShareService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Author: laiyunjing
 * @Date: 2019/7/13 0013 10:32
 * @Version 1.0
 */
@RequestMapping("/share")
@Controller
public class ShareController {
    @Autowired
    private ShareService shareService;
    @RequestMapping("/look")
    public ModelAndView look(){
        ModelAndView mav   =   new ModelAndView();
        mav.setViewName("index");
        return mav;
    }
    @RequestMapping("/look2")
    public ModelAndView look2(){
        ModelAndView mav   =   new ModelAndView();
        mav.setViewName("index2");
        return mav;
    }

    @RequestMapping("/look3")
    public ModelAndView look3(){
        ModelAndView mav   =   new ModelAndView();
        mav.setViewName("index3");
        return mav;
    }
    @RequestMapping("/look4")
    public ModelAndView look4(){
        ModelAndView mav   =   new ModelAndView();
        mav.setViewName("index4");
        return mav;
    }

    @RequestMapping("/look5")
    public ModelAndView look5(){
        ModelAndView mav   =   new ModelAndView();
        mav.setViewName("look5");
        return mav;
    }

    @RequestMapping("/sharedown")
    @ResponseBody
    public void filelook(){

                shareService.file();


    }


}
