package com.technology.center.view.custom;


import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.View;
import android.view.animation.Animation;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.LinearLayout;

import androidx.lifecycle.Observer;

import com.google.zxing.integration.android.IntentIntegrator;
import com.google.zxing.integration.android.IntentResult;
import com.technology.center.R;
import com.technology.center.http.base.BaseDto;
import com.technology.center.model.EntrustInspectModel;
import com.technology.center.repository.impl.UserRepository;
import com.technology.center.utils.MyDictUtils;
import com.technology.center.utils.SpUtils;
import com.technology.center.utils.ToastUtil;
import com.technology.center.utils.Utils;
import com.technology.center.view.base.BaseActionBarActivity;
import com.technology.center.view.qr.QrCodeActivity;

import java.util.HashMap;
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
import com.technology.center.Constant;

public class CertificateQueryActivity extends BaseActionBarActivity {


    private static final String TAG = "CertificateQueryActivity";
    private final UserRepository userRepository = new UserRepository();
    @BindView(R.id.tv_sn)
    TextView tv_sn;

    @BindView(R.id.tv_entrustOrg)
    TextView tv_entrustOrg;

    @BindView(R.id.tv_inspectOrg)
    TextView tv_inspectOrg;

    @BindView(R.id.tv_registerTime)
    TextView tv_registerTime;

    @BindView(R.id.tv_createTime)
    TextView tv_createTime;

    @BindView(R.id.iv_icon)
    ImageView iv_icon;

    @BindView(R.id.txt_search)
    EditText txt_search;
    @Override
    protected int getLayoutId() {
        return R.layout.activity_certificate_query;
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
            EntrustInspectModel.ContentBean model = (EntrustInspectModel.ContentBean) bundle.getSerializable("model");

            MyDictUtils myUtils = new MyDictUtils(getBaseContext());
            tv_sn.setText("????????????:" +model.getSn());
            tv_entrustOrg.setText("????????????:" +model.getEntrustOrg().getName());
            tv_inspectOrg.setText("????????????:" + myUtils.getSingleOrgsNameById(model.getInspectOrgId()));
            tv_registerTime.setText("????????????:" +model.getRegisterTime());
            tv_createTime.setText( model.getCreateTime());

            LinearLayout scanLinearLayout= findViewById(R.id.lv_certificate_scan);
            scanLinearLayout.setVisibility(View.GONE);

        }

        iv_icon.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                new IntentIntegrator(CertificateQueryActivity.this)
                        .setDesiredBarcodeFormats(IntentIntegrator.ALL_CODE_TYPES)// ???????????????,????????????????????????????????????/?????????
                        //.setPrompt("??????????????????")// ???????????????
                        .setCameraId(0)// ???????????????,???????????????????????????
                        .setBeepEnabled(true)// ??????????????????,??????????????????"???"?????????
                        .setCaptureActivity(QrCodeActivity.class)//?????????????????????
                        .initiateScan();// ???????????????

            }
        });
        txt_search.setOnEditorActionListener(new TextView.OnEditorActionListener() {
            @Override
            public boolean onEditorAction(TextView v, int actionId, KeyEvent event) {
                if (actionId == EditorInfo.IME_ACTION_SEARCH) {
                    //???????????????
//                    YUtils.closeSoftKeyboard();
                    closeKeyboard();
                    getCert(txt_search.getText().toString());
                    return true;
                }
                return false;
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
//                ToastUtil.show(getBaseContext(), result);
                getCert(result);
            }
        }
    }


    private void getCert(String qrCodeContent){

        Map<String, String> params = new HashMap<>();
        params.put("qrCodeContent", qrCodeContent);
        userRepository.getCertByQrCode(params).observe(CertificateQueryActivity.this, new Observer<BaseDto<EntrustInspectModel.ContentBean>>() {
            @Override
            public void onChanged(BaseDto<EntrustInspectModel.ContentBean> contentBeanBaseDto) {

                if (contentBeanBaseDto.getCode().equals(Constant.RespCode.R200)) {
                    EntrustInspectModel.ContentBean dto = contentBeanBaseDto.getData();
                    if(dto != null){
                        MyDictUtils myUtils = new MyDictUtils(getBaseContext());
                        tv_sn.setText("????????????:" +dto.getSn());
                        tv_entrustOrg.setText("????????????:" +dto.getEntrustOrgName());
                        tv_inspectOrg.setText("????????????:" + myUtils.getSingleOrgsNameById(dto.getInspectOrgId()));
                        tv_registerTime.setText("????????????:" +dto.getRegisterTime());
                        tv_createTime.setText( dto.getCreateTime());
                    } else {
                        ToastUtil.show(getBaseContext(), "???????????????????????????");
                    }

                } else {
                    ToastUtil.show(getBaseContext(), contentBeanBaseDto.getMessage());
                }

            }
        });
    }
    /*
    ????????????????????????
     */
    private void closeKeyboard() {
        View view =  getWindow().peekDecorView();
        if (view != null) {
            InputMethodManager inputMethodManager = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
            inputMethodManager.hideSoftInputFromWindow(view.getWindowToken(), 0);
        }
    }
}