package com.technology.center.view.user;

import android.graphics.Bitmap;
import android.os.Bundle;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.webkit.JavascriptInterface;
import android.webkit.JsResult;
import android.webkit.WebChromeClient;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.ProgressBar;

import androidx.appcompat.app.AlertDialog;

import com.kongzue.dialog.v3.WaitDialog;
import com.technology.center.Constant;
import com.technology.center.view.base.BaseActionBarActivity;
import com.wuhenzhizao.titlebar.widget.CommonTitleBar;

import java.util.HashMap;
import java.util.Map;

import com.technology.center.R;

public class WebViewActivity extends BaseActionBarActivity {


    private ProgressBar progressBar;
    private WebView webView;
    private CommonTitleBar titleBar;
    private String issueId;
    private String type;
    private String url;
    @Override
    protected int getLayoutId() {
        return R.layout.activity_web_view;
    }

    @Override
    protected void onViewCreated() {


        Bundle bundle = this.getIntent().getExtras();
        //接收name值

        issueId = bundle.getString("id");
        type = bundle.getString("type");

        titleBar = (CommonTitleBar) findViewById(R.id.titlebar);//进度条

//        titleBar.getCenterTextView().setText(title);
        //获得控件
        progressBar = (ProgressBar) findViewById(R.id.progressbar);//进度条

        webView = (WebView) findViewById(R.id.webview);
//        webView.loadUrl("file:///android_asset/test.html");//加载asset文件夹下html
//        webView.loadUrl(url);//加载url

        //使用webview显示html代码
//        webView.loadDataWithBaseURL(null,"<html><head><title> 欢迎您 </title></head>" +
//                "<body><h2>使用webview显示 html代码</h2></body></html>", "text/html" , "utf-8", null);
//        webView.loadDataWithBaseURL(null, '', "text/html", "UTF-8", null);

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






        WaitDialog.show(WebViewActivity.this, "正在加载...");
        if (type.equals("protocol")){
            getProtoctlDetail();
        } else if (type.equals("onAuth")){
            getProtoctlDetailNoAuth();
        } else if (type.equals("ad")){
            url = bundle.getString("url");
            webView.loadUrl(url);
        }  else {
            getServiceDetail();
        }

    }

    @Override
    protected void initEventAndData() {

    }

    //WebViewClient主要帮助WebView处理各种通知、请求事件
    private WebViewClient webViewClient = new WebViewClient() {
        @Override
        public void onPageFinished(WebView view, String url) {//页面加载完成
            progressBar.setVisibility(View.GONE);
        }

        @Override
        public void onPageStarted(WebView view, String url, Bitmap favicon) {//页面开始加载
            progressBar.setVisibility(View.VISIBLE);
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

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        Log.i("ansen", "是否有上一个页面:" + webView.canGoBack());
        if (webView.canGoBack() && keyCode == KeyEvent.KEYCODE_BACK) {//点击返回按钮的时候判断有没有上一页
            webView.goBack(); // goBack()表示返回webView的上一页面
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }

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

    @Override
    protected void onDestroy() {
        super.onDestroy();


        //释放资源
        webView.destroy();
        webView = null;
    }

    private void getServiceDetail() {
        Map<String, String> params = new HashMap<>();

        params.put("id", issueId);
        params.put("type", type);
        WaitDialog.show(WebViewActivity.this, "请稍候...");
//        userViewModel.getArticleShow(params).observe(WebViewActivity.this, new Observer<BaseDto<WebBean.DataBean>>() {
//            @Override
//            public void onChanged(BaseDto<WebBean.DataBean> rs) {
//                WaitDialog.dismiss();
//                if (rs.getCode().equals(Constant.RespCode.R200)) {
//
//                    webBean = rs.getData();
//                    if (webBean.getType() != null && (webBean.getUrl() != null || webBean.getContent() != null)) {
//                        if (webBean.getType().equals("SKIP")) {
//                            webView.loadUrl(webBean.getUrl());//加载url
//                        } else {
//                            String html = "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><meta name=viewport content=\"width=device-width,minimum-scale=1,maximum-scale=1,user-scalable=no,initial-scale=1\"><title></title>" +
//                                    "<style>html,body,h1,h2,h3,h4,h5,ul{margin:0}h4 strong { text-align: left; display: inline-block; }html,body{width:100%;padding:0;margin:0}body{overflow-y:scroll}img{max-width:100%}.content{padding:0 10px;word-wrap: break-word; word-break: normal;word-break:break-all;}.content p{overflow:visible;letter-spacing:.2px;line-height:32px}</style>" +
//                                    "</head><body>" +
//                                    "<div class=content>" +
//                                    webBean.getContent() +
//                                    "</div>" +
//                                    "</body></html>";
//                            webView.loadDataWithBaseURL(null, html, "text/html", "UTF-8", null);
//                        }
//                    }
//                    titleBar.getCenterTextView().setText(webBean.getTitle());
//                } else {
//                    ToastUtil.show(getBaseContext(), rs.getMsg());
//
//                }
//            }
//        });
    }
    private void getProtoctlDetail() {
        Map<String, String> params = new HashMap<>();

        params.put("id", issueId);
        WaitDialog.show(WebViewActivity.this, "请稍候...");
//        userViewModel.getProtocolDetail(params).observe(WebViewActivity.this, new Observer<BaseDto<ProtocolDetailBean>>() {
//            @Override
//            public void onChanged(BaseDto<ProtocolDetailBean> protocolDetailBeanBaseDto) {
//                WaitDialog.dismiss();
//                if (protocolDetailBeanBaseDto.getCode().equals(Constant.RespCode.R200)) {
//
//                    String html = "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><meta name=viewport content=\"width=device-width,minimum-scale=1,maximum-scale=1,user-scalable=no,initial-scale=1\"><title></title>" +
//                            "<style>html,body,h1,h2,h3,h4,h5,ul{margin:0}h4 strong { text-align: left; display: inline-block; }html,body{width:100%;padding:0;margin:0}body{overflow-y:scroll}img{max-width:100%}.content{padding:0 10px;word-wrap: break-word; word-break: normal;word-break:break-all;}.content p{overflow:visible;letter-spacing:.2px;line-height:32px}</style>" +
//                            "</head><body>" +
//                            "<div class=content>" +
//                            protocolDetailBeanBaseDto.getData().getContents() +
//                            "</div>" +
//                            "</body></html>";
//                    webView.loadDataWithBaseURL(null, html, "text/html", "UTF-8", null);
//                    titleBar.getCenterTextView().setText(protocolDetailBeanBaseDto.getData().getName());
//                } else {
//                    ToastUtil.show(getBaseContext(), protocolDetailBeanBaseDto.getMsg());
//
//                }
//            }
//        } );

    }
    private void getProtoctlDetailNoAuth() {
//        Map<String, String> params = new HashMap<>();
//
//        params.put("id", issueId);
//        dialog.show();
//        userViewModel.getProtoctlDetailNoAuth(params).observe(WebViewActivity.this, new Observer<BaseDto<ProtocolDetailBean>>() {
//            @Override
//            public void onChanged(BaseDto<ProtocolDetailBean> protocolDetailBeanBaseDto) {
//                dialog.hide();
//                if (protocolDetailBeanBaseDto.getCode().equals(Constant.RespCode.R200)) {
//
//                    String html = "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><meta name=viewport content=\"width=device-width,minimum-scale=1,maximum-scale=1,user-scalable=no,initial-scale=1\"><title></title>" +
//                            "<style>html,body,h1,h2,h3,h4,h5,ul{margin:0}h4 strong { text-align: left; display: inline-block; }html,body{width:100%;padding:0;margin:0}body{overflow-y:scroll}img{max-width:100%}.content{padding:0 10px;word-wrap: break-word; word-break: normal;word-break:break-all;}.content p{overflow:visible;letter-spacing:.2px;line-height:32px}</style>" +
//                            "</head><body>" +
//                            "<div class=content>" +
//                            protocolDetailBeanBaseDto.getData().getContents() +
//                            "</div>" +
//                            "</body></html>";
//                    webView.loadDataWithBaseURL(null, html, "text/html", "UTF-8", null);
//                    titleBar.getCenterTextView().setText(protocolDetailBeanBaseDto.getData().getName());
//                } else {
//                    ToastUtil.show(getBaseContext(), protocolDetailBeanBaseDto.getMsg());
//
//                }
//            }
//        } );

    }

}
