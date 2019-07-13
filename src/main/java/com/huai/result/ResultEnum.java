package com.huai.result;

/**
 * @Author: LiXiang
 * @Description :
 * @Date: Created in 2018/9/9 20:21
 */
public enum ResultEnum {
    /*成功*/
    OK(0,"成功"),//这个参数不是默认成功参数，是layui列表需要的参数
    SUCCESS(200,"操作成功"),

    COMMON_NULL(101,"字符为空"),
    PARAMETER_ERROR(400, "参数错误"),
    UNSESSION_ERR(401,"登录超时"),
    UNKONW_ERR(500,"未知异常"),
    UNPOWER_ERR(507,"权限不足，访问失败"),



    /**文件已存在*/
    IS_HAVE(700, "文件已存在！"),
    /**该文件没有上传过*/
    NO_HAVE(701, "该文件没有上传过。"),
    /**该文件上传了一部分*/
    ING_HAVE(702, "该文件上传了一部分。"),
    /** 添加文件资源失败*/
    INSERT_FILE_ERROR(703,"添加文件资源失败");
    ;

    private Integer code;

    private String msg;

    ResultEnum(Integer code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
