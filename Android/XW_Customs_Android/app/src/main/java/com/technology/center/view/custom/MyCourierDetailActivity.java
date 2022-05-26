package com.technology.center.view.custom;

import static com.technology.center.App.getContext;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;

import androidx.lifecycle.Observer;

import com.donkingliang.groupedadapter.adapter.GroupedRecyclerViewAdapter;
import com.donkingliang.groupedadapter.holder.BaseViewHolder;
import com.donkingliang.groupedadapter.layoutmanger.GroupedGridLayoutManager;
import com.technology.center.R;
import com.technology.center.Constant;
import com.technology.center.utils.ToastUtil;
import com.technology.center.adapter.MyCourierDetailAdapter;
import com.technology.center.http.base.BaseDto;
import com.technology.center.model.EntrustInspectModel;
import com.technology.center.model.ExpressModel;
import com.technology.center.repository.impl.UserRepository;
import com.technology.center.view.base.BaseActionListBarActivity;

import java.util.ArrayList;
import java.util.List;

public class MyCourierDetailActivity extends BaseActionListBarActivity {
    private List<ExpressModel.ResultBean.ListBean> dataSource = new ArrayList<>();;
    private MyCourierDetailAdapter adapter;
    private final UserRepository userRepository = new UserRepository();
    private EntrustInspectModel.ContentBean model;
    @Override
    protected int getLayoutId() {
        return R.layout.activity_my_courier_detail;
    }

    @Override
    protected void onViewCreated() {
        initView();

    }
    private void initView(){
        Bundle bundle = this.getIntent().getExtras();
        if (bundle != null) {
            // 从bundle数据包中取出数据
            model = (EntrustInspectModel.ContentBean) bundle.getSerializable("model");
            initAdapter();
        }
    }
    private void initAdapter() {
        adapter = new MyCourierDetailAdapter(getContext(), dataSource);
        GroupedGridLayoutManager gridLayoutManager = new GroupedGridLayoutManager(getContext(), 1, adapter);
        adapter.setOnChildClickListener(listener);
        rvList.setAdapter(adapter);
        rvList.setLayoutManager(gridLayoutManager);
    }
    /**
     * 处理菜单点击事件
     */
    private GroupedRecyclerViewAdapter.OnChildClickListener listener = new GroupedRecyclerViewAdapter.OnChildClickListener() {
        @Override
        public void onChildClick(GroupedRecyclerViewAdapter adapter, BaseViewHolder holder, int groupPosition, int childPosition) {


        }
    };
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
        userRepository.getExpressDetail(model.getId()).observe(MyCourierDetailActivity.this, new Observer<BaseDto<ExpressModel>>() {
            @Override
            public void onChanged(BaseDto<ExpressModel> expressModelBaseDto) {
                springView.onFinishFreshAndLoad();
                if (expressModelBaseDto.getCode().equals(Constant.RespCode.R200)) {
                    dataSource = expressModelBaseDto.getData().getResult().getList();
                    Message msg = new Message();
                    msg.what = 1;
                    mHandler.sendMessage(msg);
                } else {
                    ToastUtil.show(getContext(), expressModelBaseDto.getMessage());
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

}