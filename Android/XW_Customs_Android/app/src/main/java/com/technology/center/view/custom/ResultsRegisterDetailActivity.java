package com.technology.center.view.custom;


import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;

import androidx.lifecycle.Observer;

import com.google.gson.reflect.TypeToken;
import com.kongzue.dialog.interfaces.OnDismissListener;
import com.kongzue.dialog.v3.TipDialog;
import com.kongzue.dialog.v3.WaitDialog;
import com.technology.center.Constant;
import com.technology.center.R;
import com.technology.center.http.base.BaseDto;
import com.technology.center.model.DictAllModel;
import com.technology.center.model.EntrustInspectModel;
import com.technology.center.repository.impl.UserRepository;
import com.technology.center.utils.GsonUtil;
import com.technology.center.utils.MyDictUtils;
import com.technology.center.utils.SpUtils;
import com.technology.center.utils.ToastUtil;
import com.technology.center.view.base.BaseActionBarActivity;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import cxy.com.validate.Validate;
import cxy.com.validate.annotation.Index;

public class ResultsRegisterDetailActivity extends BaseActionBarActivity {


    private static final String TAG = "ResultsRegisterDetailActivity";

    private EntrustInspectModel.ContentBean model;
    private String type;
    private String takeWay = "";

    private final UserRepository userRepository = new UserRepository();


    private  RadioGroup mRadioGroup;

    @Index(11)
    @BindView(R.id.txt_expressNo)
    EditText txtexpressNo;


    @BindView(R.id.btn_one)
    Button btnOne;

    @BindView(R.id.btn_two)
    Button btnTwo;
    @Override
    protected int getLayoutId() {
        return R.layout.activity_result_register_detail;
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
            type = bundle.getString("type");
        }

        mRadioGroup = findViewById(R.id.rg_marry);
        mRadioGroup.setOrientation(LinearLayout.HORIZONTAL);

        MyDictUtils myUtils = new MyDictUtils(getBaseContext());
        List<DictAllModel.ItemsBean>  Items = myUtils.getDictItemByCode("TAKE_WAY");
        for(int i=0; i<Items.size(); i++)
        {
            RadioButton radioButton = new RadioButton(this);
            RadioGroup.LayoutParams lp = new RadioGroup.LayoutParams(RadioGroup.LayoutParams.WRAP_CONTENT, RadioGroup.LayoutParams.WRAP_CONTENT);
            //设置RadioButton边距 (int left, int top, int right, int bottom)
            lp.setMargins(15,0,0,0);
            //设置RadioButton背景
            //radioButton.setBackgroundResource(R.drawable.xx);
            //设置RadioButton的样式
//            radioButton.setButtonDrawable(R.drawable.radio_bg);
            //设置文字距离四周的距离
            radioButton.setPadding(5, 0, 0, 0);
            //设置文字
            radioButton.setText(Items.get(i).getName());
            final int finalI = i;
            //设置radioButton的点击事件
            radioButton.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    takeWay = Items.get(finalI).getCode();
                    txtexpressNo.setText("");
                    if(takeWay.equals("SELF_TAKE")){
                        txtexpressNo.setEnabled(false);
                    } else {
                        txtexpressNo.setEnabled(true);
                    }

                }
            });
            mRadioGroup.addView(radioButton);
        }
    }


    //处理点击注册事件
    @OnClick({R.id.btn_one,R.id.btn_two})
    public void submit(View v) {
        if(v.getId() == R.id.btn_one){
            finish();

        } else {
            if(takeWay.equals("")){
                ToastUtil.show(getBaseContext(), "请选择报告拿取方式");
                return;
            } else if(takeWay.equals("SELF_TAKE")){
                Map<String, String> params = new HashMap<>();
                params.put("takeWay",takeWay);
                WaitDialog.show(ResultsRegisterDetailActivity.this, "正在提交...");
                userRepository.postEntrustInspect(model.getId(),"REGISTER",params).observe(ResultsRegisterDetailActivity.this, new Observer<BaseDto<EntrustInspectModel.ContentBean>>() {
                    @Override
                    public void onChanged(BaseDto<EntrustInspectModel.ContentBean> stringBaseDto) {

                        if(stringBaseDto.getCode().equals(Constant.RespCode.R200)){
                            TipDialog.show(ResultsRegisterDetailActivity.this, "成功！", TipDialog.TYPE.SUCCESS).setOnDismissListener(new OnDismissListener() {
                                @Override
                                public void onDismiss() {
                                    finish();
                                }
                            });

                        } else {
                            TipDialog.show(ResultsRegisterDetailActivity.this, stringBaseDto.getMessage(), TipDialog.TYPE.WARNING);
                        }

                    }
                });
            } else {
                if(txtexpressNo.getText().toString().equals("")){
                    ToastUtil.show(getBaseContext(), "请输入快递单号");
                    return;
                }
                Map<String, String> params = new HashMap<>();
                params.put("sn",txtexpressNo.getText().toString());
                WaitDialog.show(ResultsRegisterDetailActivity.this, "正在提交...");
                userRepository.getVerifyExpressSn(params).observe(ResultsRegisterDetailActivity.this, new Observer<BaseDto<Boolean>>() {
                    @Override
                    public void onChanged(BaseDto<Boolean> booleanBaseDto) {
                        if (booleanBaseDto.getCode().equals(Constant.RespCode.R200)) {
                            if(booleanBaseDto.getData()){
                                Map<String, String> params = new HashMap<>();
                                params.put("takeWay",takeWay);
                                params.put("expressNo", txtexpressNo.getText().toString());
                                userRepository.postEntrustInspect(model.getId(),"REGISTER",params).observe(ResultsRegisterDetailActivity.this, new Observer<BaseDto<EntrustInspectModel.ContentBean>>() {
                                    @Override
                                    public void onChanged(BaseDto<EntrustInspectModel.ContentBean> stringBaseDto) {
//                                        WaitDialog.dismiss();
                                        if(stringBaseDto.getCode().equals(Constant.RespCode.R200)){
                                            TipDialog.show(ResultsRegisterDetailActivity.this, "成功！", TipDialog.TYPE.SUCCESS).setOnDismissListener(new OnDismissListener() {
                                                @Override
                                                public void onDismiss() {
                                                    finish();
                                                }
                                            });

                                        } else {
                                            TipDialog.show(ResultsRegisterDetailActivity.this, stringBaseDto.getMessage(), TipDialog.TYPE.WARNING);
                                        }

                                    }
                                });
                            } else {
                                TipDialog.show(ResultsRegisterDetailActivity.this, "快递单号不正确", TipDialog.TYPE.WARNING);
                            }
                        } else {
                            ToastUtil.show(getBaseContext(), booleanBaseDto.getMessage());
                        }
                    }
                });
            }
        }
    }
    protected void onDestroy() {
        super.onDestroy();
    }
}