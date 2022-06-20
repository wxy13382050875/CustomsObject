package com.technology.center.view.custom;


import android.os.Bundle;
import android.view.View;
import android.view.animation.Animation;
import android.widget.EditText;
import android.widget.TextView;

import com.technology.center.R;
import com.technology.center.model.EntrustInspectModel;
import com.technology.center.utils.MyDictUtils;
import com.technology.center.utils.SpUtils;
import com.technology.center.utils.ToastUtil;
import com.technology.center.view.base.BaseActionBarActivity;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import cxy.com.validate.IValidateResult;
import cxy.com.validate.Validate;
import cxy.com.validate.annotation.Index;
import cxy.com.validate.annotation.MaxLength;
import cxy.com.validate.annotation.NotNull;
import cxy.com.validate.annotation.RE;



public class DelegateRecordDetailActivity extends BaseActionBarActivity {


    private static final String TAG = "DelegateRecordDetailActivity";
    private EntrustInspectModel.ContentBean model;
    @BindView(R.id.tv_entrustOrg)
    TextView tv_entrustOrg;

    @BindView(R.id.tv_inspectOrg)
    TextView tv_inspectOrg;

    @BindView(R.id.tv_address)
    TextView tv_address;

    @BindView(R.id.tv_contacts)
    TextView tv_contacts;

    @BindView(R.id.tv_phone)
    TextView tv_phone;

    @BindView(R.id.tv_sampleName)
    TextView tv_sampleName;

    @BindView(R.id.tv_sampleNum)
    TextView tv_sampleNum;

    @BindView(R.id.tv_spec)
    TextView tv_spec;

    @BindView(R.id.tv_createTime)
    TextView tv_createTime;

    @BindView(R.id.tv_excStandard)
    TextView tv_excStandard;

    @BindView(R.id.tv_sampleMark)
    TextView tv_sampleMark;

    @BindView(R.id.tv_sampleQuantity)
    TextView tv_sampleQuantity;

//    @BindView(R.id.tv_sampleWeight)
//    TextView tv_sampleWeight;

    @BindView(R.id.tv_project)
    TextView tv_project;

    @BindView(R.id.tv_projectBasis)
    TextView tv_projectBasis;

    @BindView(R.id.tv_producer)
    TextView tv_producer;

    @BindView(R.id.tv_producerAddress)
    TextView tv_producerAddress;

    @BindView(R.id.tv_takeWay)
    TextView tv_takeWay;

    @Override
    protected int getLayoutId() {
        return R.layout.activity_delegate_record_detail;
    }

    @Override
    protected void onViewCreated() {
        spUtils = new SpUtils(getBaseContext());
        initView();
        Validate.reg(this);
    }

    @Override
    protected void initEventAndData() {

    }
    //初始化控件
    private void initView() {
        ButterKnife.bind(this);

        Bundle bundle = this.getIntent().getExtras();
        if (bundle != null) {
            // 从bundle数据包中取出数据
            model = (EntrustInspectModel.ContentBean) bundle.getSerializable("model");
            tv_entrustOrg.setText(model.getEntrustOrg().getName());
            tv_address.setText(model.getEntrustOrg().getAddress());
            tv_contacts.setText(model.getEntrustOrg().getContacts());
            tv_phone.setText(model.getEntrustOrg().getPhone());
            tv_sampleName.setText(model.getSampleName());
            tv_sampleNum.setText(model.getSampleNum());
            tv_spec.setText(model.getSpec());
            tv_createTime.setText(model.getCreateTime());
            tv_excStandard.setText(model.getExcStandard());
            tv_sampleMark.setText(model.getSampleMark());
            tv_sampleQuantity.setText(model.getSampleQuantity());
//            tv_sampleWeight.setText(model.getSampleWeight());
            tv_project.setText(model.getProject());
            tv_projectBasis.setText(model.getProjectBasis());
            tv_producer.setText(model.getProducer());
            tv_producerAddress.setText(model.getProducerAddress());

            MyDictUtils myUtils = new MyDictUtils(getBaseContext());
            tv_inspectOrg.setText(myUtils.getSingleOrgsNameById(model.getInspectOrgId()));
            tv_takeWay.setText(myUtils.getDictNameBySubCode("TAKE_WAY",model.getTakeWay()));

        }

    }


}