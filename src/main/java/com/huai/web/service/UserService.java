package com.huai.web.service;

import com.huai.web.entity.User;

import java.util.Map;

/**
 * @Author: laiyunjing
 * @Date: 2019/7/26 0026 10:50
 * @Version 1.0
 */
public interface UserService {

//    Map<String, Object> selectbyname(String username);


//    boolean insertData(String username, String password);

    boolean insserttt(User user);

    User selectUsername(String username);
}
