package com.huai.web.dao;

import com.huai.web.entity.Perssion;

/**
 * @Author: laiyunjing
 * @Date: 2019/8/1 0001 10:03
 * @Version 1.0
 */
public interface PerssionDao {

    Perssion selectByPrimaryKey(Integer pid);

    Integer deleteByPrimaryKey(Integer pid);

    Integer insert(Perssion perssion);

    Integer insertSelective(Perssion perssion);

    Integer updateByPrimaryKeySelective(Perssion perssion);

    Integer updateByPrimaryKey(Perssion perssion);
}
