package com.technology.center.model;

import java.io.Serializable;

import lombok.Data;

@Data
public class EntrustOrgModel implements Serializable {


    /**
     * id : 108
     * userId : 118
     * name : 委托单位1
     * type : COM
     * papersType : null
     * papersNo : 证件营业执照-1-update
     * address : 地址-1-update
     * contacts : 联系人-update
     * phone : 15198771233
     * fax : 传真-update
     * email : 邮箱-update
     * createTime : null
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
