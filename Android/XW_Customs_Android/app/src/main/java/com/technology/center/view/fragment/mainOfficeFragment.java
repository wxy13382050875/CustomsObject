package com.technology.center.view.fragment;

import android.content.Intent;
import android.util.Log;
import android.view.View;

import com.donkingliang.groupedadapter.adapter.GroupedRecyclerViewAdapter;
import com.donkingliang.groupedadapter.holder.BaseViewHolder;
import com.donkingliang.groupedadapter.layoutmanger.GroupedGridLayoutManager;
import com.liaoinstan.springview.aliheader.AliFooter;
import com.liaoinstan.springview.aliheader.AliHeader;
import com.technology.center.R;
import com.technology.center.adapter.MenuAdapter;
import com.technology.center.model.CurrentUserModel;
import com.technology.center.model.MenuListModel;
import com.technology.center.utils.GsonUtil;
import com.technology.center.utils.ToastUtil;
import com.technology.center.view.base.BaseToolBarFragment;
import com.technology.center.view.custom.CertificateManageActivity;
import com.technology.center.view.custom.CertificateQueryActivity;
import com.technology.center.view.custom.DelegateAcceptActivity;
import com.technology.center.view.custom.DelegateInspectionActivity;
import com.technology.center.view.custom.DelegateRegistActivity;
import com.technology.center.view.custom.MyCourierActivity;
import com.technology.center.view.custom.PaymentServicesActivity;
import com.technology.center.view.custom.SamplingRecordActivity;
import com.technology.center.view.custom.ResultsRegisterActivity;
import com.technology.center.view.custom.StatisticsQueryActivity;

import java.util.ArrayList;
import java.util.List;

import lombok.SneakyThrows;

public class mainOfficeFragment extends BaseToolBarFragment {

    private List<CurrentUserModel.MobilePermissionTreeBean> dataSource = new ArrayList<>();
    private MenuAdapter adapter;

    @Override
    protected int getLayoutId() {
        return R.layout.fragment_main_office;
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
        springView.onFinishFreshAndLoad();
        Log.d("--------loadDataSource-------","1");
    }

    @Override
    protected void loadMoreDataSource() {
        springView.onFinishFreshAndLoad();
        Log.d("--------loadMoreDataSource-------","1");
    }

    private void getData(){
        CurrentUserModel userModel = GsonUtil.fromJson(spUtils.getString("userInfo"), CurrentUserModel.class);
        dataSource = userModel.getMobilePermissionTree();
        adapter.mGroups = dataSource;
        adapter.notifyDataChanged();
    }
    private void initAdapter() {
        adapter = new MenuAdapter(getContext(), dataSource);
        adapter.isShowHeader = true;
        GroupedGridLayoutManager gridLayoutManager = new GroupedGridLayoutManager(getContext(), 3, adapter);
        adapter.setOnChildClickListener(listener);
        rvList.setAdapter(adapter);
        rvList.setLayoutManager(gridLayoutManager);
        springView.setEnableHeader(false);
    }

    /**
     * 处理菜单点击事件
     */
    private final GroupedRecyclerViewAdapter.OnChildClickListener listener = new GroupedRecyclerViewAdapter.OnChildClickListener() {
        @SneakyThrows
        @Override
        public void onChildClick(GroupedRecyclerViewAdapter adapter, BaseViewHolder holder, int groupPosition, int childPosition) {
            CurrentUserModel.MobilePermissionTreeBean.ChildrenBean model = dataSource.get(groupPosition).getChildren().get(childPosition);
            if (model.getAndroidPath().equals("DelegateRegistActivity")) {
                Intent intent = new Intent(getContext(), DelegateRegistActivity.class);
                startActivity(intent);
            } else if (model.getAndroidPath().equals("DelegateInspectionActivity")) {
                if(spUtils.getString("entrustOrg").equals("null")){
                    ToastUtil.show(getContext(), "请完善委托单位信息");
                    return;
                }
                Intent intent = new Intent(getContext(), DelegateInspectionActivity.class);
                startActivity(intent);
            } else if (model.getAndroidPath().equals("CertificateManageActivity")) {
                Intent intent = new Intent(getContext(), CertificateManageActivity.class);
                startActivity(intent);
            } else if (model.getAndroidPath().equals("CertificateQueryActivity")) {
                Intent intent = new Intent(getContext(), CertificateQueryActivity.class);
                startActivity(intent);
            } else if (model.getAndroidPath().equals("PaymentServicesActivity")) {
                Intent intent = new Intent(getContext(), PaymentServicesActivity.class);
                startActivity(intent);
            } else if (model.getAndroidPath().equals("MyCourierActivity")) {
                Intent intent = new Intent(getContext(), MyCourierActivity.class);
                startActivity(intent);
            } else if (model.getAndroidPath().equals("DelegateAcceptActivity")) {
                Intent intent = new Intent(getContext(), DelegateAcceptActivity.class);
                startActivity(intent);
            } else if (model.getAndroidPath().equals("SamplingRecordActivity")) {
                Intent intent = new Intent(getContext(), SamplingRecordActivity.class);
                startActivity(intent);
            } else if (model.getAndroidPath().equals("ResultsRegisterActivity")) {
                Intent intent = new Intent(getContext(), ResultsRegisterActivity.class);
                startActivity(intent);
            } else if (model.getAndroidPath().equals("StatisticsQueryActivity")) {
                Intent intent = new Intent(getContext(), StatisticsQueryActivity.class);
                startActivity(intent);
            } else {
                ToastUtil.show(getContext(), "未找到相关跳转页面");
            }

        }
    };
}