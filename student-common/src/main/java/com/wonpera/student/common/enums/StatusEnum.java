package com.wonpera.student.common.enums;

/**
 * Created by wangpeng on 2017/2/21.
 */
public enum StatusEnum {

    ENABLE(0,"启用"),
    DISABLED(1,"禁用"),
    ;

    private Integer code;

    private String message;

    StatusEnum(Integer code, String message) {
        this.code = code;
        this.message = message;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
