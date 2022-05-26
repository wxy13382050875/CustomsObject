package com.technology.center.view.user;


import com.technology.center.R;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Handler;
import android.view.View;
import android.view.animation.Animation;
import android.widget.Button;
import android.widget.TextView;

import androidx.lifecycle.Observer;

import com.technology.center.utils.ToastUtil;
import com.technology.center.view.base.BaseActionBarActivity;

import java.util.HashMap;
import java.util.Map;

import cxy.com.validate.IValidateResult;
import cxy.com.validate.Validate;
import cxy.com.validate.annotation.Index;
import cxy.com.validate.annotation.MinLength;
import cxy.com.validate.annotation.NotNull;

public class LogoffActivity extends BaseActionBarActivity {
    @Index(1)
    @NotNull(msg = "验证码不能为空")
    @MinLength(length = 6, msg = "验证码格式不正确")
    private TextView txtVerify;

    //确认注销
    private Button btnConfirm;
    //发送验证码
    private Button btnSendCode;


    private AlertDialog.Builder dialog;

    @Override
    protected int getLayoutId() {
        return R.layout.activity_logoff;
    }

    @Override
    protected void onViewCreated() {
        initUI();
        Validate.reg(LogoffActivity.this);
    }

    @Override
    protected void initEventAndData() {

        dialog = new AlertDialog.Builder(this);

        dialog.setTitle("注销提示");//设置对话框的标题
        dialog.setMessage("是否确认注销？注销后将无法登录");//设置对话框的内容
        dialog.setCancelable(false);//设置对话框是否可以取消
        dialog.setPositiveButton("确认注销", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                submitLogoff();

            }
        });
        dialog.setNegativeButton("取消", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
            }

        });
    }

    private void initUI() {
        txtVerify = findViewById(R.id.txt_verify);
        btnConfirm = findViewById(R.id.btnConfirm);
        btnSendCode = findViewById(R.id.send_code_btn);

        //发送验证码
        btnSendCode.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                sendSms();
            }
        });

        //确认注销
        btnConfirm.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Validate.check(LogoffActivity.this, new IValidateResult() {
                    @Override
                    public void onValidateSuccess() {
                        dialog.show();
                    }
                    @Override
                    public void onValidateError(String msg, View view) {
                        ToastUtil.show(LogoffActivity.this, msg);
                    }

                    @Override
                    public Animation onValidateErrorAnno() {
                        return null;
                    }
                });
            }
        });
    }

    private void sendSms() {
//        userViewModel.sendLogoffSms().observe(LogoffActivity.this, new Observer<BaseDto<String>>() {
//            @Override
//            public void onChanged(BaseDto<String> stringBaseDto) {
//
//                if (stringBaseDto.getCode().equals("200")) {
//                    ToastUtil.show(getBaseContext(), "发送成功");
//
//                    TimeCount time = new TimeCount(60000, 1000, btnSendCode);
//                    time.start();
//                    btnSendCode.setAlpha(.4f);
//
//                } else {
//                    ToastUtil.show(getBaseContext(), "验证码发送失败");
//                }
//            }
//        });
    }

    //确认注销
    private void submitLogoff() {
        Map<String, String> params = new HashMap<>();
        params.put("verifyCode", txtVerify.getText().toString());
//        userViewModel.submitLogoff(params).observe(LogoffActivity.this, new Observer<BaseDto<String>>() {
//            @Override
//            public void onChanged(BaseDto<String> rs) {
//                if (rs.getCode().equals(("1002"))) {
//                    ToastUtil.show(getBaseContext(), rs.getMsg());
//                }
//                if (rs.getCode().equals(Constant.RespCode.R200)) {
//                    ToastUtil.show(getBaseContext(), "注销成功");
//                    new Handler().postDelayed(new Runnable() {
//                        public void run() {
                            Intent intent = new Intent("com.technology.center.loginout");
                            getBaseContext().sendBroadcast(intent);
//                        }
//                    }, 3000);
//                } else {
//                    ToastUtil.show(getBaseContext(), rs.getMsg());
//                }
//            }
//        });

    }

//    @Override
//    protected void onDestroy() {
//        super.onDestroy();
//        Validate.unreg(this);
//    }
}