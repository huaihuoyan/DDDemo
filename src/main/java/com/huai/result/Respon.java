package com.huai.result;

import lombok.Data;

/**
 * @Author: laiyunjing
 * @Date: 2019/7/18 0018 09:53
 * @Version 1.0
 */
@Data
public class Respon {
    /** 状态码*/
    private int code;

    /** 信息标识*/
    private String msg;

    /** 数据*/
    private Object data;
}
