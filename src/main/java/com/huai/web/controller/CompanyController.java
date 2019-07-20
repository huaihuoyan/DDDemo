package com.huai.web.controller;

import com.huai.result.Respon;
import com.huai.result.Result;
import com.huai.web.service.CompanyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Author: laiyunjing
 * @Date: 2019/7/18 0018 10:04
 * @Version 1.0
 */
@Controller
@RequestMapping("/gs")
public class CompanyController {
    @Autowired
    private CompanyService companyService;

    @RequestMapping("/look")
    public ModelAndView look5(){
        ModelAndView mav   =   new ModelAndView();
        mav.setViewName("company");
        return mav;
    }


    @RequestMapping("/companylist")
    @ResponseBody
    public Respon companylist(){
        Respon respon = companyService.selectAll();
        return respon;
    }

    @RequestMapping("/look2")
    public ModelAndView look2(){
        ModelAndView mav   =   new ModelAndView();
        mav.setViewName("company2");
        return mav;
    }


    @RequestMapping("/selectA")
    @ResponseBody
    public Result slelectA(Integer page, Integer limit){
        Result res = companyService.selectA(page,limit);
        return res;
    }
}
