package com.technology.center.adapter;

import android.content.Context;
import android.widget.TextView;

import com.donkingliang.groupedadapter.adapter.GroupedRecyclerViewAdapter;
import com.donkingliang.groupedadapter.holder.BaseViewHolder;
import com.technology.center.R;
import com.technology.center.model.ExpressModel;


import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * 这是普通的分组Adapter 每一个组都有头部、尾部和子项。
 */
public class MyCourierDetailAdapter extends GroupedRecyclerViewAdapter {

    public List<ExpressModel.ResultBean.ListBean> mGroups;
//    private onClickButton onClickBtn;
    public MyCourierDetailAdapter(Context context, List<ExpressModel.ResultBean.ListBean> groups) {
        super(context);
        mGroups = groups;
    }


    @Override
    public int getGroupCount() {
        return 1;
    }

    @Override
    public int getChildrenCount(int groupPosition) {

        return  mGroups == null ? 0 : mGroups.size();
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
        return R.layout.my_courier_detail_adapter;
    }

    @Override
    public void onBindHeaderViewHolder(BaseViewHolder holder, int groupPosition) {
    }

    @Override
    public void onBindFooterViewHolder(BaseViewHolder holder, int groupPosition) {
    }

    @Override
    public void onBindChildViewHolder(BaseViewHolder holder, int groupPosition, int childPosition) {
        ExpressModel.ResultBean.ListBean entity = mGroups.get(childPosition);;
        TextView tv_yearMonthDay = holder.get(R.id.tv_yearMonthDay);
        TextView tv_time = holder.get(R.id.tv_time);
        TextView tv_status = holder.get(R.id.tv_status);

        if(childPosition == 0){
            tv_yearMonthDay.setTextColor(mContext.getResources().getColor(R.color.bg_login_color));
            tv_time.setTextColor(mContext.getResources().getColor(R.color.bg_login_color));
            tv_status.setTextColor(mContext.getResources().getColor(R.color.bg_login_color));
            holder.setImageResource(R.id.iv_expres_spot,R.mipmap.icon_logistics_complete);
        }
        if(entity.getTime().length() > 0){
            List result_list = new ArrayList(Arrays.asList(entity.getTime().split(" ")));
            tv_yearMonthDay.setText(result_list.get(0).toString());
            tv_time.setText(result_list.get(1).toString());
        }
        tv_status.setText(entity.getStatus());
    }

}