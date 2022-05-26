package com.technology.center.repository.base;

import io.reactivex.Flowable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;
import com.technology.center.http.base.BaseDto;
import com.technology.center.http.base.BaseHttpSubscriber;
public class BaseRepository {
    /**
     * 请求网络
     *
     * @param <T>
     * @param
     * @param flowable
     * @return
     */
    public <T> BaseHttpSubscriber<T> request(Flowable<BaseDto<T>> flowable){
        BaseHttpSubscriber<T> baseHttpSubscriber = new BaseHttpSubscriber<>(); //RxJava Subscriber回调
        flowable.subscribeOn(Schedulers.io()) //解决背压
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(baseHttpSubscriber);

        return baseHttpSubscriber;
    }
}
