package com.huai.web.service;

import java.util.Map;

/**
 * @Author: laiyunjing
 * @Date: 2019/7/26 0026 10:50
 * @Version 1.0
 */
public interface UserService {
    /**
     * 根据用户名查询
     * @param username
     * @return
     */
    Map<String, Object> selectbyname(String username);

    /**
     * 注册
     * @param username
     * @param password
     */
    boolean insertData(String username, String password);
}
