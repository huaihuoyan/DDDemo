package com.huai.result;


import lombok.Getter;
import lombok.Setter;

/**
 * @Author: LiXiang
 * @Description :   前端页面获取对象
 * @Date: Created in 2018/9/9 20:04
 */
@Getter
@Setter
public class Result<T> {

    /*返回码*/
    private Integer code;

    /*返回消息*/
    private String msg;

    private Integer count;


    /*具体数据*/
    private T data;

    public Result(ResultEnum resultEnum, T data) {
        this(resultEnum);
        this.data = data;
    }

    /**
     * 常规生成异常方法
     * @param resultEnum
     */
    public Result(ResultEnum resultEnum) {
        this.code = resultEnum.getCode();
        this.msg = resultEnum.getMsg();
    }

    public Result(String msg, T data) {
        this.msg = msg;
        this.data = data;
    }

    /**
     * 依据数据生成，使用此构造函数默认成功
     * @param data
     */
    public Result(T data) {
        this.data = data;
    }

    /**
     * 依据消息生成
     * @param msg
     */
    public Result(String msg) {
        this.code=ResultEnum.UNKONW_ERR.getCode();
        this.msg = msg;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }
}
