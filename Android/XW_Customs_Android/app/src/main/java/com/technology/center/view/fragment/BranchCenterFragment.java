package com.technology.center.view.fragment;

import static android.app.Activity.RESULT_OK;

import static com.technology.center.App.getContext;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.View;

import androidx.annotation.Nullable;
import androidx.lifecycle.Observer;

import com.donkingliang.groupedadapter.adapter.GroupedRecyclerViewAdapter;
import com.donkingliang.groupedadapter.holder.BaseViewHolder;
import com.donkingliang.groupedadapter.layoutmanger.GroupedGridLayoutManager;
import com.technology.center.R;
import com.technology.center.adapter.AcceptAdapter;
import com.technology.center.adapter.BranchCenterAdapter;
import com.technology.center.adapter.TitleFragmentPagerAdapter;
import com.technology.center.http.base.BaseDto;
import com.technology.center.model.AcceptQueryModel;
import com.technology.center.model.CanSelectOrgsModel;
import com.technology.center.model.EntrustInspectModel;
import com.technology.center.repository.impl.UserRepository;
import com.technology.center.utils.MyDictUtils;
import com.technology.center.view.base.BaseToolBarFragment;
import com.technology.center.view.custom.BranchCenterWebActivity;
import com.technology.center.view.custom.CertificateQueryActivity;
import com.technology.center.view.custom.DelegateAcceptDetailActivity;
import com.technology.center.view.custom.ResultsRegisterDetailActivity;
import com.technology.center.view.custom.SamplingRecordDetailActivity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BranchCenterFragment extends BaseToolBarFragment  {



    private List<CanSelectOrgsModel.ChildrenBean> dataSource = new ArrayList<>();
    private BranchCenterAdapter adapter;
    private int page = 1;
    private int size = 20;

    @Override
    protected int getLayoutId() {
        return R.layout.fragment_branch_center;
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

    }

    @Override
    protected void loadMoreDataSource() {
        springView.onFinishFreshAndLoad();
    }
    private void getData(){
        MyDictUtils myUtils = new MyDictUtils(getContext());
        dataSource = myUtils.getOrgsSingleList();
        adapter.mGroups = dataSource;
        adapter.notifyDataChanged();
    }
    private void initAdapter() {

        adapter = new BranchCenterAdapter(getContext(),dataSource);
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
            CanSelectOrgsModel.ChildrenBean model = dataSource.get(childPosition);
            Intent intent = new Intent(getContext(), BranchCenterWebActivity.class);
            //用Bundle携带数据
            Bundle bundle = new Bundle();
            //传递name参数为tinyphp
            bundle.putSerializable("orgId",model.getId());

            intent.putExtras(bundle);
            startActivity(intent);

        }
    };


}