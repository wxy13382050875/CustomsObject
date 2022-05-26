package com.technology.center.model;

import java.io.Serializable;

import lombok.Data;

@Data
public class EntrustStatiModel implements Serializable {


    /**
     * entrustOrgId : 108
     * entrustOrgName : 委托单位1
     * apply : 5
     * back : 1
     * waitAccept : 3
     * accepted : 0
     * done : 1
     */

    private String entrustOrgId;
    private String entrustOrgName;
    private String apply;
    private String back;
    private String waitAccept;
    private String accepted;
    private String done;
}
