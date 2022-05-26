package com.technology.center.view.base;

import static com.technology.center.App.getContext;

import android.os.Bundle;
import android.view.View;
import android.widget.LinearLayout;

import androidx.annotation.Nullable;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.liaoinstan.springview.aliheader.AliFooter;
import com.liaoinstan.springview.aliheader.AliHeader;
import com.liaoinstan.springview.container.AutoFooter;
import com.liaoinstan.springview.widget.SpringView;
import com.technology.center.R;
import com.technology.center.utils.SpUtils;
import com.umeng.analytics.MobclickAgent;
import com.wuhenzhizao.titlebar.widget.CommonTitleBar;

public abstract class BaseActionListBarActivity extends BaseCompatActivity {
    public CommonTitleBar commonTitleBar;
    private LinearLayout imageViewBack;
    public RecyclerView rvList;
    public SpringView springView;
    public SpUtils spUtils;


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);



        setContentView(getLayoutId());

        spUtils = new SpUtils(getBaseContext());
        commonTitleBar = findViewById(R.id.titlebar);
        imageViewBack = findViewById(R.id.iv_back_btn);

        rvList = findViewById(R.id.recycler_view);
        springView = findViewById(R.id.springview);


        //返回
        imageViewBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });


        springView.setListener(new SpringView.OnFreshListener() {
            @Override
            public void onRefresh() {
//                new Handler().postDelayed(() -> springView.onFinishFreshAndLoad(), 1000);
                loadDataSource();
            }

            @Override
            public void onLoadmore() {
//                new Handler().postDelayed(() -> springView.onFinishFreshAndLoad(), 1000);
                loadMoreDataSource();
            }
        });
        springView.setHeader(new AliHeader(getContext(), R.drawable.ali, true));   //参数为：logo图片资源，是否显示文字

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

    /**
     * 请求网络数据
     */
    protected abstract void loadDataSource();

    /**
     * 加载更多请求网络数据
     */
    protected abstract void loadMoreDataSource();

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
