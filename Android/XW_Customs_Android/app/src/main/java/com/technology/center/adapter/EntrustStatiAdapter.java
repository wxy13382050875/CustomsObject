package com.technology.center.adapter;

import android.content.Context;

import com.donkingliang.groupedadapter.adapter.GroupedRecyclerViewAdapter;
import com.donkingliang.groupedadapter.holder.BaseViewHolder;
import com.technology.center.R;
import com.technology.center.model.AcceptStatiModel;
import com.technology.center.model.EntrustStatiModel;

import java.util.List;

/**
 * 这是普通的分组Adapter 每一个组都有头部、尾部和子项。
 */
public class EntrustStatiAdapter extends GroupedRecyclerViewAdapter {

    public List<EntrustStatiModel> mGroups;
    public EntrustStatiAdapter(Context context, List<EntrustStatiModel> groups ) {
        super(context);
        mGroups = groups;
    }


    @Override
    public int getGroupCount() {
        return mGroups == null ? 0 : mGroups.size();
    }

    @Override
    public int getChildrenCount(int groupPosition) {

        return 1;
    }

    @Override
    public boolean hasHeader(int groupPosition) {
        return false;
    }

    @Override
    public boolean hasFooter(int groupPosition) {

        return  false;
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
        return R.layout.entrust_stati_adapter;
    }

    @Override
    public void onBindHeaderViewHolder(BaseViewHolder holder, int groupPosition) {

    }

    @Override
    public void onBindFooterViewHolder(BaseViewHolder holder, int groupPosition) {


    }

    @Override
    public void onBindChildViewHolder(BaseViewHolder holder, int groupPosition, int childPosition) {
        EntrustStatiModel entity = mGroups.get(groupPosition);

        holder.setText(R.id.tv_entrustOrgName,entity.getEntrustOrgName());
        holder.setText(R.id.tv_apply,entity.getApply());
        holder.setText(R.id.tv_back,entity.getBack());
        holder.setText(R.id.tv_waitAccept,entity.getWaitAccept());
        holder.setText(R.id.tv_accepted,entity.getAccepted());
        holder.setText(R.id.tv_done,entity.getDone());
    }

}