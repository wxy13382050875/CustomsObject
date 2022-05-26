package com.technology.center.view.user;

import android.content.Intent;
import android.text.TextUtils;
import android.view.Gravity;
import android.view.View;
import android.view.animation.Animation;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.technology.center.utils.ToastUtil;
import com.technology.center.view.base.BaseActionBarActivity;
import com.wuhenzhizao.titlebar.widget.CommonTitleBar;

import java.util.HashMap;
import java.util.Map;

import com.technology.center.R;
import cxy.com.validate.IValidateResult;
import cxy.com.validate.Validate;
import cxy.com.validate.annotation.Index;
import cxy.com.validate.annotation.MinLength;
import cxy.com.validate.annotation.NotNull;
import cxy.com.validate.annotation.RE;

/**
 * 忘记密码
 */
public class ForgetPwdActivity extends BaseActionBarActivity {

    @Index(1)
    @NotNull(msg = "手机号不能为空")
    @MinLength(length = 11, msg = "请输入正确的手机号")
    private TextView txtPhone;
    @Index(2)
    @NotNull(msg = "验证码不能为空")
    @MinLength(length = 6, msg = "验证码格式不正确")
    private TextView txtVerify;

    @Index(3)
    @NotNull(msg = "密码不能为空")
    @MinLength(length = 7, msg = "最少为7位到18位密码")
    @RE(re = "^(?![\\d]+$)(?![a-zA-Z]+$)(?![^\\da-zA-Z]+$).{7,18}$", msg = "密码至少包含字母、数字、符号两种类型(7-18位)")
    private TextView txtPassword;

    private Button btnReset;
    private Button sendCodeBtn;


    @Override
    protected int getLayoutId() {
        return R.layout.activity_forget_pwd;
    }

    @Override
    protected void onViewCreated() {
        Intent intent = getIntent();
        String type = intent.getStringExtra("type");
        if (type != null) {
            CommonTitleBar commonTitleBar = findViewById(R.id.titlebar);
            commonTitleBar.getCenterTextView().setText("修改密码");
            TextView forgetText = findViewById(R.id.forget_title);
            forgetText.setText("修改密码");
        }

        txtPhone = findViewById(R.id.txt_phone);
        txtPassword = findViewById(R.id.txt_password);
        txtVerify = findViewById(R.id.txt_verify);
        btnReset = findViewById(R.id.btnReset);
        sendCodeBtn = findViewById(R.id.send_code_btn);

        Validate.reg(this);


    }

    @Override
    protected void initEventAndData() {
        btnReset.setOnClickListener(view -> {
            submit();
        });

        //发送验证码
        sendCodeBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                sendCode();
            }
        });
    }


    //处理点击注册事件
    private void submit() {
        Validate.check(this, new IValidateResult() {
            @Override
            public void onValidateSuccess() {
                resetPasswordSubmit();
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

    private void resetPasswordSubmit() {
        Map<String, String> params = new HashMap<>();
        params.put("phone", txtPhone.getText().toString());
        params.put("password", txtPassword.getText().toString());
//        Log.d("234567", MD5Utils.digest(password));
//        if (txtPhone.getText().toString().equals("18313944725")) {
//            params.put("password", MD5Utils.digest(txtPassword.getText().toString()));
//        } else {
//            params.put("password", txtPassword.getText().toString());
//        }
        params.put("password", txtPassword.getText().toString());
        params.put("smsCode", txtVerify.getText().toString());

//        dialog.show();
//        userViewModel.resetPassword(params).observe(ForgetPwdActivity.this, new Observer<BaseDto<String>>() {
//            @Override
//            public void onChanged(BaseDto<String> rs) {
//                dialog.hide();
//                if (rs.getCode().equals(Constant.RespCode.R200)) {
//                    ToastUtil.show(getBaseContext(), "密码重置成功");
//                    finish();
//                } else {
//                    switch (rs.getCode()) {
//                        case "1002":
//                            ToastUtil.show(getBaseContext(), "验证码错误");
//                            break;
//
//                        case "1006":
//                            ToastUtil.show(getBaseContext(), "帐号未注册，请注册");
//                            break;
//                        default:
//                            ToastUtil.show(getBaseContext(), rs.getMsg());
//                            break;
//                    }
//
//                }
//            }
//        });
    }

    /**
     * 发送验证码
     */
    private void sendCode() {
        Toast toast = Toast.makeText(getBaseContext(), "", Toast.LENGTH_LONG);
        toast.setGravity(Gravity.CENTER, 0, 0);
        //String telRegex = "^((13[0-9])|(14[5,7,9])|(15[^4])|(18[0-9])|(17[0,1,3,5,6,7,8]))\\d{8}$";
        String telRegex = "^(1\\d{10})$";
        String phone = txtPhone.getText().toString();
        if (!TextUtils.isEmpty(phone)) {

            if (txtPhone.getText().toString().matches(telRegex)) {
                Map<String, String> params = new HashMap<>();
                params.put("phone", phone);
//                userViewModel.sendSms(params).observe(ForgetPwdActivity.this, new Observer<BaseDto<String>>() {
//                    @Override
//                    public void onChanged(BaseDto<String> stringBaseDto) {
//
//                        if (stringBaseDto.getCode().equals("200")) {
//                            ToastUtil.show(getBaseContext(), "发送成功");
//
//                            TimeCount time = new TimeCount(60000, 1000, sendCodeBtn);
//                            time.start();
//                            sendCodeBtn.setAlpha(.4f);
//
//                        } else {
//                            ToastUtil.show(getBaseContext(), "验证码发送失败");
//                        }
//                    }
//                });
            } else {
                toast.setText("手机号格式不正确");
                toast.show();
            }

        } else {
            toast.setText("手机号不能为空");
            toast.show();
        }

    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        Validate.unreg(this);
//        if (dialog != null) {
//            dialog.dismiss();
//        }
    }
}
