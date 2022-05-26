package com.technology.center.model;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

@Data
public class MsgModel implements Serializable {


    /**
     * content : [{"id":290,"entrustId":119,"type":"SYSTEM","targetUserId":118,"title":"委托检验申请","content":"委托检验申请成功，请耐心等待技术中心|xx分中心受理","readFlag":false,"createTime":"2022-05-20 12:06:17"},{"id":301,"entrustId":119,"type":"SYSTEM","targetUserId":118,"title":"委托检验申请","content":"收到一条新的委托检验申请，点击查看详情","readFlag":false,"createTime":"2022-05-20 12:06:17"},{"id":266,"entrustId":118,"type":"SYSTEM","targetUserId":118,"title":"委托检验申请","content":"委托检验申请成功，请耐心等待技术中心|xx分中心受理","readFlag":false,"createTime":"2022-05-20 11:37:07"},{"id":277,"entrustId":118,"type":"SYSTEM","targetUserId":118,"title":"委托检验申请","content":"收到一条新的委托检验申请，点击查看详情","readFlag":false,"createTime":"2022-05-20 11:37:07"},{"id":242,"entrustId":117,"type":"SYSTEM","targetUserId":118,"title":"委托检验申请","content":"委托检验申请成功，请耐心等待技术中心|xx分中心受理","readFlag":false,"createTime":"2022-05-19 18:25:56"},{"id":253,"entrustId":117,"type":"SYSTEM","targetUserId":118,"title":"委托检验申请","content":"收到一条新的委托检验申请，点击查看详情","readFlag":false,"createTime":"2022-05-19 18:25:56"},{"id":218,"entrustId":116,"type":"SYSTEM","targetUserId":118,"title":"委托检验申请","content":"委托检验申请成功，请耐心等待技术中心|xx分中心受理","readFlag":false,"createTime":"2022-05-19 18:18:52"},{"id":229,"entrustId":116,"type":"SYSTEM","targetUserId":118,"title":"委托检验申请","content":"收到一条新的委托检验申请，点击查看详情","readFlag":false,"createTime":"2022-05-19 18:18:52"},{"id":194,"entrustId":115,"type":"SYSTEM","targetUserId":118,"title":"委托检验申请","content":"委托检验申请成功，请耐心等待技术中心|xx分中心受理","readFlag":false,"createTime":"2022-05-19 18:18:00"},{"id":205,"entrustId":115,"type":"SYSTEM","targetUserId":118,"title":"委托检验申请","content":"收到一条新的委托检验申请，点击查看详情","readFlag":false,"createTime":"2022-05-19 18:18:00"}]
     * pageNum : 1
     * pageSize : 10
     * count : 22
     */

    private int pageNum;
    private int pageSize;
    private int count;
    private List<ContentBean> content;

    @Data
    public static class ContentBean implements Serializable {
        /**
         * id : 290
         * entrustId : 119
         * type : SYSTEM
         * targetUserId : 118
         * title : 委托检验申请
         * content : 委托检验申请成功，请耐心等待技术中心|xx分中心受理
         * readFlag : false
         * createTime : 2022-05-20 12:06:17
         */

        private String id;
        private String entrustId;
        private String type;
        private String targetUserId;
        private String title;
        private String content;
        private boolean readFlag;
        private String createTime;
    }
}
