package com.technology.center.adapter;

import android.content.Context;

import com.donkingliang.groupedadapter.adapter.GroupedRecyclerViewAdapter;
import com.donkingliang.groupedadapter.holder.BaseViewHolder;
import com.technology.center.R;
import com.technology.center.model.EntrustInspectModel;


import java.util.List;

/**
 * 这是普通的分组Adapter 每一个组都有头部、尾部和子项。
 */
public class CertificateAdapter extends GroupedRecyclerViewAdapter {

    public List<EntrustInspectModel.ContentBean> mGroups;

    public CertificateAdapter(Context context, List<EntrustInspectModel.ContentBean> groups) {
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
        return R.layout.certificate_grid_adapter;
    }

    @Override
    public void onBindHeaderViewHolder(BaseViewHolder holder, int groupPosition) {
    }

    @Override
    public void onBindFooterViewHolder(BaseViewHolder holder, int groupPosition) {
    }

    @Override
    public void onBindChildViewHolder(BaseViewHolder holder, int groupPosition, int childPosition) {
        EntrustInspectModel.ContentBean entity = mGroups.get(childPosition);;

        holder.setText(R.id.tv_sn,"检测编号:" + entity.getSn());
        holder.setText(R.id.tv_createTime,"申请时间:" + entity.getCreateTime());
    }



}