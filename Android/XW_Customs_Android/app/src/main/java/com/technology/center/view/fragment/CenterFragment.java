package com.technology.center.view.fragment;

import static android.app.Activity.RESULT_OK;

import android.content.Intent;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.JavascriptInterface;
import android.webkit.JsResult;
import android.webkit.WebChromeClient;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.ProgressBar;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AlertDialog;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.Observer;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.donkingliang.groupedadapter.adapter.GroupedRecyclerViewAdapter;
import com.donkingliang.groupedadapter.holder.BaseViewHolder;
import com.donkingliang.groupedadapter.layoutmanger.GroupedGridLayoutManager;
import com.kongzue.dialog.v3.WaitDialog;
import com.technology.center.Constant;
import com.technology.center.R;
import com.technology.center.adapter.AcceptAdapter;
import com.technology.center.adapter.TitleFragmentPagerAdapter;
import com.technology.center.http.base.BaseDto;
import com.technology.center.model.AcceptQueryModel;
import com.technology.center.model.EntrustInspectModel;
import com.technology.center.model.OrgDetailModel;
import com.technology.center.repository.impl.UserRepository;
import com.technology.center.utils.SpUtils;
import com.technology.center.utils.ToastUtil;
import com.technology.center.view.base.BaseToolBarFragment;
import com.technology.center.view.custom.BranchCenterWebActivity;
import com.technology.center.view.custom.DelegateAcceptDetailActivity;
import com.technology.center.view.custom.ResultsRegisterDetailActivity;
import com.technology.center.view.custom.SamplingRecordDetailActivity;
import com.umeng.analytics.MobclickAgent;
import com.wuhenzhizao.titlebar.widget.CommonTitleBar;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CenterFragment extends Fragment {

    private ProgressBar progressBar;
    private WebView webView;
    private CommonTitleBar titleBar;
    private final UserRepository userRepository = new UserRepository();
    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {

        return inflater.inflate(R.layout.fragment_center, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        titleBar = (CommonTitleBar) view.findViewById(R.id.titlebar);//进度条

//        titleBar.getCenterTextView().setText(title);
        //获得控件
        progressBar = (ProgressBar) view.findViewById(R.id.progressbar);//进度条

        webView = (WebView) view.findViewById(R.id.webview);

        webView.addJavascriptInterface(this, "android");//添加js监听 这样html就能调用客户端
        webView.setWebChromeClient(webChromeClient);
        webView.setWebViewClient(webViewClient);
        webView.setHorizontalScrollBarEnabled(false);

        WebSettings webSettings = webView.getSettings();
        webSettings.setJavaScriptEnabled(true);//允许使用js

        /**
         * LOAD_CACHE_ONLY: 不使用网络，只读取本地缓存数据
         * LOAD_DEFAULT: （默认）根据cache-control决定是否从网络上取数据。
         * LOAD_NO_CACHE: 不使用缓存，只从网络获取数据.
         * LOAD_CACHE_ELSE_NETWORK，只要本地有，无论是否过期，或者no-cache，都使用缓存中的数据。
         */
        webSettings.setCacheMode(WebSettings.LOAD_NO_CACHE);//不使用缓存，只从网络获取数据.

        //支持屏幕缩放
        webSettings.setSupportZoom(false);
        webSettings.setBuiltInZoomControls(false);
        //不显示webview缩放按钮
        webSettings.setDisplayZoomControls(false);

        getData();
    }

    @Override
    public void onHiddenChanged(boolean hidden) {
        super.onHiddenChanged(hidden);
    }



    @Override
    public void onResume() {
        super.onResume();
        MobclickAgent.onResume(getActivity());
    }

    @Override
    public void onPause() {
        super.onPause();
        MobclickAgent.onPause(getActivity());
    }
    //WebViewClient主要帮助WebView处理各种通知、请求事件
    private WebViewClient webViewClient = new WebViewClient() {
        @Override
        public void onPageFinished(WebView view, String url) {//页面加载完成
            progressBar.setVisibility(View.GONE);
        }

        @Override
        public void onPageStarted(WebView view, String url, Bitmap favicon) {//页面开始加载
//            progressBar.setVisibility(View.VISIBLE);
        }

        @Override
        public boolean shouldOverrideUrlLoading(WebView view, String url) {
            Log.i("ansen", "拦截url:" + url);
            if (url.equals("http://www.google.com/")) {
//                Toast.makeText(MainActivity.this,"国内不能访问google,拦截该url", Toast.LENGTH_LONG).show();
                return true;//表示我已经处理过了
            }
            return super.shouldOverrideUrlLoading(view, url);
        }

    };

    //WebChromeClient主要辅助WebView处理Javascript的对话框、网站图标、网站title、加载进度等
    private WebChromeClient webChromeClient = new WebChromeClient() {
        //不支持js的alert弹窗，需要自己监听然后通过dialog弹窗
        @Override
        public boolean onJsAlert(WebView webView, String url, String message, JsResult result) {
            AlertDialog.Builder localBuilder = new AlertDialog.Builder(webView.getContext());
            localBuilder.setMessage(message).setPositiveButton("确定", null);
            localBuilder.setCancelable(false);
            localBuilder.create().show();

            //注意:
            //必须要这一句代码:result.confirm()表示:
            //处理结果为确定状态同时唤醒WebCore线程
            //否则不能继续点击按钮
            result.confirm();
            return true;
        }

        //获取网页标题
        @Override
        public void onReceivedTitle(WebView view, String title) {
            super.onReceivedTitle(view, title);
            Log.i("ansen", "网页标题:" + title);
        }

        //加载进度回调
        @Override
        public void onProgressChanged(WebView view, int newProgress) {
            progressBar.setProgress(newProgress);
        }
    };



    /**
     * JS调用android的方法
     *
     * @param str
     * @return
     */
    @JavascriptInterface //仍然必不可少
    public void getClient(String str) {
        Log.i("ansen", "html调用客户端:" + str);
    }
    private void getData() {
        Map<String, String> params = new HashMap<>();

        params.put("orgId", "1");
//        WaitDialog.show(BranchCenterWebActivity.this, "请稍候...");
        userRepository.getOrgDetailById(params).observe(CenterFragment.this, new Observer<BaseDto<OrgDetailModel>>() {
            @Override
            public void onChanged(BaseDto<OrgDetailModel> orgDetailModelBaseDto) {
                if (orgDetailModelBaseDto.getCode().equals(Constant.RespCode.R200)) {
                    String html = "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><meta name=viewport content=\"width=device-width,minimum-scale=1,maximum-scale=1,user-scalable=no,initial-scale=1\"><title></title>" +
                            "<style>html,body,h1,h2,h3,h4,h5,ul{margin:0}h4 strong { text-align: left; display: inline-block; }html,body{width:100%;padding:0;margin:0}body{overflow-y:scroll}img{max-width:100%}.content{padding:0 10px;word-wrap: break-word; word-break: normal;word-break:break-all;}.content p{overflow:visible;letter-spacing:.2px;line-height:32px}</style>" +
                            "</head><body>" +
                            "<div class=content>" +
                            orgDetailModelBaseDto.getData().getIntroduce() +
                            "</div>" +
                            "</body></html>";
                    webView.loadDataWithBaseURL(null, html, "text/html", "UTF-8", null);
                } else {
                    ToastUtil.show(getContext(), orgDetailModelBaseDto.getMessage());
                }

            }
        });
    }

}