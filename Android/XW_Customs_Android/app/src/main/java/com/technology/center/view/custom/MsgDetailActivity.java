package com.technology.center.view.custom;

import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import com.kongzue.dialog.v3.WaitDialog;
import androidx.lifecycle.Observer;

import com.google.zxing.integration.android.IntentIntegrator;
import com.technology.center.http.base.BaseDto;
import com.technology.center.model.EntrustInspectModel;
import com.technology.center.model.MsgModel;
import com.technology.center.repository.impl.UserRepository;
import com.technology.center.utils.MyDictUtils;
import com.technology.center.utils.SpUtils;
import com.technology.center.utils.ToastUtil;
import com.technology.center.view.base.BaseActionBarActivity;
import com.technology.center.view.qr.QrCodeActivity;
import com.wuhenzhizao.titlebar.widget.CommonTitleBar;

import com.technology.center.R;
import com.technology.center.Constant;
import butterknife.BindView;
import butterknife.ButterKnife;
import cxy.com.validate.Validate;

public class MsgDetailActivity extends BaseActionBarActivity {
    private static final String TAG = "CertificateQueryActivity";
    private final UserRepository userRepository = new UserRepository();

    private String msgId;

    @BindView(R.id.tv_msg_title)
    TextView titleText;

    @BindView(R.id.tv_msg_content)
    TextView contentText;

    @BindView(R.id.tv_msg_time)
    TextView timeText;



    @Override
    protected int getLayoutId() {
        return R.layout.activity_msg_detail;
    }

    @Override
    protected void onViewCreated() {
        initView();
        Validate.reg(this);
    }

    @Override
    protected void initEventAndData() {
        getData();
    }
    //初始化控件
    private void initView() {
        ButterKnife.bind(this);
        Bundle bundle = this.getIntent().getExtras();
        if (bundle != null) {
            // 从bundle数据包中取出数据
            msgId = bundle.getString("msgId");


        }
    }
    private void getData(){
//        WaitDialog.show(MsgDetailActivity.this, "正在接交...");
        userRepository.postMsgDetailClick(msgId).observe(MsgDetailActivity.this, new Observer<BaseDto<MsgModel.ContentBean>>() {
            @Override
            public void onChanged(BaseDto<MsgModel.ContentBean> contentBeanBaseDto) {

                if (contentBeanBaseDto.getCode().equals(Constant.RespCode.R200)) {

                    titleText.setText(contentBeanBaseDto.getData().getTitle());
                    contentText.setText(contentBeanBaseDto.getData().getContent());
                    timeText.setText(contentBeanBaseDto.getData().getCreateTime());
                } else {
                    ToastUtil.show(getBaseContext(), contentBeanBaseDto.getMessage());
                }

            }
        });
    }
    protected void onDestroy() {
        super.onDestroy();

    }
}
