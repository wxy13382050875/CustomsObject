package com.technology.center.http.interceptor;

import com.technology.center.App;
import com.technology.center.utils.SpUtils;
import com.technology.center.utils.appConfig;

import java.io.IOException;

import okhttp3.Interceptor;
import okhttp3.Request;
import okhttp3.Response;

public class TokenInterceptor implements Interceptor {
    @Override
    public Response intercept(Chain chain) throws IOException {
        SpUtils spUtils = new SpUtils(App.getContext());
        String token  = spUtils.getString("TOKEN");
        String version =  appConfig.getVersionName(App.getContext());
        Request originalRequest = chain.request();
        originalRequest = originalRequest.newBuilder().addHeader("version", version) .addHeader("type", "Android").build();

        if (token.isEmpty()) {

            return chain.proceed(originalRequest);
        }else {
//            Request originalRequest = chain.request();

            Request updateRequest = originalRequest.newBuilder().header("Authorization", token).build();
            return chain.proceed(updateRequest);
        }
    }
}
