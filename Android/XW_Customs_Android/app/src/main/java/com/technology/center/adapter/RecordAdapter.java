package com.technology.center.adapter;

import android.content.Context;
import android.view.View;
import android.widget.TextView;

import com.donkingliang.groupedadapter.adapter.GroupedRecyclerViewAdapter;
import com.donkingliang.groupedadapter.holder.BaseViewHolder;
import com.google.gson.reflect.TypeToken;
import com.technology.center.R;
import com.technology.center.model.DictAllModel;
import com.technology.center.model.EntrustInspectModel;
import com.technology.center.utils.GsonUtil;
import com.technology.center.utils.MyDictUtils;
import com.technology.center.utils.SpUtils;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

/**
 * 这是普通的分组Adapter 每一个组都有头部、尾部和子项。
 */
public class RecordAdapter extends GroupedRecyclerViewAdapter {

    public List<EntrustInspectModel.ContentBean> mGroups;
    public  Boolean isShowHeader;
    private onClickButton onClickBtn;
    public SpUtils spUtils = new SpUtils(mContext);
    public RecordAdapter(Context context, List<EntrustInspectModel.ContentBean> groups) {
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
        return false;
    }

    @Override
    public int getHeaderLayout(int viewType) {
        return R.layout.record_header_adapter;
    }

    @Override
    public int getFooterLayout(int viewType) {
        return 0;
    }

    @Override
    public int getChildLayout(int viewType) {
        return R.layout.record_adapter;
    }

    @Override
    public void onBindHeaderViewHolder(BaseViewHolder holder, int groupPosition) {
        EntrustInspectModel.ContentBean entity = mGroups.get(groupPosition);

        if(entity != null) {
            TextView tv_state = holder.get(R.id.tv_state);
            MyDictUtils myUtils = new MyDictUtils(mContext);
            tv_state.setText(myUtils.getDictNameBySubCode("ENTRUST_STATUS",entity.getStatus()));
            if(entity.getStatus().equals("DONE")){
                tv_state.setBackgroundResource(R.drawable.text_radius_green_shape);
            } else if(entity.getStatus().equals("ACCEPTED")){
                tv_state.setBackgroundResource(R.drawable.text_radius_org_shape);
            } else {
                tv_state.setBackgroundResource(R.drawable.text_radius_red_shape);
            }
        }


    }

    @Override
    public void onBindFooterViewHolder(BaseViewHolder holder, int groupPosition) {
    }

    @Override
    public void onBindChildViewHolder(BaseViewHolder holder, int groupPosition, int childPosition) {
        EntrustInspectModel.ContentBean entity = mGroups.get(groupPosition);;
        MyDictUtils myUtils = new MyDictUtils(mContext);
        if(entity != null) {
            holder.setText(R.id.tv_sn,entity.getSn());
//            holder.setText(R.id.tv_busCategory,entity.getBusCategory());
            holder.setText(R.id.tv_busCategory,myUtils.getDictNameBySubCode("BUS_CATEGORY",entity.getBusCategory()));
            holder.setText(R.id.tv_sampleName,entity.getSampleName());
            holder.setText(R.id.tv_spec,entity.getSpec());
            holder.setText(R.id.tv_createTime,entity.getCreateTime());


            holder.setText(R.id.tv_inspectOrg,myUtils.getSingleOrgsNameById(entity.getInspectOrgId()));

            holder.setText(R.id.tv_address,entity.getProducerAddress());


            if(!entity.getInspectResult().equals("WAIT")){
                holder.get(R.id.lv_state_info).setVisibility(View.VISIBLE);

                holder.setText(R.id.tv_acceptUserName,entity.getAcceptUserName());
                holder.setText(R.id.tv_acceptUserPhone,entity.getAcceptUserPhone());

                TextView tv_inspectResult = holder.get(R.id.tv_inspectResult);
                if(entity.getInspectResult().equals("ING")){

                    tv_inspectResult.setTextColor(mContext.getResources().getColor(R.color.org_color));
                } else {
                    tv_inspectResult.setTextColor(mContext.getResources().getColor(R.color.green_color));
                }
                tv_inspectResult.setText(myUtils.getDictNameBySubCode("INSPECT_RESULT",entity.getInspectResult()));
            }
        }

    }


    //接口回调
    public interface onClickButton {
        public void myButtonClick();
    }

    public void setOnClickBtn(onClickButton onClickBtn) {
        this.onClickBtn = onClickBtn;
    }

    public onClickButton getOnClickBtn() {
        return onClickBtn;
    }
}