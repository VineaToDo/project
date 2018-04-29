package com.version1.commons.enums;

import lombok.Getter;

@Getter
public enum EduDgreeEnum implements CodeEnum {

    MBA(0,"MBA"),
    DOCTOR(1,"博士"),
    MASTER(2,"硕士"),
    BACHELOR(3,"本科"),
    HND(4,"大专"),
    SECONDARY(5,"中专"),
    MIDDLE(6,"高中及以下"),
    OTHERS(7,"其他")
    ;

    private Integer code;
    private String message;

    EduDgreeEnum(Integer code, String message) {
        this.code = code;
        this.message = message;
    }

}
