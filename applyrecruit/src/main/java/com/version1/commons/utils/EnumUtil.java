package com.version1.commons.utils;

import com.version1.commons.enums.CodeEnum;

/**
 * @ClassName EnumUtil
 * @Description TODO
 * @Date 2018/4/24 19:47
 * @Version 1.0
 */
public class EnumUtil {

    public static <T extends CodeEnum> T getByCode(Integer code, Class<T> enumClass){
        for(T each:enumClass.getEnumConstants()){
            if(code.equals(each.getCode()))
                return each;
        }
        return null;
    }
}
