package com.technology.center.http.base;

import android.content.Intent;

import androidx.lifecycle.MutableLiveData;

import com.technology.center.App;
import com.technology.center.Constant;
import com.technology.center.http.exception.ApiException;
import com.technology.center.http.exception.ExceptionEngine;
import com.technology.center.http.exception.ServerException;
import com.technology.center.utils.ToastUtil;

import org.reactivestreams.Subscriber;
import org.reactivestreams.Subscription;

/**
 * 自定义请服务器被观察者
 *
 * @author twilight
 * @Time 2019-07-21
 */
public class BaseHttpSubscriber<T> implements Subscriber<BaseDto<T>> {

    //异常类
    private ApiException ex;

    public BaseHttpSubscriber() {
        data = new MutableLiveData();
    }

    private MutableLiveData<BaseDto<T>> data;

    public MutableLiveData<BaseDto<T>> get() {
        return data;
    }

    public void set(BaseDto<T> t) {
        this.data.setValue(t);
    }

    public void onFinish(BaseDto<T> t) {
        set(t);
    }

    @Override
    public void onSubscribe(Subscription s) {
        // 观察者接收事件 = 1个
        s.request(1);
    }

    @Override
    public void onNext(BaseDto<T> t) {
        if (t.getCode().equals(Constant.RespCode.R200)) {
            onFinish(t);
        } else{
            if(t.getCode().equals(Constant.RespCode.R403)){

                Intent intent = new Intent("com.technology.center.loginout");
                ToastUtil.show(App.getContext(),"登录失效");
                App.getContext().sendBroadcast(intent);
            }else{
                ex = ExceptionEngine.handleException(new ServerException(t.getCode(), t.getMessage()));
                getErrorDto(ex);
            }

        }
    }


    @Override
    public void onError(Throwable t) {
        ex = ExceptionEngine.handleException(t);
        getErrorDto(ex);
    }

    /**
     * 初始化错误的dto
     *
     * @param ex
     */
    private void getErrorDto(ApiException ex) {
        BaseDto dto = new BaseDto();
        dto.setCode(ex.getCode());
        dto.setMessage(ex.getMsg());
        onFinish((BaseDto<T>) dto);
//        onNext((BaseDto<T>) dto);
//        ToastUtil.show(App.getContext(),ex.getMessage().toString());
    }

    @Override
    public void onComplete() {
    }

}