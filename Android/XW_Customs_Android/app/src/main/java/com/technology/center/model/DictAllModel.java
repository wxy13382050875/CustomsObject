package com.technology.center.model;

import java.io.Serializable;
import java.util.List;
import com.github.gzuliyujiang.wheelview.contract.TextProvider;
import lombok.Data;

@Data
public class DictAllModel implements Serializable {


    /**
     * id : 1
     * name : 委托检验操作
     * code : ENTRUST_ACTION
     * note : null
     * items : [{"id":1,"name":"委托申请","code":"APPLY","enabled":true,"note":null,"sort":1,"pic":null,"attrValue":null,"dictId":1},{"id":51,"name":"派单","code":"DISPATCH","enabled":true,"note":null,"sort":2,"pic":null,"attrValue":null,"dictId":1},{"id":52,"name":"受理","code":"ACCEPT","enabled":true,"note":null,"sort":3,"pic":null,"attrValue":null,"dictId":1},{"id":53,"name":"退回","code":"BACK","enabled":true,"note":null,"sort":4,"pic":null,"attrValue":null,"dictId":1},{"id":54,"name":"采样","code":"SAMPLING","enabled":true,"note":null,"sort":5,"pic":null,"attrValue":null,"dictId":1},{"id":55,"name":"检测结果登记","code":"REGISTER","enabled":true,"note":null,"sort":6,"pic":null,"attrValue":null,"dictId":1}]
     */

    private int id;
    private String name;
    private String code;
    private Object note;
    private List<ItemsBean> items;

    @Data
    public static class ItemsBean implements TextProvider,Serializable {
        /**
         * id : 1
         * name : 委托申请
         * code : APPLY
         * enabled : true
         * note : null
         * sort : 1
         * pic : null
         * attrValue : null
         * dictId : 1
         */

        private String id;
        private String name;
        private String code;
        private boolean enabled;
        private Object note;
        private String sort;
        private Object pic;
        private Object attrValue;
        private String dictId;
        @Override
        public String provideText() {
            return name;
        }
    }
}
