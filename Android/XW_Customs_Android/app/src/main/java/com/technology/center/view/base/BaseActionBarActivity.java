package com.technology.center.view.base;

import android.os.Bundle;
import android.view.View;
import android.widget.LinearLayout;

import androidx.annotation.Nullable;

import com.technology.center.utils.SpUtils;
import com.umeng.analytics.MobclickAgent;
import com.wuhenzhizao.titlebar.widget.CommonTitleBar;

import com.technology.center.R;

import butterknife.ButterKnife;

public abstract class BaseActionBarActivity extends BaseCompatActivity {
    private LinearLayout imageViewBack;
    public CommonTitleBar commonTitleBar;
    public SpUtils spUtils;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(getLayoutId());
        spUtils = new SpUtils(getBaseContext());
        imageViewBack = findViewById(R.id.iv_back_btn);
        commonTitleBar = findViewById(R.id.titlebar);

        //返回
        imageViewBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });
        onViewCreated();
        initEventAndData();
    }

    protected abstract int getLayoutId();

    /**
     * 在initEventAndData()之前执行
     */
    protected abstract void onViewCreated();

    /**
     * 初始化数据
     */
    protected abstract void initEventAndData();

    @Override
    public void onResume() {
        super.onResume();
        MobclickAgent.onResume(this);
    }

    @Override
    public void onPause() {
        super.onPause();
        MobclickAgent.onPause(this);
    }
}
