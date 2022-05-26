package com.technology.center.adapter;

import android.content.Context;

import com.donkingliang.groupedadapter.adapter.GroupedRecyclerViewAdapter;
import com.donkingliang.groupedadapter.holder.BaseViewHolder;
import com.technology.center.R;
import com.technology.center.model.CanSelectOrgsModel;
import com.technology.center.model.MsgTypeModel;
import com.technology.center.utils.MyDictUtils;

import java.util.List;

/**
 * 这是普通的分组Adapter 每一个组都有头部、尾部和子项。
 */
public class BranchCenterAdapter extends GroupedRecyclerViewAdapter {

    public List<CanSelectOrgsModel.ChildrenBean> mGroups;

    public BranchCenterAdapter(Context context, List<CanSelectOrgsModel.ChildrenBean> groups) {
        super(context);
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
        return false;
    }

    @Override
    public boolean hasFooter(int groupPosition) {
        return false;
    }

    @Override
    public int getHeaderLayout(int viewType) {
        return 0;
    }

    @Override
    public int getFooterLayout(int viewType) {
        return 0;
    }

    @Override
    public int getChildLayout(int viewType) {
        return R.layout.branch_center_adapter;
    }

    @Override
    public void onBindHeaderViewHolder(BaseViewHolder holder, int groupPosition) {
    }

    @Override
    public void onBindFooterViewHolder(BaseViewHolder holder, int groupPosition) {
    }

    @Override
    public void onBindChildViewHolder(BaseViewHolder holder, int groupPosition, int childPosition) {
        CanSelectOrgsModel.ChildrenBean entity = mGroups.get(childPosition);;


        holder.setText(R.id.tv_name,entity.getName());
    }



}