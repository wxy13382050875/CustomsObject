package com.technology.center.view.custom;

import static com.technology.center.App.getContext;

import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.Observer;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.View;

import com.donkingliang.groupedadapter.adapter.GroupedRecyclerViewAdapter;
import com.donkingliang.groupedadapter.holder.BaseViewHolder;
import com.donkingliang.groupedadapter.layoutmanger.GroupedGridLayoutManager;
import com.liaoinstan.springview.aliheader.AliFooter;
import com.liaoinstan.springview.container.AutoFooter;
import com.technology.center.R;
import com.technology.center.Constant;
import com.technology.center.utils.ToastUtil;
import com.technology.center.adapter.MenuAdapter;
import com.technology.center.adapter.MsgAdapter;
import com.technology.center.adapter.MyCourierAdapter;
import com.technology.center.http.base.BaseDto;
import com.technology.center.model.EntrustInspectModel;
import com.technology.center.model.EntrustOrgModel;

import com.technology.center.repository.impl.UserRepository;
import com.technology.center.utils.GsonUtil;
import com.technology.center.view.base.BaseActionBarActivity;
import com.technology.center.view.base.BaseActionListBarActivity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MyCourierActivity extends BaseActionListBarActivity {
    private List<EntrustInspectModel.ContentBean> dataSource = new ArrayList<>();
    private MyCourierAdapter adapter;
    private int page = 1;
    private int size = 20;
    private final UserRepository userRepository = new UserRepository();
    @Override
    protected int getLayoutId() {
        return R.layout.activity_my_courier;
    }

    @Override
    protected void onViewCreated() {
        initAdapter();
    }
    private void initAdapter() {
        adapter = new MyCourierAdapter(getContext(), dataSource);
        GroupedGridLayoutManager gridLayoutManager = new GroupedGridLayoutManager(getContext(), 1, adapter);
        adapter.setOnChildClickListener(listener);
        adapter.setOnClickBtn(new MyCourierAdapter.onClickButton() {
            @Override
            public void myButtonClick(EntrustInspectModel.ContentBean bean) {
                Intent intent = new Intent(getContext(), MyCourierDetailActivity.class);
                //用Bundle携带数据
                Bundle bundle = new Bundle();
                //传递name参数为tinyphp
                bundle.putSerializable("model",bean);

                intent.putExtras(bundle);
                startActivity(intent);
            }
        });
        rvList.setAdapter(adapter);
        rvList.setLayoutManager(gridLayoutManager);
        springView.setFooter(new AutoFooter());
    }
    @Override
    protected void initEventAndData() {
        getData();
    }
    @Override
    protected void loadDataSource() {
        page = 1;
        dataSource.clear();
        getData();

    }

    @Override
    protected void loadMoreDataSource() {
        if (springView.getFooter(AutoFooter.class).isInProgress()) {
            page++;
            getData();
        }
    }

    private void getData(){
        EntrustOrgModel model = GsonUtil.fromJson(spUtils.getString("entrustOrg"), EntrustOrgModel.class);
        Map<String, String> params = new HashMap<>();

        params.put("status", "DONE");
        params.put("entrustOrgId", model.getId());
        params.put("takeWay", "MAIL");
        params.put("page", page + "");
        params.put("size", size + "");

        userRepository.getEntrustInspect(params).observe(MyCourierActivity.this, new Observer<BaseDto<EntrustInspectModel>>() {
            @Override
            public void onChanged(BaseDto<EntrustInspectModel> entrustInspectModelBaseDto) {
                springView.onFinishFreshAndLoad();
                if (entrustInspectModelBaseDto.getCode().equals(Constant.RespCode.R200)) {
                    if(entrustInspectModelBaseDto.getData().getContent().size() < size) {
                        springView.getFooter(AutoFooter.class).showBottomLine();
                    }
                    dataSource.addAll(entrustInspectModelBaseDto.getData().getContent());
                    Message msg = new Message();
                    msg.what = 1;
                    mHandler.sendMessage(msg);
                } else {
                    ToastUtil.show(getContext(), entrustInspectModelBaseDto.getMessage());
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
}