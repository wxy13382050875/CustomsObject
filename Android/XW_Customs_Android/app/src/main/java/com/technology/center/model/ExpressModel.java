package com.technology.center.model;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

@Data
public class ExpressModel implements Serializable {


    /**
     * status : 0
     * msg : ok
     * result : {"number":"773151036359625","type":"STO","typename":null,"logo":"https://img3.fegine.com/express/sto.jpg","courier":"","courierPhone":"","updateTime":"2022-03-12 12:51:34","citys":["信阳市","漯河市","昆明市"],"list":[{"time":"2022-03-12 12:51:34","status":"已签收，签收人凭取货码签收。","cityLoeLae":["","",""]},{"time":"2022-03-11 12:57:31","status":"快件已暂存至昆明万科城西望小区4幢1号店菜鸟驿站，如有疑问请联系17308719749","cityLoeLae":["昆明市","102.832891","24.880095"]},{"time":"2022-03-11 08:16:05","status":"【云南昆明西北新城公司】的派件员【海屯路片区】正在为您派件，如有疑问请联系派件员，联系电话【15812070549】，申通小哥每天已测体温，请放心收寄快递（95132为申通业务员外呼专属号码，可放心接听）","cityLoeLae":["昆明市","102.832891","24.880095"]},{"time":"2022-03-11 08:14:44","status":"快件已到达【云南昆明西北新城公司】扫描员是【轻机厂申通仓库002】","cityLoeLae":["昆明市","102.832891","24.880095"]},{"time":"2022-03-11 08:09:19","status":"快件已到达【云南昆明西北新城公司】扫描员是【海屯路片区】","cityLoeLae":["昆明市","102.832891","24.880095"]},{"time":"2022-03-10 17:27:54","status":"快件由【云南昆明转运中心】发往【云南昆明西北新城公司】","cityLoeLae":["昆明市","102.832891","24.880095"]},{"time":"2022-03-10 17:26:17","status":"快件已到达【云南昆明转运中心】扫描员是【省内交叉带】","cityLoeLae":["昆明市","102.832891","24.880095"]},{"time":"2022-03-09 00:16:24","status":"快件由【河南漯河转运中心】发往【云南昆明转运中心】","cityLoeLae":["漯河市","114.016539","33.581412"]},{"time":"2022-03-09 00:14:38","status":"快件已到达【河南漯河转运中心】扫描员是【刘振伟】","cityLoeLae":["漯河市","114.016539","33.581412"]},{"time":"2022-03-08 17:59:26","status":"快件由【河南潢川公司】发往【河南漯河转运中心】","cityLoeLae":["漯河市","114.016539","33.581412"]},{"time":"2022-03-08 14:45:07","status":"【河南潢川公司】的收件员【数码配件】已收件","cityLoeLae":["信阳市","114.091023","32.146983"]}],"deliverystatus":3,"issign":"1"}
     */

    private String status;
    private String msg;
    private ResultBean result;

    @Data
    public static class ResultBean implements Serializable {
        /**
         * number : 773151036359625
         * type : STO
         * typename : null
         * logo : https://img3.fegine.com/express/sto.jpg
         * courier :
         * courierPhone :
         * updateTime : 2022-03-12 12:51:34
         * citys : ["信阳市","漯河市","昆明市"]
         * list : [{"time":"2022-03-12 12:51:34","status":"已签收，签收人凭取货码签收。","cityLoeLae":["","",""]},{"time":"2022-03-11 12:57:31","status":"快件已暂存至昆明万科城西望小区4幢1号店菜鸟驿站，如有疑问请联系17308719749","cityLoeLae":["昆明市","102.832891","24.880095"]},{"time":"2022-03-11 08:16:05","status":"【云南昆明西北新城公司】的派件员【海屯路片区】正在为您派件，如有疑问请联系派件员，联系电话【15812070549】，申通小哥每天已测体温，请放心收寄快递（95132为申通业务员外呼专属号码，可放心接听）","cityLoeLae":["昆明市","102.832891","24.880095"]},{"time":"2022-03-11 08:14:44","status":"快件已到达【云南昆明西北新城公司】扫描员是【轻机厂申通仓库002】","cityLoeLae":["昆明市","102.832891","24.880095"]},{"time":"2022-03-11 08:09:19","status":"快件已到达【云南昆明西北新城公司】扫描员是【海屯路片区】","cityLoeLae":["昆明市","102.832891","24.880095"]},{"time":"2022-03-10 17:27:54","status":"快件由【云南昆明转运中心】发往【云南昆明西北新城公司】","cityLoeLae":["昆明市","102.832891","24.880095"]},{"time":"2022-03-10 17:26:17","status":"快件已到达【云南昆明转运中心】扫描员是【省内交叉带】","cityLoeLae":["昆明市","102.832891","24.880095"]},{"time":"2022-03-09 00:16:24","status":"快件由【河南漯河转运中心】发往【云南昆明转运中心】","cityLoeLae":["漯河市","114.016539","33.581412"]},{"time":"2022-03-09 00:14:38","status":"快件已到达【河南漯河转运中心】扫描员是【刘振伟】","cityLoeLae":["漯河市","114.016539","33.581412"]},{"time":"2022-03-08 17:59:26","status":"快件由【河南潢川公司】发往【河南漯河转运中心】","cityLoeLae":["漯河市","114.016539","33.581412"]},{"time":"2022-03-08 14:45:07","status":"【河南潢川公司】的收件员【数码配件】已收件","cityLoeLae":["信阳市","114.091023","32.146983"]}]
         * deliverystatus : 3
         * issign : 1
         */

        private String number;
        private String type;
        private Object typename;
        private String logo;
        private String courier;
        private String courierPhone;
        private String updateTime;
        private int deliverystatus;
        private String issign;
        private List<String> citys;
        private List<ListBean> list;

        @Data
        public static class ListBean implements Serializable {
            /**
             * time : 2022-03-12 12:51:34
             * status : 已签收，签收人凭取货码签收。
             * cityLoeLae : ["","",""]
             */

            private String time;
            private String status;
            private List<String> cityLoeLae;
        }
    }
}
