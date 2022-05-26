package com.technology.center.utils;

import android.content.Context;

import com.google.gson.reflect.TypeToken;
import com.technology.center.model.CanSelectOrgsModel;
import com.technology.center.model.DictAllModel;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import com.technology.center.utils.GsonUtil;
import com.technology.center.utils.SpUtils;
public class MyDictUtils {

    Context mContext;
    public SpUtils spUtils;
    public List<DictAllModel> dicts = new ArrayList<>();
    public List<CanSelectOrgsModel> Orgs = new ArrayList<>();
    public MyDictUtils (Context context) {
        mContext = context;
        spUtils = new SpUtils(mContext);
        Type type = new TypeToken<ArrayList<DictAllModel>>() {
        }.getType();
        dicts = GsonUtil.fromJson(spUtils.getString("dict"),type );

        Type typeOrg = new TypeToken<ArrayList<CanSelectOrgsModel>>() {
        }.getType();

        Orgs = GsonUtil.fromJson(spUtils.getString("Orgs"),typeOrg );
    }

    /**
     * 获取字典
     */
    private List<DictAllModel> getDictList(){
        return dicts;
    }
    /**
     * 根据CODE获取字典中所选子集
     */
    public List<DictAllModel.ItemsBean> getDictItemByCode(String code){

        List<DictAllModel.ItemsBean>  currentItems = new ArrayList<>();
        for (int i = 0; i < dicts.size(); i++) {
            DictAllModel model = dicts.get(i);
            if(model.getCode().equals(code)){
                currentItems = model.getItems();
                break;
            }
        }
        return currentItems;
    }

    /**
     * 根据CODE和子CODE获取字典中所选字符串
     */
    public String getDictNameBySubCode(String code,String subCode){
        List<DictAllModel.ItemsBean>  currentItems = getDictItemByCode(code);
        String name = "";
        for (int i = 0 ;i < currentItems.size();i++ ) {
            DictAllModel.ItemsBean model = currentItems.get(i);
            if(model.getCode().equals(subCode)){
                name = model.getName();
                break;
            }
        }

        return name;
    }

    /**
     * 获取海关技术中心列表
     */
    public List<CanSelectOrgsModel> getOrgsList( ){

        return Orgs;
    }
    /**
     * 获取海关技术中心列表
     */
    public List<CanSelectOrgsModel.ChildrenBean> getOrgsSingleList() {

        List<CanSelectOrgsModel.ChildrenBean> singles = new ArrayList<>();
        for (int i = 0; i < Orgs.size(); i++) {
            CanSelectOrgsModel.ChildrenBean model = new CanSelectOrgsModel.ChildrenBean();

            CanSelectOrgsModel tmModel = Orgs.get(i);
            model.setName(tmModel.getName());
            model.setId(tmModel.getId());
            model.setCode(tmModel.getCode());

            singles.add(model);
            if (tmModel.getChildren().size() > 0) {
                for (int j = 0; j < tmModel.getChildren().size(); j++) {
                    CanSelectOrgsModel.ChildrenBean subModel = tmModel.getChildren().get(j);
                    singles.add(subModel);
                    if (subModel.getChildren().size() > 0) {
                        for (int k = 0; k < subModel.getChildren().size(); k++) {
                            CanSelectOrgsModel.ChildrenBean subSubModel = subModel.getChildren().get(k);
                            singles.add(subSubModel);
                        }
                    }
                }
            }

        }


        return singles;
    }
    public String getSingleOrgsNameById(String OrgId) {
        String orgName = "";
        List<CanSelectOrgsModel.ChildrenBean> singles = getOrgsSingleList();
        for (int i = 0; i < singles.size();i++){
            CanSelectOrgsModel.ChildrenBean subModel = singles.get(i);
            if (subModel.getId().equals(OrgId)){
                orgName = subModel.getName();
                return orgName ;
            }
        }
        return orgName ;
    }
    public String getOrgsNameById(String OrgId){


        String orgName = "";
        for (int i = 0; i < Orgs.size();i++){
            CanSelectOrgsModel model = Orgs.get(i);
            String id = model.getId();
            if(model.getId().equals(OrgId)){
                orgName = model.getName();
                break;
            } else {
                for (int j = 0; j < model.getChildren().size();j++){
                    CanSelectOrgsModel.ChildrenBean subModel = model.getChildren().get(j);
                    String subId = subModel.getId();
                    if (subModel.getId().equals(OrgId)){
                        orgName = model.getName() + "/";
                        orgName += subModel.getName();
                        return orgName ;
                    }
                }
            }
        }
        return orgName;
    }

    //    /**
//     * 获取字典列表
//     */
//    public static List<DictAllModel.ItemsBean> getDictItem(List<DictAllModel> dicts,String code){
//        List<DictAllModel.ItemsBean>  currentItems = new ArrayList<>();
//        for (int i = 0; i < dicts.size(); i++) {
//            DictAllModel model = dicts.get(i);
//            if(model.getCode().equals(code)){
//                currentItems = model.getItems();
//                break;
//            }
//        }
//        return currentItems;
//    }
//
//    public static String getNameByDictItem(List<DictAllModel> dicts,String code,String subCode){
//        List<DictAllModel.ItemsBean>  currentItems = getDictItem(dicts,code);
//        String name = "";
//        for (int i = 0 ;i < currentItems.size();i++ ) {
//            DictAllModel.ItemsBean model = currentItems.get(i);
//            if(model.getCode().equals(subCode)){
//                name = model.getName();
//                break;
//            }
//        }
//
//        return name;
//    }



}

