package com.technology.center.view.fragment;

import static com.technology.center.App.getContext;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.View;

import androidx.lifecycle.Observer;

import com.donkingliang.groupedadapter.adapter.GroupedRecyclerViewAdapter;
import com.donkingliang.groupedadapter.holder.BaseViewHolder;
import com.donkingliang.groupedadapter.layoutmanger.GroupedGridLayoutManager;
import com.technology.center.Constant;
import com.technology.center.R;
import com.technology.center.adapter.MenuAdapter;
import com.technology.center.adapter.MsgAdapter;
import com.technology.center.adapter.MsgTypeAdapter;
import com.technology.center.http.base.BaseDto;
import com.technology.center.model.CurrentUserModel;
import com.technology.center.model.EntrustInspectModel;
import com.technology.center.model.EntrustOrgModel;
import com.technology.center.model.MenuListModel;

import com.technology.center.model.MsgTypeModel;
import com.technology.center.repository.impl.UserRepository;
import com.technology.center.utils.GsonUtil;
import com.technology.center.utils.ToastUtil;
import com.technology.center.view.base.BaseToolBarFragment;
import com.technology.center.view.custom.CertificateManageActivity;
import com.technology.center.view.custom.CertificateQueryActivity;
import com.technology.center.view.custom.MsgActivity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class mainMsgFragment extends BaseToolBarFragment {

    private List<MsgTypeModel> dataSource = new ArrayList<>();
    private MsgTypeAdapter adapter;
    private final UserRepository userRepository = new UserRepository();
    @Override
    protected int getLayoutId() {
        return R.layout.fragment_main_msg;
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

    private void getData() {
        CurrentUserModel model = GsonUtil.fromJson(spUtils.getString("userInfo"), CurrentUserModel.class);
        Map<String, String> params = new HashMap<>();

        params.put("userId", model.getId());

        userRepository.getMsgGroup(params).observe(mainMsgFragment.this, new Observer<BaseDto<List<MsgTypeModel>>>() {
            @Override
            public void onChanged(BaseDto<List<MsgTypeModel>> listBaseDto) {
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
    private void initAdapter() {
        adapter = new MsgTypeAdapter(getContext(), dataSource);
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

            Intent intent = new Intent(getContext(), MsgActivity.class);
            //用Bundle携带数据
            Bundle bundle = new Bundle();
            //传递name参数为tinyphp
            bundle.putSerializable("model",dataSource.get(childPosition));

            intent.putExtras(bundle);
            startActivity(intent);
        }
    };

    @Override
    public void onResume() {
        super.onResume();
    }
}