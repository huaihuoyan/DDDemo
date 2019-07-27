package com.huai.web.service;

import com.huai.result.Respon;
import com.huai.result.Result;

/**
 * @Author: laiyunjing
 * @Date: 2019/7/18 0018 09:56
 * @Version 1.0
 */
public interface CompanyService {

    Respon selectAll();

    Result selectA(
                   Integer page,
                   Integer limit
    );

    Result selectP(int curr, int limit);

}
