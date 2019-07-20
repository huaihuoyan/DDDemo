package com.huai.web.service.impl;

import com.huai.result.Respon;
import com.huai.result.Result;
import com.huai.result.ResultEnum;
import com.huai.web.dao.CompanyDao;
import com.huai.web.entity.Company;
import com.huai.web.service.CompanyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * @Author: laiyunjing
 * @Date: 2019/7/18 0018 09:59
 * @Version 1.0
 */
@Service
@Transactional
public class CompanyServiceImpl implements CompanyService {
    @Resource
    private CompanyDao companyDao;
    @Override
    public Respon selectAll() {
        List<Company> companies = companyDao.selectAll();
        Respon respon = new Respon();
        respon.setCode(0);
        respon.setMsg("success");
        respon.setData(companies);
        return respon;
    }

    @Override
    public Result selectA(Integer page, Integer limit) {
        Integer   before = limit * (page - 1) + 1;
        Integer   after = limit * page;
        List<Company> companies = companyDao.selectA(before,after);
        Integer count = companyDao.selectcount();
        Result result = new Result(ResultEnum.OK,companies);
        result.setCode(count);
        return result;
    }

}
