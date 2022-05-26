package com.technology.center.model;

import java.util.List;
@lombok.Data
public class ProtocolModel {


    /**
     * createDate : 2020-09-10 15:42:23
     * id : 1
     * groupKey : REGIST_LOGIN_PROTOCOL
     * name : 用户注册登录协议
     * outline : 点击同意代表你同意了用户协议和隐私协议
     * protocols : [{"createDate":"2020-09-10 15:42:23","id":1,"name":"用户协议"},{"createDate":"2020-09-10 15:42:23","id":2,"name":"隐私协议"}]
     * consent : true
     */

    private String createDate;
    private String id;
    private String groupKey;
    private String name;
    private String outline;
    private boolean consent;
    private List<Protocols> protocols;


    @lombok.Data
    public static class Protocols {
        /**
         * createDate : 2020-09-10 15:42:23
         * id : 1
         * name : 用户协议
         */

        private String createDate;
        private String id;
        private String name;


    }
}
