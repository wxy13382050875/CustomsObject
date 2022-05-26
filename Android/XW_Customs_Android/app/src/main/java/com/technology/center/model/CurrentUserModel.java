package com.technology.center.model;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

@Data
public class CurrentUserModel implements Serializable {


    /**
     * id : 118
     * appId : 1
     * code : 委托单位CODE-1
     * username : wtdw1
     * password : $2a$10$uFeiX/G52YGcdnquHCFlEOA/UfnmLc1NYQjTgnHQFZXVxE9ICoxYG
     * trueName : 委托单位1
     * alias : 委托单位-1
     * pic : /user2
     * phone : 15195881001
     * email : user2
     * sex : 1
     * papersType : 1
     * papersNo : 532128199211256619
     * type : MANAGE
     * enabled : true
     * createTime : null
     * updateTime : null
     * lastOptUser : null
     * orgs : []
     * roles : [{"id":125,"appId":1,"orgId":null,"name":"委托单位","code":"WTDW","type":"SYSTEM","note":"委托单位人员","enabled":true,"createTime":null,"updateTime":null,"lastOptUser":null}]
     * webPermissionTree : []
     * mobilePermissionTree : [{"id":119,"parentId":null,"name":"服务大厅","path":"/org","icon":"/icon1","sort":1,"note":"服务大厅","iosPath":null,"androidPath":null,"mobileAppId":null,"wgtUrl":null,"checked":false,"actions":[],"children":[{"id":120,"parentId":119,"name":"委托单位登记","path":"/org","icon":"/icon1","sort":1,"note":"委托单位登记","iosPath":null,"androidPath":null,"mobileAppId":null,"wgtUrl":null,"checked":false,"actions":[],"children":[]},{"id":123,"parentId":119,"name":"缴费服务","path":"/org","icon":"/icon1","sort":4,"note":"缴费服务","iosPath":null,"androidPath":null,"mobileAppId":null,"wgtUrl":null,"checked":false,"actions":[],"children":[]},{"id":124,"parentId":119,"name":"我的快递","path":"/org","icon":"/icon1","sort":4,"note":"我的快递","iosPath":null,"androidPath":null,"mobileAppId":null,"wgtUrl":null,"checked":false,"actions":[],"children":[]},{"id":125,"parentId":119,"name":"证书查询","path":"/org","icon":"/icon1","sort":6,"note":"证书查询","iosPath":null,"androidPath":null,"mobileAppId":null,"wgtUrl":null,"checked":false,"actions":[],"children":[]}]}]
     */

    private String id;
    private String appId;
    private String code;
    private String username;
    private String password;
    private String trueName;
    private String alias;
    private String pic;
    private String phone;
    private String email;
    private String sex;
    private String papersType;
    private String papersNo;
    private String type;
    private boolean enabled;
    private String createTime;
    private String updateTime;
    private String lastOptUser;
    private List<OrgsBean> orgs;
    private List<RolesBean> roles;
    private List<?> webPermissionTree;
    private List<MobilePermissionTreeBean> mobilePermissionTree;
    @Data
    public static class OrgsBean implements Serializable {
        /**
         {
         "id":1,
         "appId":1,
         "name":"昆明海关技术中心",
         "code":"JSZX",
         "sort":1,
         "note":null,
         "enabled":true,
         "parentId":null,
         "level":0,
         "type":null
         }
         */

        private String id;
        private String appId;
        private String name;
        private String code;
        private String sort;
        private String note;
        private boolean enabled;
        private String parentId;
        private String level;
        private String type;
    }
    @Data
    public static class RolesBean implements Serializable {
        /**
         * id : 125
         * appId : 1
         * orgId : null
         * name : 委托单位
         * code : WTDW
         * type : SYSTEM
         * note : 委托单位人员
         * enabled : true
         * createTime : null
         * updateTime : null
         * lastOptUser : null
         */

        private int id;
        private int appId;
        private String orgId;
        private String name;
        private String code;
        private String type;
        private String note;
        private boolean enabled;
        private String createTime;
        private String updateTime;
        private String lastOptUser;
    }

    @Data
    public static class MobilePermissionTreeBean implements Serializable {
        /**
         * id : 119
         * parentId : null
         * name : 服务大厅
         * path : /org
         * icon : /icon1
         * sort : 1
         * note : 服务大厅
         * iosPath : null
         * androidPath : null
         * mobileAppId : null
         * wgtUrl : null
         * checked : false
         * actions : []
         * children : [{"id":120,"parentId":119,"name":"委托单位登记","path":"/org","icon":"/icon1","sort":1,"note":"委托单位登记","iosPath":null,"androidPath":null,"mobileAppId":null,"wgtUrl":null,"checked":false,"actions":[],"children":[]},{"id":123,"parentId":119,"name":"缴费服务","path":"/org","icon":"/icon1","sort":4,"note":"缴费服务","iosPath":null,"androidPath":null,"mobileAppId":null,"wgtUrl":null,"checked":false,"actions":[],"children":[]},{"id":124,"parentId":119,"name":"我的快递","path":"/org","icon":"/icon1","sort":4,"note":"我的快递","iosPath":null,"androidPath":null,"mobileAppId":null,"wgtUrl":null,"checked":false,"actions":[],"children":[]},{"id":125,"parentId":119,"name":"证书查询","path":"/org","icon":"/icon1","sort":6,"note":"证书查询","iosPath":null,"androidPath":null,"mobileAppId":null,"wgtUrl":null,"checked":false,"actions":[],"children":[]}]
         */

        private int id;
        private String parentId;
        private String name;
        private String path;
        private String icon;
        private int sort;
        private String note;
        private String iosPath;
        private String androidPath;
        private String mobileAppId;
        private String wgtUrl;
        private boolean checked;
        private List<?> actions;
        private List<ChildrenBean> children;
        private int icon_mipmap;
        @Data
        public static class ChildrenBean implements Serializable {
            /**
             * id : 120
             * parentId : 119
             * name : 委托单位登记
             * path : /org
             * icon : /icon1
             * sort : 1
             * note : 委托单位登记
             * iosPath : null
             * androidPath : null
             * mobileAppId : null
             * wgtUrl : null
             * checked : false
             * actions : []
             * children : []
             */

            private int id;
            private String parentId;
            private String name;
            private String path;
            private String icon;
            private String sort;
            private String note;
            private String iosPath;
            private String androidPath;
            private String mobileAppId;
            private String wgtUrl;
            private boolean checked;
            private List<?> actions;
            private List<?> children;
            private int icon_mipmap;
        }
    }
}
