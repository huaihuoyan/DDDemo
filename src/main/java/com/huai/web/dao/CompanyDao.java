package com.huai.web.dao;

import com.huai.web.entity.Company;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author: laiyunjing
 * @Date: 2019/7/18 0018 09:33
 * @Version 1.0
 */
public interface CompanyDao {
    /**
     * 查询
     * @return
     */
    List<Company> selectAll();

    /**
     * 分页查询
     * @param before
     * @param after
     * @return
     */
    List<Company>selectA(
            @Param("before") Integer before,
            @Param("after") Integer after
    );

    Integer selectcount();
}
