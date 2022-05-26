package com.technology.center.adapter;

import android.content.Context;

import com.donkingliang.groupedadapter.adapter.GroupedRecyclerViewAdapter;
import com.donkingliang.groupedadapter.holder.BaseViewHolder;
import com.technology.center.R;
import com.technology.center.model.CurrentUserModel;
import com.technology.center.model.MenuListModel;
import android.widget.ImageView;
import com.bumptech.glide.Glide;
import java.util.List;

/**
 * 这是普通的分组Adapter 每一个组都有头部、尾部和子项。
 */
public class MenuAdapter extends GroupedRecyclerViewAdapter {

    public List<CurrentUserModel.MobilePermissionTreeBean> mGroups;
    public  Boolean isShowHeader;
    public MenuAdapter(Context context, List<CurrentUserModel.MobilePermissionTreeBean> groups) {
        super(context);
        mGroups = groups;
    }


    @Override
    public int getGroupCount() {
        return mGroups == null ? 0 : mGroups.size();
    }

    @Override
    public int getChildrenCount(int groupPosition) {
        List<CurrentUserModel.MobilePermissionTreeBean.ChildrenBean> children = mGroups.get(groupPosition).getChildren();
        return children == null ? 0 : children.size();
    }

    @Override
    public boolean hasHeader(int groupPosition) {
        return isShowHeader;
    }

    @Override
    public boolean hasFooter(int groupPosition) {
        return false;
    }

    @Override
    public int getHeaderLayout(int viewType) {
        return R.layout.menu_header_adapter;
    }

    @Override
    public int getFooterLayout(int viewType) {
        return 0;
    }

    @Override
    public int getChildLayout(int viewType) {
        return R.layout.menu_grid_adapter;
    }

    @Override
    public void onBindHeaderViewHolder(BaseViewHolder holder, int groupPosition) {
        CurrentUserModel.MobilePermissionTreeBean entity = mGroups.get(groupPosition);
        holder.setText(R.id.tv_title, entity.getName());
        ImageView imageView;
        imageView = holder.get(R.id.iv_icon);
        Glide.with(mContext).load(entity.getIcon()).into(imageView);
    }

    @Override
    public void onBindFooterViewHolder(BaseViewHolder holder, int groupPosition) {
    }

    @Override
    public void onBindChildViewHolder(BaseViewHolder holder, int groupPosition, int childPosition) {
        CurrentUserModel.MobilePermissionTreeBean.ChildrenBean entity = mGroups.get(groupPosition).getChildren().get(childPosition);;
        holder.setText(R.id.tv_title,entity.getName());
        if(entity.getIcon().equals("")){
            holder.setImageResource(R.id.iv_icon,entity.getIcon_mipmap());
        } else {
            ImageView imageView = holder.get(R.id.iv_icon);
            Glide.with(mContext).load(entity.getIcon()).into(imageView);
        }
    }
}