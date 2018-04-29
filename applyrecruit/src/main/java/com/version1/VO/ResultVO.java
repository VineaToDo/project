package com.version1.VO;

import lombok.Data;

/**
 * @ClassName ResultVO
 * @Description TODO
 * @Date 2018/4/9 14:56
 * @Version 1.0
 **/
@Data
public class ResultVO<T> {

    /** 错误码. */
    private Integer code;
    /** 提示信息. */
    private String msg;
    /** 返回数据. */
    private T data;

}
