package com.technology.center.view.fragment;



import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.util.Log;
import android.view.View;

import androidx.localbroadcastmanager.content.LocalBroadcastManager;

import com.donkingliang.groupedadapter.adapter.GroupedRecyclerViewAdapter;
import com.donkingliang.groupedadapter.holder.BaseViewHolder;
import com.donkingliang.groupedadapter.layoutmanger.GroupedGridLayoutManager;
import com.technology.center.R;
import com.technology.center.adapter.MyAdapter;
import com.technology.center.model.MyModel;
import com.technology.center.view.base.BaseToolBarFragment;
import com.technology.center.view.user.SettingsActivity;

import java.util.ArrayList;
import java.util.List;

public class mainMyFragment extends BaseToolBarFragment {

    private List<MyModel> dataSource = new ArrayList<>();
    private MyAdapter adapter;
    @Override
    protected int getLayoutId() {
        return R.layout.fragment_main_my;
    }

    @Override
    protected void onViewCreated(View view) {
        initAdapter();
    }

    @Override
    protected void initEventAndData() {
        getData();
    }

    @Override
    protected void loadDataSource() {
        getData();
    }

    @Override
    protected void loadMoreDataSource() {
        springView.onFinishFreshAndLoad();
    }

    private void getData(){
        dataSource.clear();
        MyModel model = new MyModel();
        model.setTitle("设置");
        model.setIcon_mipmap(R.mipmap.icon_msg_receive);

        dataSource.add(model);

//        MyModel model1 = new MyModel();
//        model1.setTitle("用户手册");
//        model1.setIcon_mipmap(R.mipmap.icon_msg_system);
//
//        dataSource.add(model1);
//
//        MyModel model2 = new MyModel();
//        model2.setTitle("服务明细");
//        model2.setIcon_mipmap(R.mipmap.icon_msg_order);
//
//        dataSource.add(model2);

        springView.onFinishFreshAndLoad();
        adapter.notifyDataChanged();
    }
    private void initAdapter() {
        adapter = new MyAdapter(getContext(), dataSource);
        GroupedGridLayoutManager gridLayoutManager = new GroupedGridLayoutManager(getContext(), 1, adapter);
        adapter.setOnChildClickListener(listener);
        rvList.setAdapter(adapter);
        rvList.setLayoutManager(gridLayoutManager);
//        adapter.setOnClickSetting(new MyAdapter.onClickSetting() {
//
//                                      @Override
//                                      public void mySettingClick() {
//                                          Intent intent = new Intent(getContext(), SettingsActivity.class);
//                                          startActivity(intent);
//                                      }
//                                  });
        springView.setEnableHeader(false);

    }

            /**
     * 处理菜单点击事件
     */
    private GroupedRecyclerViewAdapter.OnChildClickListener listener = new GroupedRecyclerViewAdapter.OnChildClickListener() {
        @Override
        public void onChildClick(GroupedRecyclerViewAdapter adapter, BaseViewHolder holder, int groupPosition, int childPosition) {
            Intent intent = new Intent(getContext(), SettingsActivity.class);
            startActivity(intent);

        }
    };
}