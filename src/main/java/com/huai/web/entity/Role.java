package com.huai.web.entity;

import lombok.Data;

import java.util.HashSet;
import java.util.Set;

/**
 * @Author: laiyunjing
 * @Date: 2019/7/29 0029 10:38
 * @Version 1.0
 */
@Data
public class Role {

    private Integer rid;

    private String rname;

    private Set<User> users = new HashSet<>();

    private Set<Perssion> Perssions = new HashSet<>();

    public Role(Integer rid, String rname) {
        this.rid = rid;
        this.rname = rname;
    }

    public Role() {
        super();
    }


}
