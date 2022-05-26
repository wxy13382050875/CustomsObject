package com.technology.center.view.user;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.text.Spannable;
import android.text.SpannableStringBuilder;
import android.text.TextUtils;
import android.text.method.LinkMovementMethod;
import android.text.style.ClickableSpan;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.view.animation.Animation;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.lifecycle.Observer;

import com.kongzue.dialog.interfaces.OnDismissListener;
import com.kongzue.dialog.v3.TipDialog;
import com.kongzue.dialog.v3.WaitDialog;
import com.technology.center.Constant;
import com.technology.center.http.base.BaseDto;
import com.technology.center.model.CurrentUserModel;
import com.technology.center.repository.impl.UserRepository;
import com.technology.center.utils.SpUtils;
import com.technology.center.utils.ToastUtil;
import com.technology.center.view.base.BaseActionBarActivity;
import com.wuhenzhizao.titlebar.widget.CommonTitleBar;

import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.technology.center.R;
import cxy.com.validate.IValidateResult;
import cxy.com.validate.Validate;
import cxy.com.validate.annotation.Index;
import cxy.com.validate.annotation.MinLength;
import cxy.com.validate.annotation.RE;
import cxy.com.validate.annotation.NotNull;
/**
 * 注册
 */
public class RegisterActivity extends BaseActionBarActivity {
    private final static String TAG = "RegisterActivity";
    //按钮
    private Button registerBtn;
    private Button sendCodeBtn;
    private Context context;
    private Activity activity;
    private SpUtils spUtils;
    //用户隐私条款和协议
    private CheckBox checkBox;
    private TextView tvPrivacy;

    private final UserRepository userRepository = new UserRepository();


    //手机号
    @Index(2)
    @NotNull(msg = "手机号不能为空")
    @MinLength(length = 11, msg = "请输入正确的手机号")
    private EditText txtRegPhone;


//    //验证码
//    @Index(4)
//    @NotNull(msg = "验证码不能为空")
//    @MinLength(length = 6, msg = "验证码格式不正确")
//    private EditText txtRegVerifyCode;

    //密码
    @Index(5)
    @NotNull(msg = "密码不能为空")
    @MinLength(length = 7, msg = "最少为7位到18位密码")
    @RE(re = "^(?![\\d]+$)(?![a-zA-Z]+$)(?![^\\da-zA-Z]+$).{7,18}$", msg = "密码至少包含字母、数字、符号两种类型(7-18位)")
    private EditText txtRegPwd;

    @Override
    protected int getLayoutId() {
        return R.layout.activity_register;
    }

    @Override
    protected void onViewCreated() {
        spUtils = new SpUtils(getBaseContext());
        context = getBaseContext();
        initView();
        initData();
        Validate.reg(this);
    }

    @Override
    protected void initEventAndData() {

    }


    //初始化控件
    private void initView() {

        registerBtn = findViewById(R.id.register_btn);
//        sendCodeBtn = findViewById(R.id.send_code_btn);
        txtRegPhone = findViewById(R.id.txt_reg_phone);
//        txtRegVerifyCode = findViewById(R.id.edit_register_verify);
        txtRegPwd = findViewById(R.id.txt_reg_password);

        checkBox = findViewById(R.id.checkBox);
        tvPrivacy = findViewById(R.id.tv_privacy);
        commonTitleBar.setBackgroundResource(R.drawable.top_bg_shape);
        //给注册按钮绑定事件
        registerBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                submit();
            }
        });

//        //发送验证码
//        sendCodeBtn.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                sendCode();
//            }
//        });
    }



    //提交注册
    private void submitRegister() {
        if(!checkBox.isChecked()){
            // 请同意隐私政策和服务协议
            Toast.makeText(RegisterActivity.this, getString(R.string.string_toast_privacy_service), Toast.LENGTH_LONG).show();
            return;
        }
        String phone = txtRegPhone.getText().toString();
        String password = txtRegPwd.getText().toString();
//        String smsCode = txtRegVerifyCode.getText().toString();

        Map<String, Object> params = new HashMap<>();

        params.put("appId", "1");
        params.put("password", password);
        params.put("username", phone);
        params.put("phone", phone);
        params.put("type", "MANAGE");
        List<String>  roleIds = new ArrayList<>();
        roleIds.add("134");

        params.put("roleIds",roleIds);
        WaitDialog.show(RegisterActivity.this, "正在注册...");
        userRepository.register(params).observe(RegisterActivity.this, new Observer<BaseDto<CurrentUserModel>>() {
            @Override
            public void onChanged(BaseDto<CurrentUserModel> stringBaseDto) {
                if (stringBaseDto.getCode().equals(Constant.RespCode.R200)) {
                    TipDialog.show(RegisterActivity.this, "注册成功", TipDialog.TYPE.SUCCESS).setOnDismissListener(new OnDismissListener() {
                        @Override
                        public void onDismiss() {
                            finish();
                        }
                    });

                } else {

                    TipDialog.show(RegisterActivity.this, stringBaseDto.getMessage(), TipDialog.TYPE.WARNING);
                }
            }
        });
    }

    //处理点击注册事件
    private void submit() {
        Validate.check(this, new IValidateResult() {
            @Override
            public void onValidateSuccess() {
                submitRegister();
            }

            @Override
            public void onValidateError(String msg, View view) {
                ToastUtil.show(context, msg);
            }

            @Override
            public Animation onValidateErrorAnno() {
                return null;
            }
        });
    }
    private void initData() {
//        我同意本DEMO的隐私政策和服务协议
        SpannableStringBuilder builder=new SpannableStringBuilder(getString(R.string.string_privacy));
        ClickableSpan clickSpanPrivacy=new ClickableSpan() {
            @Override
            public void onClick( View widget) {
//                跳转隐私政策网址
//                Toast.makeText(RegisterActivity.this, getString(R.string.string_toast_to_privacy), Toast.LENGTH_SHORT).show();
                skipWebView("2","onAuth");
            }
        };
        builder.setSpan(clickSpanPrivacy,11,15, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
        ClickableSpan clickableSpanProtocol=new ClickableSpan() {
            @Override
            public void onClick( View widget) {
//                跳转服务协议
//                Toast.makeText(RegisterActivity.this, getString(R.string.string_toast_to_service), Toast.LENGTH_SHORT).show();
                skipWebView("7","onAuth");
            }
        };

        builder.setSpan(clickableSpanProtocol,16,20,Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
        tvPrivacy.setText(builder);
        tvPrivacy.setMovementMethod(LinkMovementMethod.getInstance());//调用此方法时文字点击事件才有效
    }

//    /**
//     * 发送验证码
//     */
//    private void sendCode() {
//        Toast toast = Toast.makeText(getBaseContext(), "", Toast.LENGTH_LONG);
//        toast.setGravity(Gravity.CENTER, 0, 0);
//        //String telRegex = "^((13[0-9])|(14[5,7,9])|(15[^4])|(18[0-9])|(17[0,1,3,5,6,7,8]))\\d{8}$";
//        String telRegex = "^(1\\d{10})$";
//        String phone = txtRegPhone.getText().toString();
//        if (!TextUtils.isEmpty(phone)) {
//
//            if (txtRegPhone.getText().toString().matches(telRegex)) {
//                Map<String, String> params = new HashMap<>();
//                params.put("phone", phone);
////                userViewModel.sendSms(params).observe(RegisterActivity.this, new Observer<BaseDto<String>>() {
////                    @Override
////                    public void onChanged(BaseDto<String> stringBaseDto) {
////
////                        if (stringBaseDto.getCode().equals("200")) {
////                            ToastUtil.show(context, "发送成功");
////
////                            TimeCount time = new TimeCount(60000, 1000, sendCodeBtn);
////                            time.start();
////                            sendCodeBtn.setAlpha(.4f);
////
////                        } else {
////                            ToastUtil.show(context, "验证码发送失败");
////                        }
////                    }
////                });
//            } else {
//                toast.setText("手机号格式不正确");
//                toast.show();
//            }
//
//        } else {
//            toast.setText("手机号不能为空");
//            toast.show();
//        }
//
//    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        Validate.unreg(this);
//        if (dialog != null) {
//            dialog.dismiss();
//        }
    }
    private void loginClick(){

//        dialog.show();
//        LoginVo loginVo = new LoginVo();
//        loginVo.setPassword(txtRegPwd.getText().toString());
//        loginVo.setPhone(txtRegPhone.getText().toString());
//
//        loginViewModel.login(loginVo).observe(RegisterActivity.this, new Observer<BaseDto<LoginDto>>() {
//            @Override
//            public void onChanged(BaseDto<LoginDto> res) {
//                dialog.hide();
//                if (res.getCode().equals("200")) {
//                    List list = (List) GsonUtil.fromJson(RegisterActivity.this.spUtils.getString("accountList"), List.class);
//                    if (list == null || list.size() == 0) {
//                        list = new ArrayList();
//                        list.add(loginVo);
//                    } else {
//                        boolean z = false;
//                        for (int i = 0; i < list.size(); i++) {
//                            String str2 = RegisterActivity.TAG;
//                            try {
//                                StringBuilder sb = new StringBuilder();
//                                sb.append("showListPopupWindow: ");
//                                sb.append(list.get(i));
//                                Log.d(str2, sb.toString());
//                                if (new JSONObject(GsonUtil.toJson(list.get(i))).getString("phone").equals(loginVo.getPhone())) {
//                                    z = true;
//                                }
//                            } catch (Exception e) {
//                                e.printStackTrace();
//                            }
//                        }
//                        if (!z) {
//                            list.add(loginVo);
//                        }
//                    }
//                    spUtils.putString("accountList", GsonUtil.toJson(list));
//
//                    //保存数据
//                    spUtils.putBoolean("loginStatus", true);
//                    //保存用户信息
//                    spUtils.putString("userInfo", GsonUtil.toJson(res.getData()));
//                    //保存token
//                    spUtils.putString("TOKEN", res.getData().getToken());
//                    Map<String, String> params = new HashMap<>();
//                    params.put("deviceToken", App.mDeviceToken);
//                    loginViewModel.bindDeviceToken(params).observe(RegisterActivity.this, new Observer<BaseDto<String>>() {
//                        @Override
//                        public void onChanged(BaseDto<String> res) {
//                            Log.d("-----", res.getMsg());
//                            Intent intent = new Intent(RegisterActivity.this, MainActivity.class);
//                            startActivity(intent);
//                            finish();
//
//                        }
//                    });
//                } else {
//                    Toast.makeText(RegisterActivity.this, res.getMsg(), Toast.LENGTH_LONG).show();
//                }
//            }
//        });
    }
    private void skipWebView(String webId, String type) {
        Intent intent = new Intent(getBaseContext(), WebViewActivity.class);
        //用Bundle携带数据
        Bundle bundle = new Bundle();
        //传递name参数为tinyphp
        bundle.putString("id", webId);
        bundle.putString("type", type);
        intent.putExtras(bundle);
        startActivity(intent);
    }
}
