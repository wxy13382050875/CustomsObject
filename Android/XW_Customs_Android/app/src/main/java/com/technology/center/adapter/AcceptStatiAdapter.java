package com.technology.center.adapter;

import android.content.Context;
import android.view.View;
import android.widget.CheckBox;
import android.widget.CompoundButton;

import com.donkingliang.groupedadapter.adapter.GroupedRecyclerViewAdapter;
import com.donkingliang.groupedadapter.holder.BaseViewHolder;
import com.technology.center.R;
import com.technology.center.model.AcceptStatiModel;
import com.technology.center.model.EntrustInspectModel;
import com.technology.center.utils.MyDictUtils;
import com.technology.center.view.fragment.DelegagteAcceptFragment;

import java.util.List;

/**
 * 这是普通的分组Adapter 每一个组都有头部、尾部和子项。
 */
public class AcceptStatiAdapter extends GroupedRecyclerViewAdapter {

    public List<AcceptStatiModel> mGroups;
    public AcceptStatiAdapter(Context context, List<AcceptStatiModel> groups ) {
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
        return R.layout.accept_stati_adapter;
    }

    @Override
    public void onBindHeaderViewHolder(BaseViewHolder holder, int groupPosition) {

    }

    @Override
    public void onBindFooterViewHolder(BaseViewHolder holder, int groupPosition) {


    }

    @Override
    public void onBindChildViewHolder(BaseViewHolder holder, int groupPosition, int childPosition) {
        AcceptStatiModel entity = mGroups.get(groupPosition);
        MyDictUtils myUtils = new MyDictUtils(mContext);
        holder.setText(R.id.tv_inspectOrg,myUtils.getSingleOrgsNameById(entity.getInspectOrgId()));
        holder.setText(R.id.tv_waitAccept,entity.getWaitAccept());
        holder.setText(R.id.tv_accepted,entity.getAccepted());
        holder.setText(R.id.tv_registered,entity.getRegistered());
        holder.setText(R.id.tv_reportTaked,entity.getReportTaked());
    }

}