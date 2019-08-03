package com.huai.web.entity;

import lombok.Data;

import java.util.HashSet;
import java.util.Set;

/**
 * @Author: laiyunjing
 * @Date: 2019/7/25 0025 09:28
 * @Version 1.0
 */
@Data
public class User {

    private Integer uid;

    private String username;

    private String password;

    private String createtime;

    private String updatetime;

    private Set<Role> roles = new HashSet<>();

    public User(Integer uid, String username, String password) {
        this.uid = uid;
        this.username = username;
        this.password = password;
    }

    public User() {
        super();
    }

}
