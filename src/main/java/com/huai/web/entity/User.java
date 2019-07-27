package com.huai.web.entity;

import lombok.Data;

/**
 * @Author: laiyunjing
 * @Date: 2019/7/25 0025 09:28
 * @Version 1.0
 */
@Data
public class User {

    private Integer id;

    private String username;

    private String password;

    private String createtime;

    private String updatetime;
}
