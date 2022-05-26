package com.technology.center.model;

import java.util.List;

@lombok.Data
public class MenuListModel {


    /**
     * createDate : 2020-09-10 15:42:23
     * id : 1
     * groupKey : REGIST_LOGIN_PROTOCOL
     * name : 用户注册登录协议
     * outline : 点击同意代表你同意了用户协议和隐私协议
     * protocols : [{"createDate":"2020-09-10 15:42:23","id":1,"name":"用户协议"},{"createDate":"2020-09-10 15:42:23","id":2,"name":"隐私协议"}]
     * consent : true
     */

    private String title;
    private String icon;
    private int icon_mipmap;
    private List<MenuModel> menus;


    @lombok.Data
    public static class MenuModel {
        /**
         * createDate : 2020-09-10 15:42:23
         * id : 1
         * name : 用户协议
         */

        private String title;
        private String icon;
        private int icon_mipmap;
        private String skipType;
        private String activity;

    }
}
