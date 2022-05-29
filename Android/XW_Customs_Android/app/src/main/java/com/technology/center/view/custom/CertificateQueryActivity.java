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
    //初始化控件
    private void initView() {
        ButterKnife.bind(this);
        Bundle bundle = this.getIntent().getExtras();
        if (bundle != null) {
            // 从bundle数据包中取出数据
            EntrustInspectModel.ContentBean model = (EntrustInspectModel.ContentBean) bundle.getSerializable("model");

            MyDictUtils myUtils = new MyDictUtils(getBaseContext());
            tv_sn.setText("检验编号:" +model.getSn());
            tv_entrustOrg.setText("报检单位:" +model.getEntrustOrg().getName());
            tv_inspectOrg.setText("检测机构:" + myUtils.getSingleOrgsNameById(model.getInspectOrgId()));
            tv_registerTime.setText("检验时间:" +model.getRegisterTime());
            tv_createTime.setText( model.getCreateTime());

            LinearLayout scanLinearLayout= findViewById(R.id.lv_certificate_scan);
            scanLinearLayout.setVisibility(View.GONE);

        }

        iv_icon.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                new IntentIntegrator(CertificateQueryActivity.this)
                        .setDesiredBarcodeFormats(IntentIntegrator.ALL_CODE_TYPES)// 扫码的类型,可选：一维码，二维码，一/二维码
                        //.setPrompt("请对准二维码")// 设置提示语
                        .setCameraId(0)// 选择摄像头,可使用前置或者后置
                        .setBeepEnabled(true)// 是否开启声音,扫完码之后会"哔"的一声
                        .setCaptureActivity(QrCodeActivity.class)//自定义扫码界面
                        .initiateScan();// 初始化扫码

            }
        });
        txt_search.setOnEditorActionListener(new TextView.OnEditorActionListener() {
            @Override
            public boolean onEditorAction(TextView v, int actionId, KeyEvent event) {
                if (actionId == EditorInfo.IME_ACTION_SEARCH) {
                    //关闭软键盘
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
        //扫码结果
        IntentResult intentResult = IntentIntegrator.parseActivityResult(requestCode, resultCode, data);
        if (intentResult != null) {
            if (intentResult.getContents() == null) {
                //扫码失败
            } else {
                String result = intentResult.getContents();//返回值
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
                        tv_sn.setText("检验编号:" +dto.getSn());
                        tv_entrustOrg.setText("报检单位:" +dto.getEntrustOrgName());
                        tv_inspectOrg.setText("检测机构:" + myUtils.getSingleOrgsNameById(dto.getInspectOrgId()));
                        tv_registerTime.setText("检验时间:" +dto.getRegisterTime());
                        tv_createTime.setText( dto.getCreateTime());
                    } else {
                        ToastUtil.show(getBaseContext(), "未查到相关检测证书");
                    }

                } else {
                    ToastUtil.show(getBaseContext(), contentBeanBaseDto.getMessage());
                }

            }
        });
    }
    /*
    软键盘自动和关闭
     */
    private void closeKeyboard() {
        View view =  getWindow().peekDecorView();
        if (view != null) {
            InputMethodManager inputMethodManager = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
            inputMethodManager.hideSoftInputFromWindow(view.getWindowToken(), 0);
        }
    }
}