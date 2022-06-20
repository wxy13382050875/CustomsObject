package com.technology.center.adapter;

import android.content.Context;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.TextView;

import com.donkingliang.groupedadapter.adapter.GroupedRecyclerViewAdapter;
import com.donkingliang.groupedadapter.holder.BaseViewHolder;
import com.google.gson.reflect.TypeToken;
import com.technology.center.R;
import com.technology.center.model.DictAllModel;
import com.technology.center.model.EntrustInspectModel;

import com.technology.center.utils.GsonUtil;
import com.technology.center.utils.MyDictUtils;
import com.technology.center.view.fragment.DelegagteAcceptFragment;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

/**
 * 这是普通的分组Adapter 每一个组都有头部、尾部和子项。
 */
public class AcceptAdapter extends GroupedRecyclerViewAdapter {

    public List<EntrustInspectModel.ContentBean> mGroups;
    public  Boolean isShowHeader;
    private onClickButton onClickBtn;
    private DelegagteAcceptFragment.TypeEnum mType;
    public AcceptAdapter(Context context, List<EntrustInspectModel.ContentBean> groups , DelegagteAcceptFragment.TypeEnum type) {
        super(context);
        mGroups = groups;
        mType = type;
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
        if(mType == DelegagteAcceptFragment.TypeEnum.WAIT_ACCEPT){
            return true;
        } else if(mType == DelegagteAcceptFragment.TypeEnum.WAIT_SAMPLE ||
                mType == DelegagteAcceptFragment.TypeEnum.WAIT_REGISTER ||
                mType == DelegagteAcceptFragment.TypeEnum.REGISTERED ){
            return true;
        }
        return  false;
    }

    @Override
    public int getHeaderLayout(int viewType) {
        return R.layout.accept_header_adapter;
    }

    @Override
    public int getFooterLayout(int viewType) {
        if(mType == DelegagteAcceptFragment.TypeEnum.WAIT_ACCEPT){
            return R.layout.accept_footer_adapter;
        } else if(mType == DelegagteAcceptFragment.TypeEnum.WAIT_SAMPLE ||
                mType == DelegagteAcceptFragment.TypeEnum.WAIT_REGISTER ||
                mType == DelegagteAcceptFragment.TypeEnum.REGISTERED ){
            return R.layout.my_courier_footer_adapter;
        } else {
            return 0;
        }
    }

    @Override
    public int getChildLayout(int viewType) {
        return R.layout.accept_adapter;
    }

    @Override
    public void onBindHeaderViewHolder(BaseViewHolder holder, int groupPosition) {
        if(mType == DelegagteAcceptFragment.TypeEnum.WAIT_SAMPLE
                || mType == DelegagteAcceptFragment.TypeEnum.SAMPLED ){
            holder.setText(R.id.tv_title, "采样记录单");
        } else if(mType == DelegagteAcceptFragment.TypeEnum.WAIT_REGISTER ||
                mType == DelegagteAcceptFragment.TypeEnum.REGISTERED  ){
            holder.setText(R.id.tv_title, "检测结果登记");
        } else {
            holder.setText(R.id.tv_title, "委托记录单");
        }

    }

    @Override
    public void onBindFooterViewHolder(BaseViewHolder holder, int groupPosition) {
        EntrustInspectModel.ContentBean entity = mGroups.get(groupPosition);
        if(entity != null){
            if(mType == DelegagteAcceptFragment.TypeEnum.WAIT_SAMPLE ){
                holder.setText(R.id.it_btn, "采样");
                holder.get(R.id.it_btn).setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {

                        if (onClickBtn != null) {
                            onClickBtn.myButtonClick(entity,"SAMPLING");
                        }
                    }
                });
            } else if(mType == DelegagteAcceptFragment.TypeEnum.WAIT_REGISTER ){
                holder.setText(R.id.it_btn, "结果登记");
                holder.get(R.id.it_btn).setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        onClickBtn.myButtonClick(entity,"REGISTER");
                    }
                });
            } else if(mType == DelegagteAcceptFragment.TypeEnum.REGISTERED ){
                holder.setText(R.id.it_btn, "证书二维码");
                holder.get(R.id.it_btn).setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        onClickBtn.myButtonClick(entity,"QR");
                    }
                });
            } else if(mType == DelegagteAcceptFragment.TypeEnum.WAIT_ACCEPT ){
                holder.get(R.id.btn_accept).setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        onClickBtn.myButtonClick(entity,"ACCEPT");
                    }
                });
                holder.get(R.id.btn_send).setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        onClickBtn.myButtonClick(entity,"DISPATCH");
                    }
                });
            }
        }

    }

    @Override
    public void onBindChildViewHolder(BaseViewHolder holder, int groupPosition, int childPosition) {
        EntrustInspectModel.ContentBean entity = mGroups.get(groupPosition);
        if(entity != null){
            CheckBox foldCheckBox = holder.get(R.id.checkBox);
            foldCheckBox.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener(){
                @Override
                public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                    if(isChecked){
                        //用户点击的复选框的内容
                        holder.get(R.id.lv_fold_desc).setVisibility(View.VISIBLE);
                    }else{
                        holder.get(R.id.lv_fold_desc).setVisibility(View.GONE);
                    }

                }
            });
            MyDictUtils myUtils = new MyDictUtils(mContext);

            if(mType == DelegagteAcceptFragment.TypeEnum.ACCEPTED){
                holder.get(R.id.lv_sn).setVisibility(View.VISIBLE);
                holder.get(R.id.tv_sn).setVisibility(View.GONE);
                holder.setText(R.id.txt_sn,entity.getSn());
                holder.get(R.id.btn_edit).setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        EditText txtSn = holder.get(R.id.txt_sn);
                        entity.setSn(txtSn.getText().toString());
                        onClickBtn.myButtonClick(entity,"EDIT");
                    }
                });

            } else {
                holder.get(R.id.lv_sn).setVisibility(View.GONE);
                holder.get(R.id.tv_sn).setVisibility(View.VISIBLE);
                holder.setText(R.id.tv_sn,entity.getSn());
            }
            if(entity.getSource() !=null&& !entity.getSource().equals("")){
                holder.setText(R.id.tv_source,myUtils.getSingleOrgsNameById(entity.getSource()));

            } else {
                holder.setText(R.id.tv_source,"自主申请");
            }






            holder.setText(R.id.tv_busCategory,myUtils.getDictNameBySubCode("BUS_CATEGORY",entity.getBusCategory()));
            holder.setText(R.id.tv_inspectOrg,myUtils.getSingleOrgsNameById(entity.getInspectOrgId()));

            if(entity.getEntrustOrg() != null){
                holder.setText(R.id.tv_entrustOrg,entity.getEntrustOrg().getName());
                holder.setText(R.id.tv_phone,entity.getEntrustOrg().getPhone());
            }

            holder.setText(R.id.tv_sampleName,entity.getSampleName());
            holder.setText(R.id.tv_sampleNum,entity.getSampleNum());
            holder.setText(R.id.tv_spec,entity.getSpec());
            holder.setText(R.id.tv_excStandard,entity.getExcStandard());
            holder.setText(R.id.tv_project,entity.getProject());
            holder.setText(R.id.tv_projectBasis,entity.getProjectBasis());
            holder.setText(R.id.tv_createTime,entity.getCreateTime());
            holder.setText(R.id.tv_producerAddress,entity.getProducerAddress());
            holder.setText(R.id.tv_takeWay,myUtils.getDictNameBySubCode("TAKE_WAY",entity.getTakeWay()) );

            if(mType == DelegagteAcceptFragment.TypeEnum.WAIT_SAMPLE ||
                    mType == DelegagteAcceptFragment.TypeEnum.SAMPLED  ||
                    mType == DelegagteAcceptFragment.TypeEnum.WAIT_REGISTER ||
                    mType == DelegagteAcceptFragment.TypeEnum.ACCEPTED){
                holder.get(R.id.lv_accetp_info).setVisibility(View.VISIBLE);
                holder.setText(R.id.tv_acceptUserName,entity.getAcceptUserName());
                holder.setText(R.id.tv_acceptUserPhone,entity.getAcceptUserPhone());
                holder.setText(R.id.tv_acceptTime,entity.getAcceptTime());
            }
            if(mType == DelegagteAcceptFragment.TypeEnum.REGISTERED ){
                holder.get(R.id.lv_accetp_info).setVisibility(View.VISIBLE);
                holder.get(R.id.lv_result_info).setVisibility(View.VISIBLE);
                holder.setText(R.id.tv_acceptUserName,entity.getAcceptUserName());
                holder.setText(R.id.tv_acceptUserPhone,entity.getAcceptUserPhone());
                holder.setText(R.id.tv_acceptTime,entity.getAcceptTime());
                holder.setText(R.id.tv_inspectResult,entity.getInspectResult());
                holder.setText(R.id.tv_expressNo,entity.getExpressNo());
                if(entity.getExpressNo()!= null){
                    holder.get(R.id.tx_query).setVisibility(View.VISIBLE);
                    holder.get(R.id.tx_query).setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            onClickBtn.myButtonClick(entity,"LOGISTICS");
                        }
                    });
                } else {
                    holder.get(R.id.tx_query).setVisibility(View.GONE);
                }

                holder.setText(R.id.tv_registerUserName,entity.getRegisterUserName());
                holder.setText(R.id.tv_registerTime,entity.getRegisterTime());
            }
        }

    }


    //接口回调
    public interface onClickButton {
        public void myButtonClick(EntrustInspectModel.ContentBean model,String type);
    }

    public void setOnClickBtn(onClickButton onClickBtn) {
        this.onClickBtn = onClickBtn;
    }

    public onClickButton getOnClickBtn() {
        return onClickBtn;
    }
}