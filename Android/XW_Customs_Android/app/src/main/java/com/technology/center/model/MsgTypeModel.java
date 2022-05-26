package com.technology.center.model;

import java.io.Serializable;

import lombok.Data;

@Data
public class MsgTypeModel implements Serializable {

    /**
     * noReadNum : 2
     * type : SYSTEM
     */

    private int noReadNum;
    private String type;
}
