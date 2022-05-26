package com.technology.center.model;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

@Data
public class EntrustInspectModel implements Serializable {


    /**
     * content : [{"id":108,"entrustOrgId":108,"sampleName":"样品名称-1","sampleNum":2,"sampleQuantity":11.2,"sampleWeight":11,"sampleMark":"样品标记-1","spec":null,"productionDate":"2022-01-01","excStandard":"执行标准-受理","project":"检测项目-受理","projectBasis":"检测项目依据-受理","producer":"生产商","producerAddress":"生产商地址","takeWay":"MAIL","sn":"223","inspectOrgId":1,"source":null,"busCategory":"业务类别-受理","status":"DONE","inspectStatus":"REGISTERED","inspectResult":"DONE","createTime":"2022-05-11 16:26:03","acceptUserId":119,"acceptUserName":"技术中心受理人员1","acceptUserPhone":"15195881002","acceptTime":"2022-05-11 17:31:55","sampleWay":null,"samplingUserId":119,"samplingUserName":"技术中心受理人员1","samplingUserPhone":"15195881002","samplingNote":null,"samplingTime":"2022-05-11 17:34:45","expressNo":"773151036359625","registerUserId":119,"registerUserName":"技术中心受理人员1","registerUserPhone":"15195881002","registerTime":"2022-05-11 17:35:42","entrustOrg":{"id":108,"userId":118,"name":"委托单位1","type":"COM","papersType":null,"papersNo":"证件营业执照-1-update","address":"地址-1-update","contacts":"联系人-update","phone":"15195881125","fax":"传真-update","email":"邮箱-update","createTime":"2022-05-13 16:58:35"}}]
     * pageNum : 1
     * pageSize : 10
     * count : 1
     */

    private int pageNum;
    private int pageSize;
    private int count;
    private List<ContentBean> content;

    @Data
    public static class ContentBean implements Serializable {
        /**
         * id : 108
         * entrustOrgId : 108
         * sampleName : 样品名称-1
         * sampleNum : 2
         * sampleQuantity : 11.2
         * sampleWeight : 11.0
         * sampleMark : 样品标记-1
         * spec : null
         * productionDate : 2022-01-01
         * excStandard : 执行标准-受理
         * project : 检测项目-受理
         * projectBasis : 检测项目依据-受理
         * producer : 生产商
         * producerAddress : 生产商地址
         * takeWay : MAIL
         * sn : 223
         * inspectOrgId : 1
         * source : null
         * busCategory : 业务类别-受理
         * status : DONE
         * inspectStatus : REGISTERED
         * inspectResult : DONE
         * createTime : 2022-05-11 16:26:03
         * acceptUserId : 119
         * acceptUserName : 技术中心受理人员1
         * acceptUserPhone : 15195881002
         * acceptTime : 2022-05-11 17:31:55
         * sampleWay : null
         * samplingUserId : 119
         * samplingUserName : 技术中心受理人员1
         * samplingUserPhone : 15195881002
         * samplingNote : null
         * samplingTime : 2022-05-11 17:34:45
         * expressNo : 773151036359625
         * registerUserId : 119
         * registerUserName : 技术中心受理人员1
         * registerUserPhone : 15195881002
         * registerTime : 2022-05-11 17:35:42
         * entrustOrg : {"id":108,"userId":118,"name":"委托单位1","type":"COM","papersType":null,"papersNo":"证件营业执照-1-update","address":"地址-1-update","contacts":"联系人-update","phone":"15195881125","fax":"传真-update","email":"邮箱-update","createTime":"2022-05-13 16:58:35"}
         */

        private String id;
        private String entrustOrgId;
        private String entrustOrgName;
        private String sampleName;
        private String sampleNum;
        private String sampleQuantity;
        private String sampleWeight;
        private String sampleMark;
        private String spec;
        private String productionDate;
        private String excStandard;
        private String project;
        private String projectBasis;
        private String producer;
        private String producerAddress;
        private String takeWay;
        private String sn;
        private String inspectOrgId;
        private String source;
        private String busCategory;
        private String status;
        private String inspectStatus;
        private String inspectResult;
        private String createTime;
        private String acceptUserId;
        private String acceptUserName;
        private String acceptUserPhone;
        private String acceptTime;
        private String sampleWay;
        private String samplingUserId;
        private String samplingUserName;
        private String samplingUserPhone;
        private String samplingNote;
        private String samplingTime;
        private String expressNo;
        private String registerUserId;
        private String registerUserName;
        private String registerUserPhone;
        private String registerTime;
        private EntrustOrgBean entrustOrg;

        @Data
        public static class EntrustOrgBean implements Serializable {
            /**
             * id : 108
             * userId : 118
             * name : 委托单位1
             * type : COM
             * papersType : null
             * papersNo : 证件营业执照-1-update
             * address : 地址-1-update
             * contacts : 联系人-update
             * phone : 15195881125
             * fax : 传真-update
             * email : 邮箱-update
             * createTime : 2022-05-13 16:58:35
             */

            private String id;
            private String userId;
            private String name;
            private String type;
            private String papersType;
            private String papersNo;
            private String address;
            private String contacts;
            private String phone;
            private String fax;
            private String email;
            private String createTime;
        }
    }
}
