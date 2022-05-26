package com.technology.center.view.custom;


import static com.technology.center.App.getContext;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;

import androidx.lifecycle.Observer;

import com.donkingliang.groupedadapter.adapter.GroupedRecyclerViewAdapter;
import com.donkingliang.groupedadapter.holder.BaseViewHolder;
import com.donkingliang.groupedadapter.layoutmanger.GroupedGridLayoutManager;
import com.technology.center.Constant;
import com.technology.center.R;
import com.technology.center.adapter.AcceptStatiAdapter;
import com.technology.center.adapter.MsgAdapter;
import com.technology.center.http.base.BaseDto;
import com.technology.center.model.AcceptStatiModel;
import com.technology.center.model.CurrentUserModel;
import com.technology.center.model.MsgModel;
import com.technology.center.model.MsgTypeModel;
import com.technology.center.repository.impl.UserRepository;
import com.technology.center.utils.GsonUtil;
import com.technology.center.utils.MyDictUtils;
import com.technology.center.utils.ToastUtil;
import com.technology.center.view.base.BaseActionListBarActivity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import butterknife.ButterKnife;

public class StatisticsAcceptActivity extends BaseActionListBarActivity {


    private static final String TAG = "MsgActivity";
    private List<AcceptStatiModel> dataSource = new ArrayList<>();
    private AcceptStatiAdapter adapter;
    private final UserRepository userRepository = new UserRepository();

    @Override
    protected int getLayoutId() {
        return R.layout.activity_statistic_accept;
    }

    @Override
    protected void onViewCreated() {
        ButterKnife.bind(this);

        initAdapter();
    }
    private void initAdapter() {
        adapter = new AcceptStatiAdapter(getContext(), dataSource);
        GroupedGridLayoutManager gridLayoutManager = new GroupedGridLayoutManager(getContext(), 1, adapter);
        adapter.setOnChildClickListener(listener);
        rvList.setAdapter(adapter);
        rvList.setLayoutManager(gridLayoutManager);
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
        Map<String, String> params = new HashMap<>();

        params.put("inspectOrgId", spUtils.getString("orgsId"));
        userRepository.getAcceptStatiByOrgId(params).observe(StatisticsAcceptActivity.this, new Observer<BaseDto<List<AcceptStatiModel>>>() {
            @Override
            public void onChanged(BaseDto<List<AcceptStatiModel>> listBaseDto) {
                springView.onFinishFreshAndLoad();
                if (listBaseDto.getCode().equals(Constant.RespCode.R200)) {
                    dataSource = listBaseDto.getData();
                    Message msg = new Message();
                    msg.what = 1;
                    mHandler.sendMessage(msg);
                } else {
                    ToastUtil.show(getContext(), listBaseDto.getMessage());
                }
            }
        });
    }
    //handler
    private Handler mHandler = new Handler() {
        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            switch (msg.what) {
                case 1:
                    adapter.mGroups = dataSource;
                    adapter.notifyDataChanged();
                    break;
                default:
                    break;
            }
        }
    };

    /**
     * 处理菜单点击事件
     */
    private GroupedRecyclerViewAdapter.OnChildClickListener listener = new GroupedRecyclerViewAdapter.OnChildClickListener() {
        @Override
        public void onChildClick(GroupedRecyclerViewAdapter adapter, BaseViewHolder holder, int groupPosition, int childPosition) {


        }
    };

    @Override
    public void onResume() {
        super.onResume();
    }
}