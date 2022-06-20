package com.technology.center.view.user;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.text.Spannable;
import android.text.SpannableStringBuilder;
import android.text.method.LinkMovementMethod;
import android.text.style.ClickableSpan;
import android.util.Log;
import android.view.View;
import android.view.animation.Animation;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.widget.ListPopupWindow;
import androidx.lifecycle.Observer;

import com.kongzue.dialog.interfaces.OnDismissListener;
import com.kongzue.dialog.v3.TipDialog;
import com.kongzue.dialog.v3.WaitDialog;
import com.technology.center.Constant;
import com.technology.center.R;

import com.technology.center.adapter.ListPopupWindowAdapter;
import com.technology.center.http.RequestRetrofit;
import com.technology.center.http.base.BaseDto;
import com.technology.center.model.CanSelectOrgsModel;
import com.technology.center.model.CurrentUserModel;
import com.technology.center.model.DictAllModel;
import com.technology.center.model.EntrustOrgModel;
import com.technology.center.model.LoginVoModel;
import com.technology.center.utils.SpUtils;
import com.technology.center.utils.ToastUtil;
import com.technology.center.view.MainActivity;
import com.technology.center.view.base.BaseActionBarActivity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cxy.com.validate.IValidateResult;
import cxy.com.validate.Validate;
import cxy.com.validate.annotation.Index;
import cxy.com.validate.annotation.MinLength;
import cxy.com.validate.annotation.NotNull;
import cxy.com.validate.annotation.RE;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import com.technology.center.repository.impl.UserRepository;

import com.technology.center.utils.GsonUtil;
import com.technology.center.view.custom.DelegateApplyActivity;
import com.technology.center.view.custom.SamplingRecordDetailActivity;

import org.json.JSONObject;

/**
 * 登录activity
 */
public class LoginActivity extends BaseActionBarActivity {
    private static final String TAG = "LoginActivity";

    private final UserRepository userRepository = new UserRepository();
    private Button loginBtn;
    private TextView registerTextView;

    private TextView forgetTextView;

    private LinearLayout lv_phone;

    private Context context;
    private Activity activity;
    private SpUtils spUtils;
    //用户隐私条款和协议
    private CheckBox checkBox;
    private TextView tvPrivacy;


    private LinearLayout lv_showAccount;

    //手机号
    @Index(2)
//    @NotNull(msg = "手机号不能为空")
//    @MinLength(length = 11, msg = "请输入正确的手机号")
    private EditText txtRegPhone;

    //密码
    @Index(5)
    @NotNull(msg = "密码不能为空")
//    @MinLength(length = 6, msg = "最少为6位到18位密码")
//    @RE(re = "^(?![\\d]+$)(?![a-zA-Z]+$)(?![^\\da-zA-Z]+$).{7,18}$", msg = "密码至少包含字母、数字、符号两种类型(7-18位)")
    private EditText txtRegPwd;
    @Override
    protected int getLayoutId() {
        return R.layout.activity_login;
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

    @Override
    protected void onStart() {
        super.onStart();
        spUtils.remove("TOKEN");
    }

    //初始化控件
    private void initView() {

        registerTextView = findViewById(R.id.tv_to_reg);
        loginBtn = findViewById(R.id.btnLogin);
        forgetTextView = findViewById(R.id.tv_to_forget);
        txtRegPhone = findViewById(R.id.txt_phone);
        txtRegPwd = findViewById(R.id.txt_password);
        lv_showAccount = findViewById(R.id.lv_showAccount);
        checkBox = findViewById(R.id.checkBox);
        tvPrivacy = findViewById(R.id.tv_privacy);

        lv_phone = findViewById(R.id.lv_phone);
        //给注册按钮绑定事件
        registerTextView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                Intent intent = new Intent(LoginActivity.this, RegisterActivity.class);
                startActivity(intent);
            }
        });

        //登陆
        loginBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                submit();
            }
        });

        //忘记密码
        forgetTextView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(LoginActivity.this, ForgetPwdActivity.class);
                intent.putExtra("type", "modify");
                startActivity(intent);
            }
        });
        lv_showAccount.setOnClickListener(view -> {
            showListPopupWindow(lv_phone);
        });
    }
    //提交注册
    private void loginClick() {
        if (!checkBox.isChecked()) {
            // 请同意隐私政策和服务协议
            Toast.makeText(LoginActivity.this, getString(R.string.string_toast_privacy_service), Toast.LENGTH_LONG).show();
            return;
        }
        Map<String, String> params = new HashMap<>();
        params.put("username", txtRegPhone.getText().toString());
        params.put("password", txtRegPwd.getText().toString());
        WaitDialog.show(LoginActivity.this, "正在登陆...");
        userRepository.login(params).observe(LoginActivity.this, new androidx.lifecycle.Observer<BaseDto<String>>() {

            @Override
            public void onChanged(BaseDto<String> res) {

                Log.d("-----", spUtils.getString("TOKEN"));
                if (res.getCode().equals(Constant.RespCode.R200)) {
                    spUtils.putString("TOKEN", res.getData());


                    userRepository.getCurrentUserInfo().observe(LoginActivity.this, new Observer<BaseDto<CurrentUserModel>>() {
                        @Override
                        public void onChanged(BaseDto<CurrentUserModel> currentUserModelBaseDto) {

                            Log.d("---listBaseDto--", spUtils.getString("userInfo"));
                            if (currentUserModelBaseDto.getCode().equals(Constant.RespCode.R200)) {
                                userRepository.GetDictAll().observe(LoginActivity.this, new Observer<BaseDto<List<DictAllModel>>>() {
                                    @Override
                                    public void onChanged(BaseDto<List<DictAllModel>> listBaseDto) {
                                        if (listBaseDto.getCode().equals(Constant.RespCode.R200)) {
                                            userRepository.getCanSelectOrgs(currentUserModelBaseDto.getData().getId()).observe(LoginActivity.this, new Observer<BaseDto<List<CanSelectOrgsModel>>>() {
                                                @Override
                                                public void onChanged(BaseDto<List<CanSelectOrgsModel>> canSelectOrgsModelBaseDto) {
                                                    if (canSelectOrgsModelBaseDto.getCode().equals(Constant.RespCode.R200)) {
                                                        CurrentUserModel currModel = currentUserModelBaseDto.getData();
                                                        if (currModel.getOrgs().size() == 0){
                                                            Map<String, String> params = new HashMap<>();
                                                            params.put("userId",currModel.getId());
                                                            userRepository.getEntrustOrgByUserId(params).observe(LoginActivity.this, new Observer<BaseDto<EntrustOrgModel>>() {
                                                                @Override
                                                                public void onChanged(BaseDto<EntrustOrgModel> entrustOrgModelBaseDto) {
                                                                    if (entrustOrgModelBaseDto.getCode().equals(Constant.RespCode.R200)) {

                                                                        TipDialog.show(LoginActivity.this, "登陆成功！", TipDialog.TYPE.SUCCESS).setOnDismissListener(new OnDismissListener() {
                                                                            @Override
                                                                            public void onDismiss() {
                                                                                spUtils.putString("entrustOrg", GsonUtil.toJson(entrustOrgModelBaseDto.getData()));
//                                                                        Log.d("TAG-------entrustOrg",);
                                                                                spUtils.putBoolean("loginStatus", true);
                                                                                spUtils.putString("userInfo", GsonUtil.toJson(currentUserModelBaseDto.getData()));
                                                                                spUtils.putString("dict", GsonUtil.toJson(listBaseDto.getData()));
                                                                                spUtils.putString("Orgs", GsonUtil.toJson(canSelectOrgsModelBaseDto.getData()));
                                                                                skipMainActivity();
                                                                            }
                                                                        });


                                                                    } else {
//                                                                        ToastUtil.show(LoginActivity.this, entrustOrgModelBaseDto.getMessage());
                                                                        TipDialog.show(LoginActivity.this, entrustOrgModelBaseDto.getMessage(), TipDialog.TYPE.WARNING);
                                                                    }

                                                                }
                                                            });
                                                        } else {
                                                            TipDialog.show(LoginActivity.this, "登陆成功！", TipDialog.TYPE.SUCCESS).setOnDismissListener(new OnDismissListener() {
                                                                @Override
                                                                public void onDismiss() {

                                                                    spUtils.putBoolean("loginStatus", true);
                                                                    spUtils.putString("userInfo", GsonUtil.toJson(currentUserModelBaseDto.getData()));
                                                                    if(currentUserModelBaseDto.getData().getOrgs().size() > 0){
                                                                        spUtils.putString("orgsId", currentUserModelBaseDto.getData().getOrgs().get(0).getId());
                                                                    } else {
                                                                        spUtils.putString("orgsId", "");
                                                                    }
                                                                    Log.d("----------orgsId----------",spUtils.getString("orgsId"));
                                                                    spUtils.putString("dict", GsonUtil.toJson(listBaseDto.getData()));
                                                                    spUtils.putString("Orgs", GsonUtil.toJson(canSelectOrgsModelBaseDto.getData()));
                                                                    skipMainActivity();
                                                                }
                                                            });
                                                        }
                                                    } else {
//                                                        ToastUtil.show(LoginActivity.this, listBaseDto.getMessage());
                                                        TipDialog.show(LoginActivity.this, listBaseDto.getMessage(), TipDialog.TYPE.WARNING);
                                                    }
                                                }
                                            });
                                        } else {
//                                            ToastUtil.show(LoginActivity.this, listBaseDto.getMessage());
                                            TipDialog.show(LoginActivity.this, listBaseDto.getMessage(), TipDialog.TYPE.WARNING);
                                        }
                                    }
                                });
                            } else {
//                                ToastUtil.show(LoginActivity.this, currentUserModelBaseDto.getMessage());
                                TipDialog.show(LoginActivity.this, currentUserModelBaseDto.getMessage(), TipDialog.TYPE.WARNING);
                            }

                        }
                    });
                } else {
//                    ToastUtil.show(LoginActivity.this, res.getMessage());
                    TipDialog.show(LoginActivity.this, res.getMessage(), TipDialog.TYPE.WARNING);
                }
            }
        });
    }

    private void skipMainActivity(){
        LoginVoModel loginVo = new LoginVoModel();
        loginVo.setPassword(txtRegPwd.getText().toString());
        loginVo.setPhone(txtRegPhone.getText().toString());
        List list = (List) GsonUtil.fromJson(LoginActivity.this.spUtils.getString("accountList"), List.class);
        if (list == null || list.size() == 0) {
            list = new ArrayList();
            list.add(loginVo);
        } else {
            boolean z = false;
            for (int i = 0; i < list.size(); i++) {
                String str2 = LoginActivity.TAG;
                try {
                    StringBuilder sb = new StringBuilder();
                    sb.append("showListPopupWindow: ");
                    sb.append(list.get(i));
                    Log.d(str2, sb.toString());
                    if (new JSONObject(GsonUtil.toJson(list.get(i))).getString("phone").equals(loginVo.getPhone())) {
                        z = true;
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if (!z) {
                list.add(loginVo);
            }
        }
        spUtils.putString("accountList", GsonUtil.toJson(list));
        Intent intent = new Intent(LoginActivity.this, MainActivity.class);
        startActivity(intent);
    }
    //处理点击注册事件
    private void submit() {
        Validate.check(this, new IValidateResult() {
            @Override
            public void onValidateSuccess() {
                loginClick();
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
//                skipWebView("2","onAuth");
            }
        };
        builder.setSpan(clickSpanPrivacy,11,15, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
        ClickableSpan clickableSpanProtocol=new ClickableSpan() {
            @Override
            public void onClick( View widget) {
//                跳转服务协议
//                Toast.makeText(RegisterActivity.this, getString(R.string.string_toast_to_service), Toast.LENGTH_SHORT).show();
//                skipWebView("7","onAuth");
            }
        };

        builder.setSpan(clickableSpanProtocol,16,20,Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
        tvPrivacy.setText(builder);
        tvPrivacy.setMovementMethod(LinkMovementMethod.getInstance());//调用此方法时文字点击事件才有效
    }
    public void showListPopupWindow(View view) {
        final List list = GsonUtil.fromJson(this.spUtils.getString("accountList"), List.class);
        if (list == null) {
            return;
        }
        if (list.size() > 0) {
            final ListPopupWindow listPopupWindow = new ListPopupWindow(this);
            listPopupWindow.setWidth(view.getMeasuredWidth());
            listPopupWindow.setHeight(320);
            ArrayList arrayList = new ArrayList();
            for (int i2 = 0; i2 < list.size(); i2++) {
                String str = TAG;
                try {
                    StringBuilder sb = new StringBuilder();
                    sb.append("showListPopupWindow: ");
                    sb.append(list.get(i2));
                    Log.d(str, sb.toString());
                    arrayList.add(new JSONObject(GsonUtil.toJson(list.get(i2))).getString("phone"));
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            listPopupWindow.setAnchorView(view);
            listPopupWindow.setAdapter(new ListPopupWindowAdapter(this, arrayList, index -> {
                list.remove(index);
                spUtils.putString("accountList", GsonUtil.toJson(list));
                listPopupWindow.dismiss();
                lv_showAccount.setRotation(0f);
            }, index -> {
                try {
                    JSONObject jSONObject = new JSONObject(GsonUtil.toJson(list.get(index)));
                    LoginActivity.this.txtRegPhone.setText(jSONObject.get("phone").toString());
                    LoginActivity.this.txtRegPwd.setText(jSONObject.get("password").toString());
                    listPopupWindow.dismiss();
                    lv_showAccount.setRotation(0f);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }));
            listPopupWindow.show();
            lv_showAccount.setRotation(180f);
        }
    }
}