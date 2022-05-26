package com.technology.center.view.custom;


import static com.technology.center.App.getContext;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.Gravity;
import android.view.View;
import android.widget.EditText;
import android.widget.LinearLayout;

import androidx.annotation.NonNull;
import androidx.drawerlayout.widget.DrawerLayout;
import androidx.lifecycle.Observer;

import com.donkingliang.groupedadapter.adapter.GroupedRecyclerViewAdapter;
import com.donkingliang.groupedadapter.holder.BaseViewHolder;
import com.donkingliang.groupedadapter.layoutmanger.GroupedGridLayoutManager;
import com.github.gzuliyujiang.calendarpicker.CalendarPicker;
import com.github.gzuliyujiang.calendarpicker.OnRangeDatePickListener;
import com.github.gzuliyujiang.calendarpicker.core.ColorScheme;
import com.liaoinstan.springview.container.AutoFooter;
import com.technology.center.R;
import com.technology.center.Constant;
import com.technology.center.utils.ToastUtil;
import com.technology.center.adapter.CertificateAdapter;
import com.technology.center.adapter.MsgAdapter;
import com.technology.center.http.base.BaseDto;
import com.technology.center.model.AcceptQueryModel;
import com.technology.center.model.CurrentUserModel;
import com.technology.center.model.EntrustInspectModel;
import com.technology.center.model.EntrustOrgModel;
import com.technology.center.model.MsgModel;
import com.technology.center.model.MsgTypeModel;
import com.technology.center.repository.impl.UserRepository;
import com.technology.center.utils.GsonUtil;
import com.technology.center.utils.MyDictUtils;
import com.technology.center.view.base.BaseActionListBarActivity;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class MsgActivity extends BaseActionListBarActivity {


    private static final String TAG = "MsgActivity";
    private List<MsgModel.ContentBean> dataSource = new ArrayList<>();
    private MsgAdapter adapter;
    private MsgTypeModel model;
    private final UserRepository userRepository = new UserRepository();
    private int page = 1;
    private int size = 20;




    @Override
    protected int getLayoutId() {
        return R.layout.activity_msg;
    }

    @Override
    protected void onViewCreated() {
        ButterKnife.bind(this);
        Bundle bundle = this.getIntent().getExtras();
        if (bundle != null) {
            // 从bundle数据包中取出数据
            model = (MsgTypeModel) bundle.getSerializable("model");

            MyDictUtils myUtils = new MyDictUtils(getBaseContext());
            String title = myUtils.getDictNameBySubCode("MESSAGE_TYPE",model.getType());
            commonTitleBar.getCenterTextView().setText(title);

        }
        initAdapter();
    }
    private void initAdapter() {
        adapter = new MsgAdapter(getContext(), dataSource);
        GroupedGridLayoutManager gridLayoutManager = new GroupedGridLayoutManager(getContext(), 1, adapter);
        adapter.setOnChildClickListener(listener);
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

    private void getData (){
        Map<String, String> params = new HashMap<>();

        CurrentUserModel userModel = GsonUtil.fromJson(spUtils.getString("userInfo"), CurrentUserModel.class);
        params.put("type", model.getType());
        params.put("page", page + "");
        params.put("size", size + "");
        params.put("targetUserId", userModel.getId());

        userRepository.getMsgList(params).observe(MsgActivity.this, new Observer<BaseDto<MsgModel>>() {
            @Override
            public void onChanged(BaseDto<MsgModel> listBaseDto) {
                springView.onFinishFreshAndLoad();
                if (listBaseDto.getCode().equals(Constant.RespCode.R200)) {
                    if(listBaseDto.getData().getContent().size() < size) {
                        springView.getFooter(AutoFooter.class).showBottomLine();
                    }
                    dataSource.addAll(listBaseDto.getData().getContent());
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
            Intent intent = new Intent(getContext(), MsgDetailActivity.class);
            //用Bundle携带数据
            Bundle bundle = new Bundle();
            //传递name参数为tinyphp
            MsgModel.ContentBean bean = dataSource.get(childPosition);
            bundle.putString("msgId",bean.getId());
            intent.putExtras(bundle);
            startActivity(intent);

        }
    };

    @Override
    public void onResume() {
        super.onResume();
        loadDataSource();
    }
}