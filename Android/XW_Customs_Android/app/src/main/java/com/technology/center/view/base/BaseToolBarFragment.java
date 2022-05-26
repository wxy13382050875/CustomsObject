package com.technology.center.view.base;

import android.os.Bundle;
import android.os.Handler;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.liaoinstan.springview.aliheader.AliFooter;
import com.liaoinstan.springview.aliheader.AliHeader;
import com.liaoinstan.springview.container.AutoFooter;
import com.liaoinstan.springview.widget.SpringView;
import com.technology.center.utils.SpUtils;
import com.umeng.analytics.MobclickAgent;
import com.wuhenzhizao.titlebar.widget.CommonTitleBar;

import com.technology.center.R;

public abstract class BaseToolBarFragment extends Fragment {
    public CommonTitleBar commonTitleBar;
    private OnButtonClick onButtonClick;//2、定义接口成员变量
    public SpUtils spUtils;
    public RecyclerView rvList;
    public SpringView springView;

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {

        return inflater.inflate(getLayoutId(), container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        spUtils = new SpUtils(getContext());
        //设置头部导航颜色
        commonTitleBar = view.findViewById(R.id.titlebar);
        rvList = view.findViewById(R.id.recycler_view);
        springView = view.findViewById(R.id.springview);

        springView.setHeader(new AliHeader(getContext(), R.drawable.ali, true));   //参数为：logo图片资源，是否显示文字




        springView.setListener(new SpringView.OnFreshListener() {
            @Override
            public void onRefresh() {
                loadDataSource();
            }

            @Override
            public void onLoadmore() {
                loadMoreDataSource();
            }
        });

        onViewCreated(view);

        initEventAndData();
    }

    @Override
    public void onHiddenChanged(boolean hidden) {
        super.onHiddenChanged(hidden);
    }

    protected abstract int getLayoutId();

    /**
     * 在initEventAndData()之前执行
     */
    protected abstract void onViewCreated(View view);

    /**
     * 初始化数据
     */
    protected abstract void initEventAndData();

    /**
     * 下拉请求网络数据
     */
    protected abstract void loadDataSource();

    /**
     * 加载更多请求网络数据
     */
    protected abstract void loadMoreDataSource();

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
    //定义接口变量的get方法
    public OnButtonClick getOnButtonClick() {
        return onButtonClick;
    }

    //定义接口变量的set方法
    public void setOnButtonClick(OnButtonClick onButtonClick) {
        this.onButtonClick = onButtonClick;
    }

    //1、定义接口
    public interface OnButtonClick {
        public void onClick(int index);
    }
}
