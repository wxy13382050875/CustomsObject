package com.technology.center.view.fragment;

import static android.app.Activity.RESULT_OK;

import static com.technology.center.App.getContext;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.widget.LinearLayout;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.drawerlayout.widget.DrawerLayout;
import androidx.lifecycle.Observer;
import androidx.localbroadcastmanager.content.LocalBroadcastManager;
import androidx.recyclerview.widget.RecyclerView;

import com.donkingliang.groupedadapter.adapter.GroupedRecyclerViewAdapter;
import com.donkingliang.groupedadapter.holder.BaseViewHolder;
import com.donkingliang.groupedadapter.layoutmanger.GroupedGridLayoutManager;
import com.kongzue.dialog.interfaces.OnDismissListener;
import com.kongzue.dialog.v3.TipDialog;
import com.kongzue.dialog.v3.WaitDialog;
import com.liaoinstan.springview.aliheader.AliFooter;
import com.liaoinstan.springview.container.AutoFooter;
import com.technology.center.R;
import com.technology.center.Constant;
import com.technology.center.adapter.AcceptAdapter;
import com.technology.center.adapter.TitleFragmentPagerAdapter;
import com.technology.center.http.base.BaseDto;
import com.technology.center.model.AcceptQueryModel;
import com.technology.center.model.CurrentUserModel;
import com.technology.center.model.EntrustInspectModel;

import com.technology.center.repository.impl.UserRepository;
import com.technology.center.utils.GsonUtil;
import com.technology.center.view.base.BaseToolBarFragment;
import com.technology.center.view.custom.MyCourierDetailActivity;
import com.technology.center.view.custom.MyQrActivity;
import com.technology.center.view.custom.ResultsRegisterActivity;
import com.technology.center.view.custom.DelegateAcceptDetailActivity;
import com.technology.center.view.custom.SamplingRecordDetailActivity;
import com.technology.center.view.custom.ResultsRegisterDetailActivity;

import com.wuhenzhizao.titlebar.widget.CommonTitleBar;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.technology.center.utils.ToastUtil;

public class DelegagteAcceptFragment extends BaseToolBarFragment  implements TitleFragmentPagerAdapter.UpdateAble {


    public enum TypeEnum {

//        海关处理端状态：
        WAIT_ACCEPT,// 待受理,
        ACCEPTED,// 已受理,
        BACK ,//已退回,
        WAIT_SAMPLE ,//待采样,
        SAMPLED ,//已采样,
        WAIT_REGISTER ,//待登记（未完成）,
        REGISTERED ,//已登记（已完成）
    }

    private final UserRepository userRepository = new UserRepository();
    private List<EntrustInspectModel.ContentBean> dataSource = new ArrayList<>();
    private AcceptAdapter adapter;
    public TypeEnum type;
    public AcceptQueryModel queryModel;
    private int page = 1;
    private int size = 20;
    boolean isLoading;
    private Handler handler = new Handler();

    @Override
    protected int getLayoutId() {
        return R.layout.fragment_delegate_accept;
    }

    @Override
    protected void onViewCreated(View view) {
        LocalBroadcastManager broadcastManager = LocalBroadcastManager.getInstance(getActivity());
        IntentFilter intentFilter = new IntentFilter();
        intentFilter.addAction("android.intent.action.CART_BROADCAST");
        BroadcastReceiver mItemViewListClickReceiver = new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent){
                String msg = intent.getStringExtra("data");
                if("refresh".equals(msg)){
                    dataSource.clear();
                    loadDataSource();
                }
            }
        };
        broadcastManager.registerReceiver(mItemViewListClickReceiver, intentFilter);
        initAdapter();
    }

    @Override
    protected void initEventAndData() {
        getData();
    }

    @Override
    protected void loadDataSource() {
        springView.getFooter(AutoFooter.class).showProgress();
//        CurrentUserModel model = GsonUtil.fromJson(spUtils.getString("userInfo"), CurrentUserModel.class);
        page =1;
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

        Map<String, String> params = new HashMap<>();

        String queryInspectStatus = "";

        switch (type){
            case WAIT_ACCEPT:
                queryInspectStatus = "WAIT_ACCEPT";
                break;
            case ACCEPTED:
                queryInspectStatus = "ACCEPTED";
                break;
            case BACK:
                queryInspectStatus = "BACK";
                break;
            case WAIT_SAMPLE:
                queryInspectStatus = "WAIT_SAMPLE";
                break;
            case SAMPLED:
                queryInspectStatus = "SAMPLED";
                break;
            case WAIT_REGISTER:
                queryInspectStatus = "WAIT_REGISTER";
                break;
            case REGISTERED:
                queryInspectStatus = "REGISTERED";
                break;

        }
        params.put("queryInspectStatus", queryInspectStatus);
        params.put("inspectOrgId", spUtils.getString("orgsId"));
        params.put("page", page + "");
        params.put("size", size + "");
        if(queryModel != null){
            params.put("entrustOrgId", queryModel.getEntrustOrgId()== null?"":queryModel.getEntrustOrgId());
            params.put("inspectOrgId", queryModel.getInspectOrgId()== null?"":queryModel.getInspectOrgId());

            params.put("sampleName", queryModel.getSampleName()== null?"":queryModel.getSampleName());

            params.put("entrustOrgName", queryModel.getEntrustOrgName()== null?"":queryModel.getEntrustOrgName());
            params.put("acceptUserName", queryModel.getAcceptUserName()== null?"":queryModel.getAcceptUserName());
            params.put("inspectResult", queryModel.getInspectResult()== null?"":queryModel.getInspectResult());
            params.put("sn", queryModel.getSn()== null ? "": queryModel.getSn());
            params.put("from", queryModel.getFrom()== null?"":queryModel.getFrom());
            params.put("to", queryModel.getTo()== null?"":queryModel.getTo());
            params.put("acceptTimeFrom",queryModel.getAcceptTimeFrom()== null?"":queryModel.getAcceptTimeFrom());
            params.put("acceptTimeTo", queryModel.getAcceptTimeTo()== null?"":queryModel.getAcceptTimeTo());
            params.put("samplingTimeFrom",queryModel.getSamplingTimeFrom()== null?"":queryModel.getSamplingTimeFrom());
            params.put("samplingTimeTo", queryModel.getSamplingTimeTo()== null?"":queryModel.getSamplingTimeTo());
        }

        userRepository.getEntrustInspect(params).observe(DelegagteAcceptFragment.this, new Observer<BaseDto<EntrustInspectModel>>() {
            @Override
            public void onChanged(BaseDto<EntrustInspectModel> entrustInspectModelBaseDto) {
                springView.onFinishFreshAndLoad();
                if (entrustInspectModelBaseDto.getCode().equals(Constant.RespCode.R200)) {

                    if(entrustInspectModelBaseDto.getData().getContent().size() < size){
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
    private void initAdapter() {
        adapter = new AcceptAdapter(getContext(), dataSource,type);
        GroupedGridLayoutManager gridLayoutManager = new GroupedGridLayoutManager(getContext(), 1, adapter);
        adapter.setOnChildClickListener(listener);
        adapter.setOnClickBtn(new AcceptAdapter.onClickButton() {
            @Override
            public void myButtonClick(EntrustInspectModel.ContentBean model, String type) {

                if(type.equals("SAMPLING")){//采样
                    Intent intent = new Intent(getContext(), SamplingRecordDetailActivity.class);
                    //用Bundle携带数据
                    Bundle bundle = new Bundle();
                    //传递name参数为tinyphp
                    bundle.putSerializable("model",model);
                    bundle.putString("type", type);

                    intent.putExtras(bundle);
                    startActivity(intent);
                } else if(type.equals("REGISTER")){//结果登记

                    Intent intent = new Intent(getContext(), ResultsRegisterDetailActivity.class);
                    //用Bundle携带数据
                    Bundle bundle = new Bundle();
                    //传递name参数为tinyphp
                    bundle.putSerializable("model",model);
                    bundle.putString("type", type);

                    intent.putExtras(bundle);
                    startActivity(intent);
                } else if(type.equals("QR")){//结果登记

                    Intent intent = new Intent(getContext(), MyQrActivity.class);
                    //用Bundle携带数据
                    Bundle bundle = new Bundle();
                    //传递name参数为tinyphp
                    bundle.putSerializable("model",model);
                    bundle.putString("type", type);

                    intent.putExtras(bundle);
                    startActivity(intent);
                } else if(type.equals("EDIT")){//修改SN号
                    putEntrustInspect(model);

                } else if(type.equals("LOGISTICS")){//查看物流
                    Log.d("tag---","LOGISTICS");
                    Intent intent = new Intent(getContext(), MyCourierDetailActivity.class);
                    //用Bundle携带数据
                    Bundle bundle = new Bundle();
                    //传递name参数为tinyphp
                    bundle.putSerializable("model",model);

                    intent.putExtras(bundle);
                    startActivity(intent);

                }
                else {
                    Intent intent = new Intent(getContext(), DelegateAcceptDetailActivity.class);
                    //用Bundle携带数据
                    Bundle bundle = new Bundle();
                    //传递name参数为tinyphp
                    bundle.putSerializable("model",model);
                    bundle.putString("type", type);

                    intent.putExtras(bundle);
                    startActivity(intent);
                }

            }
        });
        rvList.setAdapter(adapter);
        rvList.setLayoutManager(gridLayoutManager);
        springView.setFooter(new AutoFooter());
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
    public void update(AcceptQueryModel model) {
        queryModel = model;
        loadDataSource();
    }

    @Override
    public void onResume() {
        super.onResume();
    }

    private void putEntrustInspect(EntrustInspectModel.ContentBean model){
        if (model.getSn() != null && !model.getSn().equals("")){
            Map<String, String> params = new HashMap<>();
            params.put("id", model.getId());
            params.put("sn", model.getSn());
            userRepository.putEntrustInspect(model.getId(),params).observe(DelegagteAcceptFragment.this, new Observer<BaseDto<EntrustInspectModel>>() {
                @Override
                public void onChanged(BaseDto<EntrustInspectModel> entrustInspectModelBaseDto) {
                    if(entrustInspectModelBaseDto.getCode().equals(Constant.RespCode.R200)){

                        ToastUtil.show(getContext(), "修改成功");

                    } else {
                        ToastUtil.show(getContext(), entrustInspectModelBaseDto.getMessage());
                    }

                }
            });
        } else {
            ToastUtil.show(getContext(), "检测编号不能为空");
        }

    }
}