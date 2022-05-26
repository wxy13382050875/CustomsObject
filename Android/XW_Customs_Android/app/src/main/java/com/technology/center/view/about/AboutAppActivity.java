package com.technology.center.view.about;

import android.annotation.SuppressLint;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.kongzue.dialog.interfaces.OnDialogButtonClickListener;
import com.kongzue.dialog.util.BaseDialog;
import com.kongzue.dialog.v3.MessageDialog;
import com.technology.center.Constant;
import com.technology.center.handler.MsgHandlerCallBack;
import com.technology.center.utils.AppUpdateUtils;
import com.technology.center.utils.GsonUtil;
import com.technology.center.utils.SpUtils;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.Map;
import java.util.Objects;

import com.technology.center.R;
import com.technology.center.view.base.BaseActionBarActivity;


public class AboutAppActivity extends BaseActionBarActivity {
    private LinearLayout items_check_version;
    private  LinearLayout items_function_pro;
    private TextView txt_version;
    private AppUpdateUtils appUpdateUtils;

    @Override
    protected int getLayoutId() {
        return R.layout.activity_about_app;
    }

    @Override
    protected void onViewCreated() {
        items_check_version = findViewById(R.id.items_check_version);
        items_function_pro = findViewById(R.id.items_function_pro);
        txt_version = findViewById(R.id.txt_version);
        appUpdateUtils = new AppUpdateUtils(getBaseContext());
    }

    @SuppressLint("SetTextI18n")
    @Override
    protected void initEventAndData() {

        //检查版本更新
        items_check_version.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                appUpdateUtils.checkVersion(handlerCheckVersion);
            }
        });

        Map curVersionInfo = GsonUtil.fromJson(spUtils.getString("versionInfo"), Map.class);
        assert curVersionInfo != null;
        txt_version.setText("当前版本" + Objects.requireNonNull(curVersionInfo.get("versionName")).toString() +"(" + Objects.requireNonNull(curVersionInfo.get("versionCode")).toString() + ")");


        items_function_pro.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
//                try {
//                    String userInfo = spUtils.getString("userInfo");
//
//                    JSONObject params = new JSONObject();
//                    params.put("userInfo", new JSONObject(userInfo));
//                    params.put("BASE_URL", Constant.Server.PORT_BT_URL);
//                    params.put("TOKEN", spUtils.getString("TOKEN"));
//
//                    DCUniMPSDK.getInstance().startApp(
//                            getBaseContext(), Constant.UNI_APPID.STATIC_MODULE, MySplashView.class,
//                            "pages/common/introduced",
//                            params);
//                } catch (Exception e) {e.printStackTrace();
//
//                }
            }
        });
    }

    private MsgHandlerCallBack handlerCheckVersion = new MsgHandlerCallBack() {
        @Override
        public void handlerMessage(JSONObject data) throws JSONException {
            if (data.getInt("rs") == -1) {
                String content = data.getJSONObject("data").getString("versionIntro");
                String downloadUrl = data.getJSONObject("data").getString("downloadUrl");
                MessageDialog
                        .show(AboutAppActivity.this, "有新版本更新", content.replace("\\n", "\n"), "立即下载", "以后再说")
                        .setOnCancelButtonClickListener(new OnDialogButtonClickListener() {
                            @Override
                            public boolean onClick(BaseDialog baseDialog, View v) {
                                return false;
                            }
                        })
                        .setOnOkButtonClickListener(new OnDialogButtonClickListener() {
                            @Override
                            public boolean onClick(BaseDialog baseDialog, View v) {
                                appUpdateUtils.downloadBySelf(getBaseContext(), downloadUrl, "kou_an_tong.apk");
                                return false;
                            }
                        });
            } else {
                MessageDialog.show(AboutAppActivity.this, "版本检查", "当前版本为最新版本");
            }
        }

        @Override
        public void handlerMessage(String data) throws Exception {

        }


    };

}
