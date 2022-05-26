package com.technology.center.model;

import java.io.Serializable;

import lombok.Data;

@Data
public class OrgDetailModel implements Serializable {


    /**
     * id : 108
     * orgId : 1
     * name : 技术中心
     * introduce : 介绍介绍
     * inQrCode : /ercode/path
     * createTime : null
     */

    private String id;
    private String orgId;
    private String name;
    private String introduce;
    private String inQrCode;
    private Object createTime;
}
