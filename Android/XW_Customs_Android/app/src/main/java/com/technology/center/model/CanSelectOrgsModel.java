package com.technology.center.model;

import com.github.gzuliyujiang.wheelview.contract.TextProvider;

import java.io.Serializable;
import java.util.List;
import java.util.Objects;

import lombok.Data;

@Data
public class CanSelectOrgsModel implements TextProvider,Serializable {

    @Override
    public String provideText() {
        return name;
    }

//    @Override
//    public boolean equals(Object o) {
//        if (this == o) {
//            return true;
//        }
//        if (o == null || getClass() != o.getClass()) {
//            return false;
//        }
//        CanSelectOrgsModel that = (CanSelectOrgsModel) o;
//        return Objects.equals(code, that.code) &&
//                Objects.equals(name, that.name);
//    }
//
//    @Override
//    public int hashCode() {
//        return Objects.hash(code, name);
//    }
    /**
     * id : 1
     * parentId : null
     * name : 昆明海关技术中心
     * code : KM_CUS_TC
     * sort : 1
     * note : null
     * checked : false
     * children : [{"id":111,"parentId":1,"name":"分支机构","code":"FZJG","sort":4,"note":null,"checked":false,"children":[]},{"id":110,"parentId":1,"name":"分中心","code":"FZX","sort":3,"note":null,"checked":true,"children":[{"id":114,"parentId":110,"name":"昆明机场中心","code":"KMJCFZX","sort":1,"note":null,"checked":false,"children":[]},{"id":115,"parentId":110,"name":"滇中分中心","code":"DZFZX","sort":1,"note":null,"checked":false,"children":[]}]},{"id":109,"parentId":1,"name":"实验室","code":"SYS","sort":2,"note":null,"checked":false,"children":[]},{"id":108,"parentId":1,"name":"行政部门","code":"XZBM","sort":1,"note":null,"checked":false,"children":[{"id":112,"parentId":108,"name":"行政部","code":"XZB","sort":1,"note":null,"checked":false,"children":[]},{"id":113,"parentId":108,"name":"人事部","code":"RSB","sort":1,"note":null,"checked":false,"children":[]}]}]
     */

    private String id;
    private String parentId;
    private String name;
    private String code;
    private int sort;
    private String note;
    private boolean checked;
    private List<ChildrenBean> children;

    @Data
    public static class ChildrenBean implements TextProvider,Serializable {
        /**
         * id : 111
         * parentId : 1
         * name : 分支机构
         * code : FZJG
         * sort : 4
         * note : null
         * checked : false
         * children : []
         */

        private String id;
        private String parentId;
        private String name;
        private String code;
        private String sort;
        private String note;
        private boolean checked;
        private List<ChildrenBean> children;
        @Override
        public String provideText() {
            return name;
        }
    }
}
