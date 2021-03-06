package com.technology.center.view.custom;


import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;

import androidx.lifecycle.Observer;
import androidx.localbroadcastmanager.content.LocalBroadcastManager;

import com.google.gson.reflect.TypeToken;
import com.google.zxing.integration.android.IntentIntegrator;
import com.google.zxing.integration.android.IntentResult;
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
import com.technology.center.view.qr.QrCodeActivity;

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

    @BindView(R.id.iv_icon)
    ImageView iv_icon;


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
    //???????????????
    private void initView() {
        ButterKnife.bind(this);
        Bundle bundle = this.getIntent().getExtras();
        if (bundle != null) {
            // ???bundle????????????????????????
            model = (EntrustInspectModel.ContentBean) bundle.getSerializable("model");
            type = bundle.getString("type");
        }

        mRadioGroup = findViewById(R.id.rg_marry);
        mRadioGroup.setOrientation(LinearLayout.HORIZONTAL);

        txtexpressNo.setEnabled(false);
        iv_icon.setEnabled(false);

        MyDictUtils myUtils = new MyDictUtils(getBaseContext());
        List<DictAllModel.ItemsBean>  Items = myUtils.getDictItemByCode("TAKE_WAY");
        for(int i=0; i<Items.size(); i++)
        {
            RadioButton radioButton = new RadioButton(this);
            RadioGroup.LayoutParams lp = new RadioGroup.LayoutParams(RadioGroup.LayoutParams.WRAP_CONTENT, RadioGroup.LayoutParams.WRAP_CONTENT);
            //??????RadioButton?????? (int left, int top, int right, int bottom)
            lp.setMargins(15,0,0,0);
            //??????RadioButton??????
            //radioButton.setBackgroundResource(R.drawable.xx);
            //??????RadioButton?????????
//            radioButton.setButtonDrawable(R.drawable.radio_bg);
            //?????????????????????????????????
            radioButton.setPadding(5, 0, 0, 0);
            //????????????
            radioButton.setText(Items.get(i).getName());
            final int finalI = i;
            //??????radioButton???????????????
            radioButton.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    takeWay = Items.get(finalI).getCode();
                    txtexpressNo.setText("");
                    if(takeWay.equals("SELF_TAKE")){
                        txtexpressNo.setEnabled(false);
                        iv_icon.setEnabled(false);
                    } else {
                        txtexpressNo.setEnabled(true);
                        iv_icon.setEnabled(true);
                    }

                }
            });
//            if(Items.get(i).getCode().equals("MAIL")){
//                radioButton.setChecked(true);
//            }
            mRadioGroup.addView(radioButton);
        }
        iv_icon.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                new IntentIntegrator(ResultsRegisterDetailActivity.this)
                        .setDesiredBarcodeFormats(IntentIntegrator.ALL_CODE_TYPES)// ???????????????,????????????????????????????????????/?????????
                        //.setPrompt("??????????????????")// ???????????????
                        .setCameraId(0)// ???????????????,???????????????????????????
                        .setBeepEnabled(true)// ??????????????????,??????????????????"???"?????????
                        .setCaptureActivity(QrCodeActivity.class)//?????????????????????
                        .initiateScan();// ???????????????

            }
        });
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        //????????????
        IntentResult intentResult = IntentIntegrator.parseActivityResult(requestCode, resultCode, data);
        if (intentResult != null) {
            if (intentResult.getContents() == null) {
                //????????????
            } else {
                String result = intentResult.getContents();//?????????
                txtexpressNo.setText(result);
            }
        }
    }
    //????????????????????????
    @OnClick({R.id.btn_one,R.id.btn_two})
    public void submit(View v) {
        if(v.getId() == R.id.btn_one){
            finish();

        } else {
            if(takeWay.equals("")){
                ToastUtil.show(getBaseContext(), "???????????????????????????");
                return;
            } else if(takeWay.equals("SELF_TAKE")){
                Map<String, String> params = new HashMap<>();
                params.put("takeWay",takeWay);
                WaitDialog.show(ResultsRegisterDetailActivity.this, "????????????...");
                userRepository.postEntrustInspect(model.getId(),"REGISTER",params).observe(ResultsRegisterDetailActivity.this, new Observer<BaseDto<EntrustInspectModel.ContentBean>>() {
                    @Override
                    public void onChanged(BaseDto<EntrustInspectModel.ContentBean> stringBaseDto) {

                        if(stringBaseDto.getCode().equals(Constant.RespCode.R200)){
                            TipDialog.show(ResultsRegisterDetailActivity.this, "?????????", TipDialog.TYPE.SUCCESS).setOnDismissListener(new OnDismissListener() {
                                @Override
                                public void onDismiss() {
                                    onBack();
                                }
                            });

                        } else {
                            TipDialog.show(ResultsRegisterDetailActivity.this, stringBaseDto.getMessage(), TipDialog.TYPE.WARNING);
                        }

                    }
                });
            } else {
                if(txtexpressNo.getText().toString().equals("")){
                    ToastUtil.show(getBaseContext(), "?????????????????????");
                    return;
                }
                Map<String, String> params = new HashMap<>();
                params.put("sn",txtexpressNo.getText().toString());
                WaitDialog.show(ResultsRegisterDetailActivity.this, "????????????...");
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
                                            TipDialog.show(ResultsRegisterDetailActivity.this, "?????????", TipDialog.TYPE.SUCCESS).setOnDismissListener(new OnDismissListener() {
                                                @Override
                                                public void onDismiss() {
                                                    onBack();
                                                }
                                            });

                                        } else {
                                            TipDialog.show(ResultsRegisterDetailActivity.this, stringBaseDto.getMessage(), TipDialog.TYPE.WARNING);
                                        }

                                    }
                                });
                            } else {
                                TipDialog.show(ResultsRegisterDetailActivity.this, "?????????????????????", TipDialog.TYPE.WARNING);
                            }
                        } else {
                            ToastUtil.show(getBaseContext(), booleanBaseDto.getMessage());
                        }
                    }
                });
            }
        }
    }

    private void onBack() {
        Intent intent2 = new Intent("android.intent.action.CART_BROADCAST");
        intent2.putExtra("data","refresh");
        LocalBroadcastManager.getInstance(ResultsRegisterDetailActivity.this).sendBroadcast(intent2);
        sendBroadcast(intent2);
        finish();
    }
    protected void onDestroy() {
        super.onDestroy();
    }
}