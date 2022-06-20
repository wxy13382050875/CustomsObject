package com.technology.center.view.custom;


import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.animation.Animation;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.lifecycle.Observer;
import androidx.localbroadcastmanager.content.LocalBroadcastManager;

import com.kongzue.dialog.interfaces.OnDismissListener;
import com.kongzue.dialog.v3.TipDialog;
import com.kongzue.dialog.v3.WaitDialog;
import com.github.gzuliyujiang.wheelpicker.OptionPicker;
import com.github.gzuliyujiang.wheelpicker.contract.OnLinkagePickedListener;
import com.github.gzuliyujiang.wheelpicker.contract.OnOptionPickedListener;
import com.github.gzuliyujiang.wheelpicker.contract.OnOptionSelectedListener;
import com.github.gzuliyujiang.wheelpicker.widget.OptionWheelLayout;
import com.google.gson.reflect.TypeToken;
import com.technology.center.Constant;
import com.technology.center.R;
import com.technology.center.http.base.BaseDto;
import com.technology.center.model.CanSelectOrgsModel;
import com.technology.center.model.DictAllModel;
import com.technology.center.model.EntrustInspectModel;
import com.technology.center.repository.impl.UserRepository;
import com.technology.center.utils.GsonUtil;
import com.technology.center.utils.MyDictUtils;
import com.technology.center.utils.SpUtils;
import com.technology.center.utils.ToastUtil;
import com.technology.center.view.base.BaseActionBarActivity;
import com.technology.center.bean.GoodsCategoryBean;
import com.technology.center.view.picker.InstitutionsLikePicker;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import cxy.com.validate.IValidateResult;
import cxy.com.validate.Validate;
import cxy.com.validate.annotation.Index;
import cxy.com.validate.annotation.MaxLength;
import cxy.com.validate.annotation.NotNull;
import cxy.com.validate.annotation.RE;

public class DelegateAcceptDetailActivity extends BaseActionBarActivity {


    private static final String TAG = "DelegateAcceptDetailActivity";

    private EntrustInspectModel.ContentBean model;
    private String type;
    private String inspectOrgId;
    private String busCategory;
    private final UserRepository userRepository = new UserRepository();
    MyDictUtils myUtils ;

    @Index(1)
    @NotNull(msg = "检测编号不能为空！")
//    @MaxLength(length = 11, msg = "请输入检测编号")
    @BindView(R.id.tv_sn)
    EditText txtSn;

    @BindView(R.id.tv_source)
    TextView tvsource;

    @Index(3)
    @NotNull(msg = "业务类别不能为空！")
    @BindView(R.id.tv_busCategory)
    EditText txtBusCategory;

    @Index(4)
    @NotNull(msg = "检测机构不能为空")
    @BindView(R.id.tv_inspectOrg)
    EditText txtInspectOrg;

    @BindView(R.id.tv_entrustOrg)
    TextView tvEntrustOrg;

    @BindView(R.id.tv_phone)
    TextView tvPhone;

    @BindView(R.id.tv_sampleName)
    TextView tvSampleName;



    @BindView(R.id.tv_sampleNum)
    TextView tvsampleNum;

    @BindView(R.id.tv_spec)
    TextView tvspec;

//    @Index(11)
//    @NotNull(msg = "执行标准不能为空！")
    @BindView(R.id.tv_excStandard)
    EditText txtExcStandard;

//    @Index(12)
//    @NotNull(msg = "检测项目不能为空！")
    @BindView(R.id.tv_project)
    EditText txtProject;

//    @Index(13)
//    @NotNull(msg = "检测项目依据不能为空！")
    @BindView(R.id.tv_projectBasis)
    EditText txtprojectBasis;

    @BindView(R.id.tv_createTime)
    TextView tvcreateTime;

    @BindView(R.id.tv_producerAddress)
    TextView tvproducerAddress;

    @BindView(R.id.tv_takeWay)
    TextView tvtakeWay;

    @BindView(R.id.tv_acceptUserName)
    TextView tvacceptUserName;

    @BindView(R.id.tv_acceptUserPhone)
    TextView tvacceptUserPhone;

    @BindView(R.id.tv_acceptTime)
    TextView tvacceptTime;

    @BindView(R.id.btn_one)
    Button btnOne;

    @BindView(R.id.btn_two)
    Button btnTwo;
    @Override
    protected int getLayoutId() {
        return R.layout.activity_delegate_accept_detail;
    }

    @Override
    protected void onViewCreated() {
        spUtils = new SpUtils(getBaseContext());
        myUtils = new MyDictUtils(getBaseContext());
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
            type = bundle.getString("type");

            if(type.equals("ACCEPT")){
                commonTitleBar.getCenterTextView().setText("委托受理");
                tvsource.setText("自主申请");
                txtInspectOrg.setText(myUtils.getSingleOrgsNameById(model.getInspectOrgId()));
            } else if(type.equals("DISPATCH")){
                commonTitleBar.getCenterTextView().setText("派单");
                tvsource.setText(myUtils.getSingleOrgsNameById(model.getInspectOrgId())+"派单");
                txtInspectOrg.setText("");
                txtInspectOrg.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        showOrgPicker();
                    }
                });
            }
        }
        txtSn.setText(model.getSn());

        txtBusCategory.setText(myUtils.getDictNameBySubCode("BUS_CATEGORY",model.getBusCategory()));

        tvEntrustOrg.setText(model.getEntrustOrg().getName());
        tvPhone.setText( model.getEntrustOrg().getPhone());
        tvSampleName.setText(model.getSampleName());
        tvsampleNum.setText(model.getSampleNum());
        tvspec.setText(model.getSpec());
        txtExcStandard.setText(model.getExcStandard());
        txtProject.setText(model.getProject());
        txtprojectBasis.setText(model.getProjectBasis());
        tvcreateTime.setText(model.getCreateTime());
        tvproducerAddress.setText(model.getProducerAddress());
        tvtakeWay.setText(model.getTakeWay());
        tvtakeWay.setText(myUtils.getDictNameBySubCode("TAKE_WAY",model.getTakeWay()));

        tvacceptUserName.setText(model.getAcceptUserName());
        tvacceptUserPhone.setText(model.getAcceptUserPhone());
        tvacceptTime.setText(model.getAcceptTime());

        if(type.equals("ACCEPT")){
            btnOne.setText("退回");
            btnTwo.setText("受理");

        } else {
            btnOne.setText("取消");
            btnTwo.setText("确认");

        }

        txtBusCategory.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                showPicker();
            }
        });
    }
    private void showOrgPicker(){

        MyDictUtils myUtils = new MyDictUtils(getBaseContext());
        List<CanSelectOrgsModel.ChildrenBean> model = myUtils.getOrgsSingleList();
        OptionPicker picker = new OptionPicker(this);
        picker.setData(model);
        picker.setOnOptionPickedListener(new OnOptionPickedListener() {
            @Override
            public void onOptionPicked(int position, Object item) {
                CanSelectOrgsModel.ChildrenBean dictModel = (CanSelectOrgsModel.ChildrenBean)item;
                if(spUtils.getString("orgsId").equals(inspectOrgId)){
                    ToastUtil.show(getBaseContext(), "派单不能指派同一中心");
                    inspectOrgId = "";

                } else {
                    txtInspectOrg.setText(dictModel.getName());
                    inspectOrgId = dictModel.getId()+"";
                }

            }
        });
        picker.getWheelLayout().setOnOptionSelectedListener(new OnOptionSelectedListener() {
            @Override
            public void onOptionSelected(int position, Object item) {
                picker.getTitleView().setText(picker.getWheelView().formatItem(position));
            }
        });
//        picker.getWheelView().setStyle(R.style.WheelStyleDemo);
        picker.show();
    }
    private void showLikePicker(){
        InstitutionsLikePicker picker = new InstitutionsLikePicker(DelegateAcceptDetailActivity.this);
        picker.setOnLinkagePickedListener(new OnLinkagePickedListener() {
            @Override
            public void onLinkagePicked(Object first, Object second, Object third) {
//                        ToastUtil.show(getBaseContext(), first + "-" + second + "-" + third);
//                        Log.d("onLinkagePicked",first + "\n" + second + "\n" + third);
                String str = "";
                if(first != null){
                    CanSelectOrgsModel fristModel = (CanSelectOrgsModel)first;
                    str = fristModel.getName();
                    inspectOrgId = fristModel.getId()+"";
                }
                if(second != null){
                    CanSelectOrgsModel.ChildrenBean secModel = (CanSelectOrgsModel.ChildrenBean)second;
                    str +="/";
                    str += secModel.getName();
                    inspectOrgId = secModel.getId()+"";
                }
                if(third != null){
                    CanSelectOrgsModel.ChildrenBean thrModel = (CanSelectOrgsModel.ChildrenBean)third;
                    str +="/";
                    str += thrModel.getName();
                    inspectOrgId = thrModel.getId()+"";
                }
                if(spUtils.getString("orgsId").equals(inspectOrgId)){
                    ToastUtil.show(getBaseContext(), "派单不能指派同一中心");
                    inspectOrgId = "";
                    str = "";
                }
                txtInspectOrg.setText(str);
            }
        });
        picker.show();
    }
    private void showPicker(){



        List<DictAllModel.ItemsBean>  currentItems = myUtils.getDictItemByCode("BUS_CATEGORY");

        OptionPicker picker = new OptionPicker(this);
        picker.setData(currentItems);
        picker.setOnOptionPickedListener(new OnOptionPickedListener() {
            @Override
            public void onOptionPicked(int position, Object item) {
                DictAllModel.ItemsBean dictModel = (DictAllModel.ItemsBean)item;
                txtBusCategory.setText(dictModel.getName());
                busCategory = dictModel.getCode();
            }
        });
        picker.getWheelLayout().setOnOptionSelectedListener(new OnOptionSelectedListener() {
            @Override
            public void onOptionSelected(int position, Object item) {
                picker.getTitleView().setText(picker.getWheelView().formatItem(position));
            }
        });
//        picker.getWheelView().setStyle(R.style.WheelStyleDemo);
        picker.show();
    }

    //处理点击注册事件
    @OnClick({R.id.btn_one,R.id.btn_two})
    public void submit(View v) {
        if(v.getId() == R.id.btn_one){
            if(type.equals("ACCEPT")){
                buttonClick(v);
            } else {
                Log.d(TAG,"取消");
                finish();
            }
        } else {
            Validate.check(this, new IValidateResult() {
                @Override
                public void onValidateSuccess() {

                    buttonClick(v);
                }

                @Override
                public void onValidateError(String msg, View view) {
                    ToastUtil.show(getBaseContext(), msg);
                }

                @Override
                public Animation onValidateErrorAnno() {
                    return null;
                }
            });
        }

    }
    private void buttonClick(View v){
        String subType = "";
        String waitTitle = "";
        Map<String, String> params = new HashMap<>();
        if(v.getId() == R.id.btn_one){
            if(type.equals("ACCEPT")){
                Log.d(TAG,"退回");
                waitTitle = "退回成功！";
                subType = "BACK";
            } else {
                Log.d(TAG,"取消");
                subType = "Cancel";
            }
        } else if(v.getId() == R.id.btn_two){
            if(type.equals("ACCEPT")){
                Log.d(TAG,"受理");
                waitTitle = "受理成功！";
                subType = "ACCEPT";
            } else {
                Log.d(TAG,"确认");
                waitTitle = "派单成功！";
                subType = "DISPATCH";
                params.put("source",model.getInspectOrgId());
            }
        }
        params.put("sn",txtSn.getText().toString());
        params.put("inspectOrgId", inspectOrgId);
        params.put("busCategory", busCategory);
        params.put("excStandard", txtExcStandard.getText().toString());
        params.put("project", txtProject.getText().toString());
        params.put("projectBasis", txtprojectBasis.getText().toString());
        WaitDialog.show(DelegateAcceptDetailActivity.this, "正在提交...");
        userRepository.postEntrustInspect(model.getId(),subType,params).observe(DelegateAcceptDetailActivity.this, new Observer<BaseDto<EntrustInspectModel.ContentBean>>() {
            @Override
            public void onChanged(BaseDto<EntrustInspectModel.ContentBean> stringBaseDto) {

                if(stringBaseDto.getCode().equals(Constant.RespCode.R200)){

                    TipDialog.show(DelegateAcceptDetailActivity.this, "提交成功", TipDialog.TYPE.SUCCESS).setOnDismissListener(new OnDismissListener() {
                        @Override
                        public void onDismiss() {
                            onBack();
                        }
                    });

                } else {
                    TipDialog.show(DelegateAcceptDetailActivity.this, stringBaseDto.getMessage(), TipDialog.TYPE.WARNING);
                }

            }
        });

    }
    private void onBack() {
        Intent intent2 = new Intent("android.intent.action.CART_BROADCAST");
        intent2.putExtra("data","refresh");
        LocalBroadcastManager.getInstance(DelegateAcceptDetailActivity.this).sendBroadcast(intent2);
        sendBroadcast(intent2);
        finish();
    }
    protected void onDestroy() {
        super.onDestroy();

    }
}