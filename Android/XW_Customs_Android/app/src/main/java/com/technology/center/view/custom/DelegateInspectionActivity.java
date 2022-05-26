package com.technology.center.view.custom;


import static com.technology.center.App.getContext;

import android.content.Intent;
import android.view.View;
import android.view.animation.Animation;
import android.widget.EditText;

import com.donkingliang.groupedadapter.adapter.GroupedRecyclerViewAdapter;
import com.donkingliang.groupedadapter.holder.BaseViewHolder;
import com.donkingliang.groupedadapter.layoutmanger.GroupedGridLayoutManager;
import com.technology.center.R;
import com.technology.center.adapter.MenuAdapter;
import com.technology.center.model.CurrentUserModel;
import com.technology.center.model.MenuListModel;
import com.technology.center.utils.SpUtils;
import com.technology.center.utils.ToastUtil;
import com.technology.center.view.base.BaseActionBarActivity;
import com.technology.center.view.base.BaseActionListBarActivity;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.BindViews;
import butterknife.OnClick;
import cxy.com.validate.IValidateResult;
import cxy.com.validate.Validate;
import cxy.com.validate.annotation.Index;
import cxy.com.validate.annotation.MaxLength;
import cxy.com.validate.annotation.NotNull;
import cxy.com.validate.annotation.RE;
import lombok.SneakyThrows;

public class DelegateInspectionActivity extends BaseActionListBarActivity {


    private static final String TAG = "BaseActionListBarActivity";

    private List<CurrentUserModel.MobilePermissionTreeBean> dataSource = new ArrayList<>();
    private MenuAdapter adapter;

    @Override
    protected int getLayoutId() {
        return R.layout.activity_delegate_inspection;
    }

    @Override
    protected void onViewCreated() {
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
        CurrentUserModel.MobilePermissionTreeBean model = new CurrentUserModel.MobilePermissionTreeBean();
        model.setName("委托检验");
        model.setIcon_mipmap(R.mipmap.ic_bom_nav_icon_home);

        List<CurrentUserModel.MobilePermissionTreeBean.ChildrenBean> menus = new ArrayList<>();
        CurrentUserModel.MobilePermissionTreeBean.ChildrenBean subModel = new CurrentUserModel.MobilePermissionTreeBean.ChildrenBean();
        subModel.setName("委托记录");
        subModel.setIcon("");
        subModel.setIcon_mipmap(R.mipmap.icon_delegate_record);
        subModel.setAndroidPath("DelegateRecordActivity");

        menus.add(subModel);

        CurrentUserModel.MobilePermissionTreeBean.ChildrenBean subModel1 = new CurrentUserModel.MobilePermissionTreeBean.ChildrenBean();
        subModel1.setName("委托申请");
        subModel1.setIcon("");
        subModel1.setIcon_mipmap(R.mipmap.icon_delegate_apply);
        subModel1.setAndroidPath("DelegateApplyActivity");

        menus.add(subModel1);

        model.setChildren(menus);

        dataSource.add(model);

        adapter.notifyDataChanged();
    }

    private void initAdapter() {
        adapter = new MenuAdapter(getContext(), dataSource);
        adapter.isShowHeader = false;
        GroupedGridLayoutManager gridLayoutManager = new GroupedGridLayoutManager(getContext(), 3, adapter);
        adapter.setOnChildClickListener(listener);
        rvList.setAdapter(adapter);
        rvList.setLayoutManager(gridLayoutManager);
        springView.setEnable(false);
    }
    /**
     * 处理菜单点击事件
     */
    private GroupedRecyclerViewAdapter.OnChildClickListener listener = new GroupedRecyclerViewAdapter.OnChildClickListener() {
        @SneakyThrows
        @Override
        public void onChildClick(GroupedRecyclerViewAdapter adapter, BaseViewHolder holder, int groupPosition, int childPosition) {
            CurrentUserModel.MobilePermissionTreeBean.ChildrenBean model = dataSource.get(groupPosition).getChildren().get(childPosition);
            if (model.getAndroidPath().equals("DelegateRecordActivity")) {
                Intent intent = new Intent(getContext(), DelegateRecordActivity.class);
                startActivity(intent);
            } else if (model.getAndroidPath().equals("DelegateApplyActivity")) {
                Intent intent = new Intent(getContext(), DelegateApplyActivity.class);
                startActivity(intent);
            } else {

            }

        }
    };



}