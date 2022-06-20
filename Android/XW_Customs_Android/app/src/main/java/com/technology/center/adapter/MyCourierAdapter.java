package com.technology.center.adapter;

import android.content.Context;
import android.view.View;
import android.widget.Button;

import com.donkingliang.groupedadapter.adapter.GroupedRecyclerViewAdapter;
import com.donkingliang.groupedadapter.holder.BaseViewHolder;
import com.technology.center.R;
import com.technology.center.model.EntrustInspectModel;
import com.technology.center.model.MenuListModel;

import com.technology.center.utils.MyDictUtils;

import java.util.List;

/**
 * 这是普通的分组Adapter 每一个组都有头部、尾部和子项。
 */
public class MyCourierAdapter extends GroupedRecyclerViewAdapter {

    public List<EntrustInspectModel.ContentBean> mGroups;
    public  Boolean isShowHeader;
    private onClickButton onClickBtn;
    public MyCourierAdapter(Context context, List<EntrustInspectModel.ContentBean> groups) {
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
        return true;
    }

    @Override
    public boolean hasFooter(int groupPosition) {
        return true;
    }

    @Override
    public int getHeaderLayout(int viewType) {
        return R.layout.my_courier_header_adapter;
    }

    @Override
    public int getFooterLayout(int viewType) {
        return R.layout.my_courier_footer_adapter;
    }

    @Override
    public int getChildLayout(int viewType) {
        return R.layout.my_courier_adapter;
    }

    @Override
    public void onBindHeaderViewHolder(BaseViewHolder holder, int groupPosition) {
        EntrustInspectModel.ContentBean entity = mGroups.get(groupPosition);
        holder.setText(R.id.tv_expressNo, "快递单号:"+entity.getExpressNo());
    }

    @Override
    public void onBindFooterViewHolder(BaseViewHolder holder, int groupPosition) {
        EntrustInspectModel.ContentBean entity = mGroups.get(groupPosition);
        Button btn = holder.get(R.id.it_btn);
        btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (onClickBtn != null) {
                    onClickBtn.myButtonClick(entity);
                }
            }
        });
    }

    @Override
    public void onBindChildViewHolder(BaseViewHolder holder, int groupPosition, int childPosition) {
        EntrustInspectModel.ContentBean entity = mGroups.get(groupPosition);;

        MyDictUtils myUtils = new MyDictUtils(mContext);
        holder.setText(R.id.tv_sn, entity.getSn());
//        holder.setText(R.id.tv_busCategory, entity.getBusCategory());
        holder.setText(R.id.tv_busCategory,myUtils.getDictNameBySubCode("BUS_CATEGORY",entity.getBusCategory()));
        holder.setText(R.id.tv_sampleName, entity.getSampleName());
        holder.setText(R.id.tv_spec, entity.getSpec());
        holder.setText(R.id.tv_createTime, entity.getCreateTime());
        holder.setText(R.id.tv_inspectOrg, myUtils.getSingleOrgsNameById(entity.getInspectOrgId()) );
    }


    //接口回调
    public interface onClickButton {
        public void myButtonClick(EntrustInspectModel.ContentBean bean);
    }

    public void setOnClickBtn(onClickButton onClickBtn) {
        this.onClickBtn = onClickBtn;
    }

    public onClickButton getOnClickBtn() {
        return onClickBtn;
    }
}