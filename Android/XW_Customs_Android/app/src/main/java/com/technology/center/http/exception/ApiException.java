package com.technology.center.http.exception;

/**
 * 异常类
 */
public class ApiException extends Exception {

    private String code;//错误码
    private String msg;//错误信息


    public ApiException(Throwable throwable, String code) {
        super(throwable);
        this.code = code;
    }

    public ApiException(String code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
