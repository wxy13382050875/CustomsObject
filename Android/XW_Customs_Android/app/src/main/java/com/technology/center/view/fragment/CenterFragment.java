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

        titleBar = (CommonTitleBar) view.findViewById(R.id.titlebar);//?????????

//        titleBar.getCenterTextView().setText(title);
        //????????????
        progressBar = (ProgressBar) view.findViewById(R.id.progressbar);//?????????

        webView = (WebView) view.findViewById(R.id.webview);

        webView.addJavascriptInterface(this, "android");//??????js?????? ??????html?????????????????????
        webView.setWebChromeClient(webChromeClient);
        webView.setWebViewClient(webViewClient);
        webView.setHorizontalScrollBarEnabled(false);

        WebSettings webSettings = webView.getSettings();
        webSettings.setJavaScriptEnabled(true);//????????????js

        /**
         * LOAD_CACHE_ONLY: ?????????????????????????????????????????????
         * LOAD_DEFAULT: ??????????????????cache-control????????????????????????????????????
         * LOAD_NO_CACHE: ??????????????????????????????????????????.
         * LOAD_CACHE_ELSE_NETWORK????????????????????????????????????????????????no-cache?????????????????????????????????
         */
        webSettings.setCacheMode(WebSettings.LOAD_NO_CACHE);//??????????????????????????????????????????.

        //??????????????????
        webSettings.setSupportZoom(false);
        webSettings.setBuiltInZoomControls(false);
        //?????????webview????????????
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
    //WebViewClient????????????WebView?????????????????????????????????
    private WebViewClient webViewClient = new WebViewClient() {
        @Override
        public void onPageFinished(WebView view, String url) {//??????????????????
            progressBar.setVisibility(View.GONE);
        }

        @Override
        public void onPageStarted(WebView view, String url, Bitmap favicon) {//??????????????????
//            progressBar.setVisibility(View.VISIBLE);
        }

        @Override
        public boolean shouldOverrideUrlLoading(WebView view, String url) {
            Log.i("ansen", "??????url:" + url);
            if (url.equals("http://www.google.com/")) {
//                Toast.makeText(MainActivity.this,"??????????????????google,?????????url", Toast.LENGTH_LONG).show();
                return true;//???????????????????????????
            }
            return super.shouldOverrideUrlLoading(view, url);
        }

    };

    //WebChromeClient????????????WebView??????Javascript????????????????????????????????????title??????????????????
    private WebChromeClient webChromeClient = new WebChromeClient() {
        //?????????js???alert???????????????????????????????????????dialog??????
        @Override
        public boolean onJsAlert(WebView webView, String url, String message, JsResult result) {
            AlertDialog.Builder localBuilder = new AlertDialog.Builder(webView.getContext());
            localBuilder.setMessage(message).setPositiveButton("??????", null);
            localBuilder.setCancelable(false);
            localBuilder.create().show();

            //??????:
            //????????????????????????:result.confirm()??????:
            //???????????????????????????????????????WebCore??????
            //??????????????????????????????
            result.confirm();
            return true;
        }

        //??????????????????
        @Override
        public void onReceivedTitle(WebView view, String title) {
            super.onReceivedTitle(view, title);
            Log.i("ansen", "????????????:" + title);
        }

        //??????????????????
        @Override
        public void onProgressChanged(WebView view, int newProgress) {
            progressBar.setProgress(newProgress);
        }
    };



    /**
     * JS??????android?????????
     *
     * @param str
     * @return
     */
    @JavascriptInterface //??????????????????
    public void getClient(String str) {
        Log.i("ansen", "html???????????????:" + str);
    }
    private void getData() {
        Map<String, String> params = new HashMap<>();

        params.put("orgId", "1");
//        WaitDialog.show(BranchCenterWebActivity.this, "?????????...");
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