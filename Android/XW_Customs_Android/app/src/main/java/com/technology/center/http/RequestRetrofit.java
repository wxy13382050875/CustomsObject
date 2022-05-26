package com.technology.center.http;

import android.util.Log;

import java.util.concurrent.TimeUnit;

import com.technology.center.Constant;
import com.technology.center.http.interceptor.TokenInterceptor;
import okhttp3.OkHttpClient;
import okhttp3.logging.HttpLoggingInterceptor;
import retrofit2.Retrofit;
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory;
import retrofit2.converter.gson.GsonConverterFactory;

public class RequestRetrofit {

    private static final String TAG = "RequestRetrofit";

    /**
     * 创建okhttp相关对象
     */
    private static OkHttpClient okHttpClient;
    /**
     * 创建Retrofit相关对象
     */
    private static Retrofit retrofit;

    public static <T> T getInstance(final Class<T> service) {
        if (okHttpClient == null) {
            synchronized (RequestRetrofit.class) {
                if (okHttpClient == null) {
                    /**
                     * 创建okhttp相关对象
                     */
                    okHttpClient = new OkHttpClient.Builder()
                            .addInterceptor(new HttpLoggingInterceptor(new HttpLoggingInterceptor.Logger() {
                                @Override
                                public void log(String message) {   //访问网络请求，和服务端响应请求时。将数据拦截并输出
                                    Log.d(TAG, "log: " + message);
                                }
                            }).setLevel(HttpLoggingInterceptor.Level.BODY))     //Log等级
                            .connectTimeout(Constant.Server.TIME_OUT, TimeUnit.MINUTES)       //超时时间
                            .readTimeout(Constant.Server.TIME_OUT, TimeUnit.MINUTES)
                            .writeTimeout(Constant.Server.TIME_OUT, TimeUnit.MINUTES)
                            .addInterceptor(new TokenInterceptor())
                            //.addNetworkInterceptor(new StethoInterceptor())
                            //.addInterceptor(new AddCookiesInterceptor()) //
                            //.addInterceptor(new ReceivedCookiesInterceptor())
                            .build();
                }
            }
        }

        if (retrofit == null) {
            synchronized (RequestRetrofit.class) {
                if (retrofit == null) {
                    retrofit = new Retrofit.Builder()
                            .baseUrl(Constant.Server.PORT_BT_URL)         //BaseUrl
                            .client(okHttpClient)                       //请求的网络框架
                            .addConverterFactory(GsonConverterFactory.create())     //解析数据格式
                            .addCallAdapterFactory(RxJava2CallAdapterFactory.create()) // 使用RxJava作为回调适配器
                            .build();
                }
            }
        }
        return retrofit.create(service);
    }
}
