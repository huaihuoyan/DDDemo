package com.huai.result;



/**
 * @Author: LiXiang
 * @Description :
 * @Date: Created in 2018/9/9 20:10
 */
public class ResultUtil {

    /**
     * 成功
     * @Author:  LiXiang
     * @Date: Created in 2018/9/9 20:11
     * @param obj
     * @return
     */
    public static Result success(Object obj){
        return new Result(ResultEnum.SUCCESS, obj);
    }
    public static Result ok(){
        return new Result(ResultEnum.OK);
    }
    public static Result ok(Object obj){
        return new Result(ResultEnum.OK, obj);
    }
    public static Result success(){
        return new Result(ResultEnum.SUCCESS);
    }
    public static Result error(String msg){
        Result<Object> result = new Result(ResultEnum.UNKONW_ERR);
        result.setMsg(msg);
        return result;
    }

    public static Result error(ResultEnum resultEnum){
        return new Result(resultEnum);
    }

    public static Result error(ResultEnum resultEnum,String msg){

        Result<Object> result = new Result<>(resultEnum);
        result.setMsg(msg);
        return result;
    }
    public static Result error(ResultEnum resultEnum,Object obj){

        Result<Object> result = new Result<>(resultEnum);
        result.setData(obj);
        return result;
    }


}
