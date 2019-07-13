package com.huai.unit;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @Author: laiyunjing
 * @Date: 2019/7/11 0011 16:36
 * @Version 1.0
 */
public class DateUnit {
    /**
     * 当前系统时间
     * @return
     */
    public static String nowTime(){
        Date date=new Date();
        SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time=formatter.format(date);
        return time;
    }
}
