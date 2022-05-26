package com.technology.center.view.user;

import android.content.Intent;
import android.os.Bundle;
import android.text.Spannable;
import android.text.SpannableStringBuilder;
import android.text.method.LinkMovementMethod;
import android.text.style.ClickableSpan;
import android.util.Log;
import android.view.View;
import android.widget.CompoundButton;
import android.widget.LinearLayout;
import android.widget.Switch;
import android.widget.TextView;

import com.technology.center.utils.GsonUtil;
import com.technology.center.utils.uMengHelper.PushHelper;
import com.technology.center.view.about.AboutAppActivity;
import com.technology.center.view.base.BaseActionBarActivity;

import java.util.Map;

import com.technology.center.R;

/**
 * 设置
 */
public class SettingsActivity extends BaseActionBarActivity {
    private static final String TAG = "SettingsActivity";
    private LinearLayout LayoutchangePwd;
    private LinearLayout linearLayoutLoginOut;
    private LinearLayout linearLayoutAboutApp;
    private LinearLayout linearLogoff;
    private TextView textVersion;
    private Switch aSwitch;
    private TextView tvPrivacy;
    private Switch pSwitch;

    @Override
    protected int getLayoutId() {
        return R.layout.activity_settings;
    }

    @Override
    protected void onViewCreated() {
        linearLayoutLoginOut = findViewById(R.id.items_login_out);
        LayoutchangePwd = findViewById(R.id.items_modify_pwd);
        linearLayoutAboutApp = findViewById(R.id.items_about_app);
        aSwitch = (Switch) findViewById(R.id.s_v);
        textVersion = findViewById(R.id.txt_version);

        tvPrivacy = findViewById(R.id.tv_privacy);

        pSwitch = (Switch) findViewById(R.id.s_push_v);

        linearLogoff = findViewById(R.id.items_logoff);
    }

    @Override
    protected void initEventAndData() {

        Map curVersionInfo = GsonUtil.fromJson(spUtils.getString("versionInfo"), Map.class);
        textVersion.setText("当前版本" + curVersionInfo.get("versionName").toString());


        SpannableStringBuilder builder=new SpannableStringBuilder(getString(R.string.string_privacy_setting));
        ClickableSpan clickSpanPrivacy=new ClickableSpan() {
            @Override
            public void onClick( View widget) {
//                跳转隐私政策网址
//                Toast.makeText(LoginActivity.this, getString(R.string.string_toast_to_privacy), Toast.LENGTH_SHORT).show();
                skipWebView("2","protocol");
            }
        };
        builder.setSpan(clickSpanPrivacy,0,4, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
        ClickableSpan clickableSpanProtocol=new ClickableSpan() {
            @Override
            public void onClick( View widget) {
//                跳转服务协议
//                Toast.makeText(LoginActivity.this, getString(R.string.string_toast_to_service), Toast.LENGTH_SHORT).show();
                skipWebView("7","protocol");
            }
        };
        builder.setSpan(clickableSpanProtocol,6,11,Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
        tvPrivacy.setText(builder);
        tvPrivacy.setMovementMethod(LinkMovementMethod.getInstance());//调用此方法时文字点击事件才有效

        initBindEvent();
    }

    private void initBindEvent() {
        linearLayoutLoginOut.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
//                loginViewModel.loginOut().observe(SettingsActivity.this, new androidx.lifecycle.Observer<BaseDto<String>>() {
//                    @Override
//                    public void onChanged(BaseDto<String> res) {
//                        Log.d("-----", res.getMsg());
//                        if (res.getCode().equals("200")) {
                            spUtils.remove("userInfo");
                            spUtils.remove("TOKEN");
                            spUtils.putBoolean("loginStatus", false);
                            spUtils.remove("entrustOrg");
                            spUtils.remove("dict");
                            spUtils.remove("Orgs");

                            spUtils.remove("orgsId");
                            Intent intent = new Intent("com.technology.center.loginout");
                            getBaseContext().sendBroadcast(intent);
//                        }
//                    }
//                });

            }
        });
        LayoutchangePwd.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(getBaseContext(), ChangePwdActivity.class);
                //用Bundle携带数据

                startActivity(intent);

            }
        });

        //关于口岸通
        linearLayoutAboutApp.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                Intent intent = new Intent(SettingsActivity.this, AboutAppActivity.class);
                startActivity(intent);

            }
        });
        aSwitch.setChecked(spUtils.getBoolean("isOpenVibration", false));
        aSwitch.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton compoundButton, boolean b) {
                //控制开关字体颜色
                //保存数据
                spUtils.putBoolean("isOpenVibration", b);

            }
        });
        pSwitch.setChecked(spUtils.getBoolean("isOpenPush", false));
        pSwitch.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton compoundButton, boolean b) {
                //控制开关字体颜色
                //保存数据

                PushHelper.setPushSwitch(getBaseContext(),b);


            }
        });

        //注销账号
        linearLogoff.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(SettingsActivity.this,LogoffActivity.class);
                startActivity(intent);
            }
        });
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
