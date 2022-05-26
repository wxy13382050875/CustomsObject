package com.technology.center.model;

import java.io.Serializable;

@lombok.Data
public class UmengPushModel {

    /**
     * display_type : notification
     * extra : {"type":"1001"}
     * body : {"after_open":"go_app","ticker":"武新义测试","sound":"default","title":"边互通","play_sound":"false","badge":1,"play_lights":"false","play_vibrate":"false","text":"武新义测试小红点"}
     * msg_id : ulf1rk7164983550859800
     */

    private String display_type;
    private ExtraBean extra;
    private BodyBean body;
    private String msg_id;



    @lombok.Data
    public static class ExtraBean implements Serializable {
        /**
         * type : 1001
         */

        private String type;

    }

    @lombok.Data
    public static class BodyBean implements Serializable {
        /**
         * after_open : go_app
         * ticker : 武新义测试
         * sound : default
         * title : 边互通
         * play_sound : false
         * badge : 1
         * play_lights : false
         * play_vibrate : false
         * text : 武新义测试小红点
         */

        private String after_open;
        private String ticker;
        private String sound;
        private String title;
        private String play_sound;
        private int badge;
        private String play_lights;
        private String play_vibrate;
        private String text;


    }
}
