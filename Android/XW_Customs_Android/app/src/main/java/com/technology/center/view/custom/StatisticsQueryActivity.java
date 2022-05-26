package com.technology.center.view.custom;


import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.lifecycle.Observer;

import com.google.zxing.integration.android.IntentIntegrator;
import com.google.zxing.integration.android.IntentResult;
import com.technology.center.Constant;
import com.technology.center.R;
import com.technology.center.http.base.BaseDto;
import com.technology.center.model.EntrustInspectModel;
import com.technology.center.repository.impl.UserRepository;
import com.technology.center.utils.MyDictUtils;
import com.technology.center.utils.SpUtils;
import com.technology.center.utils.ToastUtil;
import com.technology.center.view.base.BaseActionBarActivity;
import com.technology.center.view.qr.QrCodeActivity;

import java.util.HashMap;
import java.util.Map;

import butterknife.BindView;
import butterknife.ButterKnife;
import cxy.com.validate.Validate;

public class StatisticsQueryActivity extends BaseActionBarActivity {


    private static final String TAG = "StatisticsQueryActivity";


    @Override
    protected int getLayoutId() {
        return R.layout.activity_statistice_query;
    }

    @Override
    protected void onViewCreated() {
        initView();
    }

    @Override
    protected void initEventAndData() {

    }
    //初始化控件
    private void initView() {
        LinearLayout acclayout = findViewById(R.id.lv_accept_statistice);

        LinearLayout entlayout = findViewById(R.id.lv_entrust_statistice);
        acclayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                skipStatisticsDetail("accept");
            }
        });
        entlayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                skipStatisticsDetail("entrust");
            }
        });
    }
    private void skipStatisticsDetail(String type) {
        if(type.equals("accept")){
            Intent intent = new Intent(getBaseContext(), StatisticsAcceptActivity.class);
            startActivity(intent);
        } else {
            Intent intent = new Intent(getBaseContext(), StatisticsEntrustActivity.class);
            startActivity(intent);
        }

    }
}