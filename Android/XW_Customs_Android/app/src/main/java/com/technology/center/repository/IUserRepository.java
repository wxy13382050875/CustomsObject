package com.technology.center.repository;

import androidx.lifecycle.LiveData;

import com.technology.center.http.base.BaseDto;

import org.json.JSONObject;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import com.technology.center.model.AcceptStatiModel;
import com.technology.center.model.ApplyModel;
import com.technology.center.model.CanSelectOrgsModel;
import com.technology.center.model.DictAllModel;
import com.technology.center.model.CurrentUserModel;
import com.technology.center.model.EntrustInspectModel;
import com.technology.center.model.EntrustOrgModel;
import com.technology.center.model.EntrustStatiModel;
import com.technology.center.model.ExpressModel;
import com.technology.center.model.MsgModel;
import com.technology.center.model.MsgTypeModel;
import com.technology.center.model.OrgDetailModel;

import io.reactivex.Flowable;
import retrofit2.http.Body;
import retrofit2.http.GET;
import retrofit2.http.POST;
import retrofit2.http.PUT;
import retrofit2.http.Path;
import retrofit2.http.QueryMap;

public interface IUserRepository {

    /**
     * 用户登录
     *
     * @param loginVo 请求参数
     * @return 返回JSON字符串
     */
    LiveData<BaseDto<String>> login(Map<String, String> params);
    /**
     * 添加（注册）
     *
     * @param loginVo 请求参数
     * @return 返回JSON字符串
     */
    LiveData<BaseDto<CurrentUserModel>> register(Map<String, Object> params);


    /**
     * 修改密码
     *
     * @return
     */
    LiveData<BaseDto<CurrentUserModel>> updatePassword(Map<String, String> params);
    /**
     * 获取模块
     *
     * @return 返回模块列表
     */
    LiveData<BaseDto<List<DictAllModel>>> GetDictAll();

    /**
     * 当前登陆用户信息
     *
     * @return 返回模块列表
     */
    LiveData<BaseDto<CurrentUserModel>> getCurrentUserInfo();

    /**
     * 委托申请分页查询
     *
     * @return 返回模块列表
     */
    LiveData<BaseDto<EntrustInspectModel>> getEntrustInspect(Map<String, String> params);

    /**
     * 海关端（检测机构）处理
     *
     * @return 返回模块列表
     */
    LiveData<BaseDto<EntrustInspectModel.ContentBean>> postEntrustInspect(String id, String type ,Map<String, String> params);


    /**
     * 用户可选和已分配组织机构树形列表
     *
     * @return 返回模块列表
     */
    LiveData<BaseDto<List<CanSelectOrgsModel>>> getCanSelectOrgs(String id);

    /**
     * 用户可选和已分配组织机构树形列表
     *
     * @return 返回模块列表
     */
    LiveData<BaseDto<Boolean>> getVerifyExpressSn( Map<String, String> params);

    /**
     * 委托申请-详情
     */
    LiveData<BaseDto<EntrustOrgModel>> getEntrustOrg(String id);


    /**
     * 委托申请-修改
     */
    LiveData<BaseDto<EntrustOrgModel>> putEntrustOrg(String id, Map<String, String> params);

    /**
     * 委托申请-登记
     */
    LiveData<BaseDto<EntrustOrgModel>> postEntrustOrg( Map<String, String> params);

    /**
     * 委托申请
     */
    LiveData<BaseDto<ApplyModel>> postApplyEntrustInspect( Map<String, String> params);

    /**
     * 通过委托用户ID委托单位
     */
    LiveData<BaseDto<EntrustOrgModel>> getEntrustOrgByUserId( Map<String, String> params);

    /**
     * 通过委托用户ID委托单位
     */
    LiveData<BaseDto<ExpressModel>> getExpressDetail(String id);


    /**
     * 当前委托单位的暂存委托
     *
     * @return 返回token
     */
    LiveData<BaseDto<EntrustInspectModel.ContentBean>> getOneCache();

    /**
     * 委托申请-暂存
     *
     * @return 返回token
     */
    LiveData<BaseDto<EntrustInspectModel.ContentBean>> postCache(Map<String, String> params);

    /**
     * 证书查询
     *
     * @return 返回token
     */
    LiveData<BaseDto<EntrustInspectModel.ContentBean>> getCertByQrCode(Map<String, String> params);

    /**
     * 获取(生成）二维码
     *
     * @return 返回token
     */
    LiveData<BaseDto<String>> getQrCode(String id);

    /**
     * 用户未读消息分组求和
     *
     * @return 返回token
     */
    LiveData<BaseDto<List<MsgTypeModel>>> getMsgGroup(Map<String, String> params);

    /**
     * 消息分页查询
     *
     * @return 返回token
     */
    LiveData<BaseDto<MsgModel>> getMsgList(Map<String, String> params);

    /**
     * 消息分页查询
     *
     * @return 返回token
     */
    LiveData<BaseDto<MsgModel.ContentBean>> postMsgDetailClick(@Path("id") String id);

    /**
     * 通过机构ID获取附加信息
     *
     * @return 返回token
     */
    LiveData<BaseDto<OrgDetailModel>> getOrgDetailById(Map<String, String> params);

    /**
     * 委托检验统计（检验机构分组）
     *
     * @return 返回token
     */
    LiveData<BaseDto<List<AcceptStatiModel>>> getAcceptStatiByOrgId(Map<String, String> params);

    /**
     * 委托检验申请统计（按委托单位分组）
     *
     * @return 返回token
     */
    LiveData<BaseDto<List<EntrustStatiModel>>> getEntrustStatiByEntId(Map<String, String> params);
}
