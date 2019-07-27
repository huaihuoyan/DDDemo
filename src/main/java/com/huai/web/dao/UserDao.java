package com.huai.web.dao;

import java.util.Map;

/**
 * @Author: laiyunjing
 * @Date: 2019/7/25 0025 11:17
 * @Version 1.0
 */
public interface UserDao {
    /**
     * 根据用户名查询
     * @param username
     * @return
     */
    Map<String, Object> selectbyname(String username);

    /**
     * 注册
     * @param data
     */
     void insertData(Map<String, String> data);


}
