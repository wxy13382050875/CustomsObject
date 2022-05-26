package com.technology.center.service;

import com.technology.center.http.base.BaseDto;
import com.technology.center.model.AcceptStatiModel;
import com.technology.center.model.ApplyModel;
import com.technology.center.model.CanSelectOrgsModel;
import com.technology.center.model.DictAllModel;

import org.json.JSONObject;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import io.reactivex.Flowable;
import retrofit2.http.Body;
import retrofit2.http.GET;
import retrofit2.http.POST;
import retrofit2.http.PUT;
import retrofit2.http.Path;
import retrofit2.http.QueryMap;
import com.technology.center.model.DictAllModel;
import com.technology.center.model.CurrentUserModel;
import com.technology.center.model.EntrustInspectModel;
import com.technology.center.model.EntrustOrgModel;
import com.technology.center.model.EntrustStatiModel;
import com.technology.center.model.ExpressModel;
import com.technology.center.model.MsgModel;
import com.technology.center.model.MsgTypeModel;
import com.technology.center.model.OrgDetailModel;

/**
 * 用户接口
 */
public interface UserService {
    /**
     * 用户登录
     *
     * @return
     */
    @POST("/bt_cus_tc/sso/login")
    Flowable<BaseDto<String>> login(@Body Map<String, String> params);

    /**
     * 用户登录
     *
     * @return
     */
    @POST("/bt_cus_tc/sso/user/register")
    Flowable<BaseDto<CurrentUserModel>> register(@Body Map<String, Object> params);

    /**
     * 当前登陆用户信息
     *
     * @return
     */
    @GET("/bt_cus_tc/sso/user/current")
    Flowable<BaseDto<CurrentUserModel>> getCurrentUserInfo();

    /**
     * 获取全部字典数据
     */
    @GET("/bt_cus_tc/dict/all")
    Flowable<BaseDto<List<DictAllModel>>> getAllDict();

    /**
     * 委托申请分页查询
     *
     * @return
     */
    @GET("/bt_cus_tc/entrustInspect")
    Flowable<BaseDto<EntrustInspectModel>> getEntrustInspect(@QueryMap Map<String, String> params);

    /**
     * 委托申请
     *
     * @return
     */
    @POST("/bt_cus_tc/entrustInspect/submit")
    Flowable<BaseDto<ApplyModel>> postApplyEntrustInspect(@Body Map<String, String> params);


    /**
     * 海关端（检测机构）处理
     *
     * @return 返回token
     */
    @POST("/bt_cus_tc/entrustInspect/{id}/handle/{type}")
    Flowable<BaseDto<EntrustInspectModel.ContentBean>> postEntrustInspect(@Path("id") String id,@Path("type") String type , @Body Map<String, String> params);

    /**
     * 用户可选和已分配组织机构树形列表（渲染）
     *
     * @return 返回token
     */
    @GET("/bt_cus_tc/sso/user/{id}/canSelectOrgs")
    Flowable<BaseDto<List<CanSelectOrgsModel>>> getCanSelectOrgs(@Path("id") String id);

    /**
     * 用户可选和已分配组织机构树形列表（渲染）
     *
     * @return 返回token
     */
    @GET("/bt_cus_tc/entrustInspect/verifyExpressSn?")
    Flowable<BaseDto<Boolean>> getVerifyExpressSn(@QueryMap Map<String, String> params);


    /**
     * 委托申请-详情
     */
    @GET("/bt_cus_tc/entrustOrg/{id}")
    Flowable<BaseDto<EntrustOrgModel>> getEntrustOrg(@Path("id") String id);

    /**
     * 委托申请-修改
     */
    @PUT("/bt_cus_tc/entrustOrg/{id}")
    Flowable<BaseDto<EntrustOrgModel>> putEntrustOrg(@Path("id") String id,@Body Map<String, String> params);

    /**
     * 委托申请-登记
     */
    @POST("/bt_cus_tc/entrustOrg")
    Flowable<BaseDto<EntrustOrgModel>> postEntrustOrg(@Body Map<String, String> params);

    /**
     * 通过委托用户ID委托单位
     *
     * @return 返回token
     */
    @GET("/bt_cus_tc/entrustOrg/getByUserId?")
    Flowable<BaseDto<EntrustOrgModel>> getEntrustOrgByUserId(@QueryMap Map<String, String> params);

    /**
     * 查询物流信息
     *
     * @return 返回token
     */
    @GET("/bt_cus_tc/entrustInspect/{id}/express")
    Flowable<BaseDto<ExpressModel>> getExpressDetail(@Path("id") String id);


    /**
     * 当前委托单位的暂存委托
     *
     * @return 返回token
     */
    @GET("/bt_cus_tc/entrustInspect/getOneCache")
    Flowable<BaseDto<EntrustInspectModel.ContentBean>> getOneCache();

    /**
     * 委托申请-暂存
     *
     * @return 返回token
     */
    @POST("/bt_cus_tc/entrustInspect/cache")
    Flowable<BaseDto<EntrustInspectModel.ContentBean>> postCache(@Body Map<String, String> params);

    /**
     * 证书查询
     *
     * @return 返回token
     */
    @GET("/bt_cus_tc/entrustInspect/cert")
    Flowable<BaseDto<EntrustInspectModel.ContentBean>> getCertByQrCode(@QueryMap Map<String, String> params);

    /**
     * 获取(生成）二维码
     *
     * @return 返回token
     */
    @GET("/bt_cus_tc/entrustInspect/{id}/qrCode")
    Flowable<BaseDto<String>> getQrCode(@Path("id") String id);

    /**
     * 用户未读消息分组求和
     *
     * @return 返回token
     */
    @GET("/bt_cus_tc/message/statGroupByType")
    Flowable<BaseDto<List<MsgTypeModel>>> getMsgGroup(@QueryMap Map<String, String> params);

    /**
     * 消息分页查询
     *
     * @return 返回token
     */
    @GET("/bt_cus_tc/message")
    Flowable<BaseDto<MsgModel>> getMsgList(@QueryMap Map<String, String> params);

    /**
     * 消息分页查询
     *
     * @return 返回token
     */
    @POST("/bt_cus_tc/message/{id}/click")
    Flowable<BaseDto<MsgModel.ContentBean>> postMsgDetailClick(@Path("id") String id);

    /**
     * 通过机构ID获取附加信息
     *
     * @return 返回token
     */
    @GET("/bt_cus_tc/inspectOrg/getByOrgId")
    Flowable<BaseDto<OrgDetailModel>> getOrgDetailById(@QueryMap Map<String, String> params);

    /**
     * 委托检验统计（检验机构分组）
     *
     * @return 返回token
     */
    @GET("/bt_cus_tc/stat/entrustInspect/groupByInspectOrg")
    Flowable<BaseDto<List<AcceptStatiModel>>> getAcceptStatiByOrgId(@QueryMap Map<String, String> params);

    /**
     * 委托检验申请统计（按委托单位分组）
     *
     * @return 返回token
     */
    @GET("/bt_cus_tc/stat/entrustInspect/groupByEntrustOrg")
    Flowable<BaseDto<List<EntrustStatiModel>>> getEntrustStatiByEntId(@QueryMap Map<String, String> params);
}







