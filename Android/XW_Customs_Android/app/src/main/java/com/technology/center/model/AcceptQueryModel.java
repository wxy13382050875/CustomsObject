package com.technology.center.model;

import java.util.List;

@lombok.Data
public class AcceptQueryModel {



    private String entrustOrgId;
    private String inspectOrgId;
    private String status;
    private String queryInspectStatus;
    private String sampleName;
    private String page;
    private String size;
    private String entrustOrgName;
    private String acceptUserName;
    private String inspectResult;
    private String sn;
    private String from;
    private String to;
    private String acceptTimeFrom;
    private String acceptTimeTo;
    private String samplingTimeFrom;
    private String samplingTimeTo;

}
