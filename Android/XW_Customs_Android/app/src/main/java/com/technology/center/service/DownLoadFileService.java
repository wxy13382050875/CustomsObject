package com.technology.center.service;

import com.technology.center.Constant;

import io.reactivex.rxjava3.core.Observable;
import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Header;
import retrofit2.http.Streaming;
import retrofit2.http.Url;

public interface DownLoadFileService {

    /**
     * 下载uni app wgt 资源
     *
     * @param url 下载地址
     * @return
     */
    @Streaming
    @GET
    Call<ResponseBody> downloadFileDynamicRepos(@Url String url);
    /**
     * 下载开屏视频 资源
     *
     * @param url 下载地址
     * @return
     */
    @Streaming
    @GET
    Call<ResponseBody> downloadSplashVedio(@Url String url);
    /**
     * 获取版本信息
     *
     * @return
     */
    @GET(Constant.Server.GET_APP_VERSION_URL)
    Call<ResponseBody> getVersionInfo();

    /**
     * 下载apk
     *
     * @param url 下载apk地址
     * @return
     */
    @Streaming
    @GET
    Observable<ResponseBody> downloadApk(@Header("RANGE") String start, @Url String url);
}
