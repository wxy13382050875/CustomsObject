package com.technology.center.model;

import java.io.Serializable;

import lombok.Data;

@Data
public class AcceptStatiModel implements Serializable {


    /**
     * inspectOrgId : 1
     * waitAccept : 0
     * accepted : 1
     * registered : 1
     * reportTaked : 1
     */

    private String inspectOrgId;
    private String waitAccept;
    private String accepted;
    private String registered;
    private String reportTaked;
}
