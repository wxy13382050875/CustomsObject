package com.technology.center.model;


import java.io.Serializable;

@lombok.Data
public class LaunchAdModel implements Serializable {


    /**
     * id : 2
     * description : 开屏显示GIF
     * jumpType : web
     * adSpace : null
     * adCreativeForm : {"resourcesType":"gif","id":6,"pic":"http://bt-static-get.yndth.cn/PORT/other/20210513/c949d213d48142cd93d46def73658da0.png","name":"gif图片（9:16 竖版素材）","description":"gif图片（9:16 竖版素材）"}
     * wgtUrl :
     * wgtAppId : __UNI__620E6AE
     * jumpTargetPage : https://www.iviewui.com
     * resourcesUrl : http://bt-static-get.yndth.cn/PORT/other/20210519/681c31acde3545eb95133f09c9952182.gif
     * adConfig : null
     * name : 开屏-GIF
     * wgtVersion :
     */

    private int id;
    private String description;
    private String jumpType;
    private Object adSpace;
    private AdCreativeFormBean adCreativeForm;
    private String wgtUrl;
    private String wgtAppId;
    private String jumpTargetPage;
    private String resourcesUrl;
    private String resourcesName;
    private Object adConfig;
    private String name;
    private String wgtVersion;

    @lombok.Data
    public static class AdCreativeFormBean implements Serializable {
        /**
         * resourcesType : gif
         * id : 6
         * pic : http://bt-static-get.yndth.cn/PORT/other/20210513/c949d213d48142cd93d46def73658da0.png
         * name : gif图片（9:16 竖版素材）
         * description : gif图片（9:16 竖版素材）
         */

        private String resourcesType;
        private int id;
        private String pic;
        private String name;
        private String description;
    }
}
