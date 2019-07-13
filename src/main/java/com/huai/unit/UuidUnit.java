package com.huai.unit;

import java.util.UUID;

/**
 * @Author: laiyunjing
 * @Date: 2019/7/11 0011 16:37
 * @Version 1.0
 */
//创建唯一ID
public class UuidUnit {
    public static String getFid() {
        return UUID.randomUUID().toString().replace("-", "").toLowerCase();
    }


    public static String createID(){
        String id= UUID.randomUUID().toString().replaceAll("-", "");
        return id.length()>40?id.substring(0,39):id;
    }

}
