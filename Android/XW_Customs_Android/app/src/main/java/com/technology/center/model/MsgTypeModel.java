package com.technology.center.model;

import java.io.Serializable;

import lombok.Data;

@Data
public class MsgTypeModel implements Serializable {

    /**
     * noReadNum : 2
     * type : SYSTEM
     */

    private String total;
    private String type;
    private String noRead;
    private String readed;
}
