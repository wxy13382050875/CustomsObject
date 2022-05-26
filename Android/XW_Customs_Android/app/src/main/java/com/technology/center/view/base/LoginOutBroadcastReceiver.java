package com.technology.center.view.base;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

import com.technology.center.view.user.LoginActivity;

public class LoginOutBroadcastReceiver extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {

        ActivityCollector.finishAll();  // 销毁所有活动
        Intent intent1 = new Intent(context, LoginActivity.class);
        context.startActivity(intent1);
    }
}
