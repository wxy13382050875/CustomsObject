package com.technology.center.view.push;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import com.umeng.message.UmengNotifyClickActivity;

import org.android.agoo.common.AgooConstants;

import com.technology.center.R;
import com.technology.center.view.welcome.SplashActivity;

public class MfrMessageActivity extends UmengNotifyClickActivity {

    private static final String TAG = "MfrMessageActivity";

    @Override
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.activity_mfr_message);
    }

    @Override
    public void onMessage(Intent intent) {
        super.onMessage(intent);
        Bundle bundle = intent.getExtras();
        if (bundle != null) {
            Log.d(TAG, "bundle: " + bundle);
        }
        String body = intent.getStringExtra(AgooConstants.MESSAGE_BODY);
        Log.d(TAG, "body: " + body);
//        if (!TextUtils.isEmpty(body)) {
//            runOnUiThread(() -> ((TextView) findViewById(R.id.tv)).setText(body));
//        }
        Intent intent1 = new Intent(MfrMessageActivity.this, SplashActivity.class);
        startActivity(intent1);
        finish();
    }
}