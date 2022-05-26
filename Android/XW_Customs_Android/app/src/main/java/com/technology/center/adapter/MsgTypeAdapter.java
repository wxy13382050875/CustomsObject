package com.technology.center.adapter;

import android.content.Context;

import com.donkingliang.groupedadapter.adapter.GroupedRecyclerViewAdapter;
import com.donkingliang.groupedadapter.holder.BaseViewHolder;
import com.technology.center.R;
import com.technology.center.model.MsgTypeModel;
import com.technology.center.utils.MyDictUtils;

import java.util.List;

/**
 * 这是普通的分组Adapter 每一个组都有头部、尾部和子项。
 */
public class MsgTypeAdapter extends GroupedRecyclerViewAdapter {

    public List<MsgTypeModel> mGroups;

    public MsgTypeAdapter(Context context, List<MsgTypeModel> groups) {
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
        return R.layout.msg_type_grid_adapter;
    }

    @Override
    public void onBindHeaderViewHolder(BaseViewHolder holder, int groupPosition) {
    }

    @Override
    public void onBindFooterViewHolder(BaseViewHolder holder, int groupPosition) {
    }

    @Override
    public void onBindChildViewHolder(BaseViewHolder holder, int groupPosition, int childPosition) {
        MsgTypeModel entity = mGroups.get(childPosition);;

        MyDictUtils myUtils = new MyDictUtils(mContext);
        String title = myUtils.getDictNameBySubCode("MESSAGE_TYPE",entity.getType());
        if (entity.getType().equals("SYSTEM")){
            holder.setImageResource(R.id.iv_icon,R.mipmap.icon_msg_system);

        } else if (entity.getType().equals("RECEIVE")){
            holder.setImageResource(R.id.iv_icon,R.mipmap.icon_msg_receive);
        } else if (entity.getType().equals("ORDER")){
            holder.setImageResource(R.id.iv_icon,R.mipmap.icon_msg_order);
        }
        holder.setText(R.id.tv_type,title);
        holder.setText(R.id.tv_noReadNum,"您有"+entity.getNoReadNum() + "条" + title + "消息未阅读" );
    }
}