package com.technology.center.adapter;

import android.content.Context;
import android.view.View;
import android.widget.TextView;

import com.donkingliang.groupedadapter.adapter.GroupedRecyclerViewAdapter;
import com.donkingliang.groupedadapter.holder.BaseViewHolder;
import com.technology.center.R;
import com.technology.center.model.MenuListModel;
import com.technology.center.model.MsgModel;
import com.technology.center.model.MsgTypeModel;

import java.util.List;

/**
 * 这是普通的分组Adapter 每一个组都有头部、尾部和子项。
 */
public class MsgAdapter extends GroupedRecyclerViewAdapter {

    public List<MsgModel.ContentBean> mGroups;

    public MsgAdapter(Context context, List<MsgModel.ContentBean> groups) {
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
        return R.layout.msg_grid_adapter;
    }

    @Override
    public void onBindHeaderViewHolder(BaseViewHolder holder, int groupPosition) {
    }

    @Override
    public void onBindFooterViewHolder(BaseViewHolder holder, int groupPosition) {
    }

    @Override
    public void onBindChildViewHolder(BaseViewHolder holder, int groupPosition, int childPosition) {
        MsgModel.ContentBean entity = mGroups.get(childPosition);;

        if (entity.getType().equals("SYSTEM")){
            holder.setImageResource(R.id.iv_icon,R.mipmap.icon_msg_system);
        } else if (entity.getType().equals("RECEIVE")){
            holder.setImageResource(R.id.iv_icon,R.mipmap.icon_msg_receive);
        } else if (entity.getType().equals("ORDER")){
            holder.setImageResource(R.id.iv_icon,R.mipmap.icon_msg_order);
        }
        holder.setText(R.id.tv_title,entity.getTitle());
        holder.setText(R.id.tv_createTime,entity.getCreateTime());
        holder.setText(R.id.tv_content,entity.getContent());
        TextView tv_readFlag = holder.get(R.id.tv_readFlag);
        if(entity.isReadFlag()){
            tv_readFlag.setVisibility(View.GONE);
        } else {
            tv_readFlag.setVisibility(View.VISIBLE);
        }
    }



}