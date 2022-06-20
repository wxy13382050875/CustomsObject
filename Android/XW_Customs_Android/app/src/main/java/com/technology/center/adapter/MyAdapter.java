package com.technology.center.adapter;

import android.content.Context;
import android.content.Intent;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;

import com.donkingliang.groupedadapter.adapter.GroupedRecyclerViewAdapter;
import com.donkingliang.groupedadapter.holder.BaseViewHolder;
import com.technology.center.model.CurrentUserModel;
import com.technology.center.model.MyModel;

import java.util.List;

import com.technology.center.R;
import com.technology.center.utils.GsonUtil;
import com.technology.center.utils.SpUtils;

/**
 * 这是普通的分组Adapter 每一个组都有头部、尾部和子项。
 */
public class MyAdapter extends GroupedRecyclerViewAdapter {

    public List<MyModel> mGroups;
    private Context mContext;
    private onClickSetting onClickSetting;
    public MyAdapter(Context context, List<MyModel> groups) {
        super(context);
        mContext = context;
        mGroups = groups;
    }


    @Override
    public int getGroupCount() {
        return 1;
    }

    @Override
    public int getChildrenCount(int groupPosition) {
        return mGroups.size();
    }

    @Override
    public boolean hasHeader(int groupPosition) {
        return true;

    }

    @Override
    public boolean hasFooter(int groupPosition) {
        return false;
    }

    @Override
    public int getHeaderLayout(int viewType) {
        return R.layout.my_header_adapter;
    }

    @Override
    public int getFooterLayout(int viewType) {
        return 0;
    }

    @Override
    public int getChildLayout(int viewType) {
        return R.layout.my_adapter;
    }

    @Override
    public void onBindHeaderViewHolder(BaseViewHolder holder, int groupPosition) {
        SpUtils spUtils = new SpUtils(mContext);
        CurrentUserModel userModel = GsonUtil.fromJson(spUtils.getString("userInfo"), CurrentUserModel.class);
        if (userModel != null) {
            holder.setText(R.id.tv_show_user_info, userModel.getPhone());
            holder.setText(R.id.tv_show_is_complete, userModel.getTrueName()==null ? "请完善信息" : userModel.getTrueName());
        }

//        ImageView btnEditInfo = holder.get(R.id.btn_setting);
//        //跳转到编辑资料
//        btnEditInfo.setOnClickListener(view -> {
//            if (onClickSetting != null) {
//                onClickSetting.mySettingClick();
//            }
//        });
    }

    @Override
    public void onBindFooterViewHolder(BaseViewHolder holder, int groupPosition) {
    }

    @Override
    public void onBindChildViewHolder(BaseViewHolder holder, int groupPosition, int childPosition) {
        MyModel entity = mGroups.get(childPosition);
        holder.setText(R.id.tv_title, entity.getTitle());
    }

    //接口回调
    public interface onClickSetting {
        public void mySettingClick();
    }

    public void setOnClickSetting(onClickSetting onClicSetting) {
        this.onClickSetting = onClicSetting;

    }
}