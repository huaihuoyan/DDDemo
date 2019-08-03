package com.huai.web.entity;

import lombok.Data;


import java.util.Set;

/**
 * @Author: laiyunjing
 * @Date: 2019/7/31 0031 11:43
 * @Version 1.0
 */
@Data
public class Perssion {

    private Integer pid;

    private String pname;

    private Set<Role> roles ;

    public Perssion(Integer pid, String pname) {
        this.pid = pid;
        this.pname = pname;
    }

    public Perssion() {
        super();
    }

}
