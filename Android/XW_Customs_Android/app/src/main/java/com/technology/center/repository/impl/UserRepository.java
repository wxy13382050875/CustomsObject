package com.technology.center.repository.impl;

import androidx.lifecycle.LiveData;

import org.json.JSONObject;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import com.technology.center.http.RequestRetrofit;
import com.technology.center.http.base.BaseDto;
import com.technology.center.model.AcceptStatiModel;
import com.technology.center.model.ApplyModel;
import com.technology.center.model.CanSelectOrgsModel;
import com.technology.center.model.CurrentUserModel;
import com.technology.center.model.DictAllModel;
import com.technology.center.model.EntrustInspectModel;
import com.technology.center.model.CanSelectOrgsModel;
import com.technology.center.model.EntrustStatiModel;
import com.technology.center.model.MsgModel;
import com.technology.center.model.MsgTypeModel;
import com.technology.center.model.OrgDetailModel;
import com.technology.center.repository.IUserRepository;
import com.technology.center.repository.base.BaseRepository;
import com.technology.center.service.UserService;
import com.technology.center.model.EntrustOrgModel;
import com.technology.center.model.ExpressModel;

import io.reactivex.Flowable;

public class UserRepository extends BaseRepository implements IUserRepository {
    @Override
    public LiveData<BaseDto<EntrustInspectModel>> getEntrustInspect(Map<String, String> params) {
        Flowable<BaseDto<EntrustInspectModel>> flowable = RequestRetrofit.getInstance(UserService.class).getEntrustInspect(params);

        return request(flowable).get();
    }

    @Override
    public LiveData<BaseDto<CurrentUserModel>> register(Map<String, Object> params) {
        Flowable<BaseDto<CurrentUserModel>> flowable = RequestRetrofit.getInstance(UserService.class).register(params);

        return request(flowable).get();
    }

    @Override
    public LiveData<BaseDto<List<CanSelectOrgsModel>>> getCanSelectOrgs(String id) {
        Flowable<BaseDto<List<CanSelectOrgsModel>>> flowable = RequestRetrofit.getInstance(UserService.class).getCanSelectOrgs(id);

        return request(flowable).get();
    }

    @Override
    public LiveData<BaseDto<List<DictAllModel>>> GetDictAll() {
        Flowable<BaseDto<List<DictAllModel>>> flowable = RequestRetrofit.getInstance(UserService.class).getAllDict();

        return request(flowable).get();
    }

    @Override
    public LiveData<BaseDto<EntrustInspectModel.ContentBean>> postEntrustInspect(String id, String type, Map<String, String> params) {
        Flowable<BaseDto<EntrustInspectModel.ContentBean>> flowable = RequestRetrofit.getInstance(UserService.class).postEntrustInspect(id,type,params);

        return request(flowable).get();
    }

    @Override
    public LiveData<BaseDto<EntrustOrgModel>> getEntrustOrg(String id) {
        Flowable<BaseDto<EntrustOrgModel>> flowable = RequestRetrofit.getInstance(UserService.class).getEntrustOrg(id);

        return request(flowable).get();
    }

    @Override
    public LiveData<BaseDto<EntrustOrgModel>> putEntrustOrg(String id, Map<String, String> params) {
        Flowable<BaseDto<EntrustOrgModel>> flowable = RequestRetrofit.getInstance(UserService.class).putEntrustOrg(id,params);

        return request(flowable).get();
    }

    @Override
    public LiveData<BaseDto<EntrustOrgModel>> postEntrustOrg(Map<String, String> params) {
        Flowable<BaseDto<EntrustOrgModel>> flowable = RequestRetrofit.getInstance(UserService.class).postEntrustOrg(params);

        return request(flowable).get();
    }

    @Override
    public LiveData<BaseDto<Boolean>> getVerifyExpressSn(Map<String, String> params) {
        Flowable<BaseDto<Boolean>> flowable = RequestRetrofit.getInstance(UserService.class).getVerifyExpressSn(params);

        return request(flowable).get();
    }

    @Override
    public LiveData<BaseDto<CurrentUserModel>> getCurrentUserInfo() {
        Flowable<BaseDto<CurrentUserModel>> flowable = RequestRetrofit.getInstance(UserService.class).getCurrentUserInfo();

        return request(flowable).get();
    }

    @Override
    public LiveData<BaseDto<String>> login(Map<String, String> params) {

        Flowable<BaseDto<String>> flowable = RequestRetrofit.getInstance(UserService.class).login(params);

        return request(flowable).get();
    }

    @Override
    public LiveData<BaseDto<ApplyModel>> postApplyEntrustInspect(Map<String, String> params) {
        Flowable<BaseDto<ApplyModel>> flowable = RequestRetrofit.getInstance(UserService.class).postApplyEntrustInspect(params);

        return request(flowable).get();
    }

    @Override
    public LiveData<BaseDto<EntrustOrgModel>> getEntrustOrgByUserId(Map<String, String> params) {
        Flowable<BaseDto<EntrustOrgModel>> flowable = RequestRetrofit.getInstance(UserService.class).getEntrustOrgByUserId(params);

        return request(flowable).get();
    }

    @Override
    public LiveData<BaseDto<ExpressModel>> getExpressDetail(String id) {
        Flowable<BaseDto<ExpressModel>> flowable = RequestRetrofit.getInstance(UserService.class).getExpressDetail(id);

        return request(flowable).get();
    }

    @Override
    public LiveData<BaseDto<EntrustInspectModel.ContentBean>> getOneCache() {
        Flowable<BaseDto<EntrustInspectModel.ContentBean>> flowable = RequestRetrofit.getInstance(UserService.class).getOneCache();

        return request(flowable).get();
    }

    @Override
    public LiveData<BaseDto<EntrustInspectModel.ContentBean>> postCache(Map<String, String> params) {
        Flowable<BaseDto<EntrustInspectModel.ContentBean>> flowable = RequestRetrofit.getInstance(UserService.class).postCache(params);

        return request(flowable).get();
    }

    @Override
    public LiveData<BaseDto<EntrustInspectModel.ContentBean>> getCertByQrCode(Map<String, String> params) {
        Flowable<BaseDto<EntrustInspectModel.ContentBean>> flowable = RequestRetrofit.getInstance(UserService.class).getCertByQrCode(params);

        return request(flowable).get();
    }

    @Override
    public LiveData<BaseDto<String>> getQrCode(String id) {
        Flowable<BaseDto<String>> flowable = RequestRetrofit.getInstance(UserService.class).getQrCode(id);

        return request(flowable).get();
    }

    @Override
    public LiveData<BaseDto<List<MsgTypeModel>>> getMsgGroup(Map<String, String> params) {
        Flowable<BaseDto<List<MsgTypeModel>>> flowable = RequestRetrofit.getInstance(UserService.class).getMsgGroup(params);

        return request(flowable).get();
    }

    @Override
    public LiveData<BaseDto<MsgModel>> getMsgList(Map<String, String> params) {
        Flowable<BaseDto<MsgModel>> flowable = RequestRetrofit.getInstance(UserService.class).getMsgList(params);

        return request(flowable).get();
    }

    @Override
    public LiveData<BaseDto<MsgModel.ContentBean>> postMsgDetailClick(String id) {
        Flowable<BaseDto<MsgModel.ContentBean>> flowable = RequestRetrofit.getInstance(UserService.class).postMsgDetailClick(id);

        return request(flowable).get();
    }

    @Override
    public LiveData<BaseDto<OrgDetailModel>> getOrgDetailById(Map<String, String> params) {
        Flowable<BaseDto<OrgDetailModel>> flowable = RequestRetrofit.getInstance(UserService.class).getOrgDetailById(params);

        return request(flowable).get();
    }

    @Override
    public LiveData<BaseDto<List<AcceptStatiModel>>> getAcceptStatiByOrgId(Map<String, String> params) {
        Flowable<BaseDto<List<AcceptStatiModel>>> flowable = RequestRetrofit.getInstance(UserService.class).getAcceptStatiByOrgId(params);

        return request(flowable).get();
    }

    @Override
    public LiveData<BaseDto<List<EntrustStatiModel>>> getEntrustStatiByEntId(Map<String, String> params) {
        Flowable<BaseDto<List<EntrustStatiModel>>> flowable = RequestRetrofit.getInstance(UserService.class).getEntrustStatiByEntId(params);

        return request(flowable).get();
    }
}
