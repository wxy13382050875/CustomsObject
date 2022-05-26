package com.technology.center.view.base;

import android.content.IntentFilter;
import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;

import com.technology.center.utils.SpUtils;
import com.umeng.analytics.MobclickAgent;
import com.umeng.message.PushAgent;


public class BaseCompatActivity extends AppCompatActivity {
    protected LoginOutBroadcastReceiver locallReceiver;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // 创建活动时，将其加入管理器中
        ActivityCollector.addActivity(this);
        PushAgent.getInstance(this).onAppStart();
    }

    @Override
    protected void onResume() {
        super.onResume();

        // 注册广播接收器
        IntentFilter intentFilter = new IntentFilter();
        intentFilter.addAction("com.technology.center.loginout");
        locallReceiver = new LoginOutBroadcastReceiver();
        registerReceiver(locallReceiver, intentFilter);
        MobclickAgent.onResume(this);
    }

    @Override
    protected void onPause() {
        super.onPause();

        // 取消注册广播接收器
        unregisterReceiver(locallReceiver);
        MobclickAgent.onPause(this);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();

        // 销毁活动时，将其从管理器中移除
        ActivityCollector.removeActivity(this);
    }

}
