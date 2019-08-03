package com.huai.web.dao;

import com.huai.web.entity.User;

import java.util.Map;

/**
 * @Author: laiyunjing
 * @Date: 2019/7/25 0025 11:17
 * @Version 1.0
 */
public interface UserDao {
    /**
     * 根据用户名查询
     * @param
     * @return
     */
//    Map<String, Object> selectbyname(String username);

    /**
     * 注册
     * @param
     */
//     void insertData(Map<String, String> data);

    /**
     * 增加
     * @param user
     * @return
     */
    Integer insert(User user);

    /**
     *  根据用户名查询
     * @param username
     * @return
     */
    User selectByusernamey(String username);

    User selectByPrimaryKey(Integer uid);

    User queryUserName(String username);

    Integer deleteByPrimaryKey(Integer uid);



    Integer insertSelective(User user);

    Integer updateByPrimaryKeySelective(User user);

    Integer updateByPrimaryKey(User user);

}
