
package com.technology.center.view;
import android.annotation.SuppressLint;
import android.app.ProgressDialog;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager.NameNotFoundException;
import android.os.Bundle;
import android.os.Vibrator;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;

import com.chason.lottieview.LottieTabView;
import com.kongzue.dialog.interfaces.OnDialogButtonClickListener;
import com.kongzue.dialog.util.BaseDialog;
import com.kongzue.dialog.v3.MessageDialog;
import com.technology.center.handler.MsgHandlerCallBack;
import com.technology.center.utils.AppUpdateUtils;
import com.technology.center.utils.GsonUtil;
import com.technology.center.utils.SpUtils;
import com.technology.center.view.base.BaseCompatActivity;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;

import com.technology.center.R;
import com.technology.center.view.fragment.mainHomeFragment;
import com.technology.center.view.fragment.mainMsgFragment;
import com.technology.center.view.fragment.mainMyFragment;
import com.technology.center.view.fragment.mainOfficeFragment;


public class MainActivity extends BaseCompatActivity {
    private static final String TAG = "MainActivity";

    public AppUpdateUtils appUpdateUtils;
    private int currentPage = 0;
    private FragmentManager fragmentManager;

    private mainHomeFragment mHomeFragment;
    private mainOfficeFragment mOfficeFragment;
    private mainMsgFragment mMsgFragment;
    private mainMyFragment mMyFragment;

    private SpUtils spUtils;

    private LottieTabView mLottieHomeTab;
    private LottieTabView mLottieOfficeTab;
    private LottieTabView mLottieMsgTab;
    private LottieTabView mLottieMyTab;
    private Vibrator vibrator;


    private View.OnClickListener onClickListener = new View.OnClickListener() {


        @SuppressLint("MissingPermission")
        @Override
        public void onClick(View v) {
            switch (v.getId()) {
                case R.id.tab_view_home:
                    displayFragment(0);
                    mLottieHomeTab.selected();
                    mLottieOfficeTab.unSelected();
                    mLottieMsgTab.unSelected();
                    mLottieMyTab.unSelected();
                    break;
                case R.id.tab_view_office:
                    displayFragment(1);
                    mLottieHomeTab.unSelected();
                    mLottieOfficeTab.selected();
                    mLottieMsgTab.unSelected();
                    mLottieMyTab.unSelected();
                    break;

                case R.id.tab_view_msg:
                    displayFragment(2);
                    mLottieHomeTab.unSelected();
                    mLottieOfficeTab.unSelected();
                    mLottieMsgTab.selected();
                    mLottieMyTab.unSelected();
                    break;
                case R.id.tab_view_my:
                    displayFragment(3);
                    mLottieHomeTab.unSelected();
                    mLottieOfficeTab.unSelected();
                    mLottieMsgTab.unSelected();
                    mLottieMyTab.selected();
                    break;

            }
            if (spUtils.getBoolean("isOpenVibration", false)){
                vibrator.vibrate(30);
//            long [] pattern = {100,500};   // 停止 开启 停止 开启
//            vibrator.vibrate(pattern,-1);
            }


        }
    };

    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView((int) R.layout.activity_main);
        this.fragmentManager = getSupportFragmentManager();
        this.spUtils = new SpUtils(getApplicationContext());
        initUI();
        initVersionInfo();
        checkVersion();
        if (bundle != null) {
            this.currentPage = bundle.getInt("neo");
        }
        displayFragment(this.currentPage);



    }

    private void initUI() {
        this.mLottieHomeTab = (LottieTabView) findViewById(R.id.tab_view_home);
        this.mLottieHomeTab.setOnClickListener(onClickListener);

        this.mLottieOfficeTab = (LottieTabView) findViewById(R.id.tab_view_office);
        this.mLottieOfficeTab.setImageAssetsFolder("images/");
        this.mLottieOfficeTab.setAnimation("tabbar_1.json");
        this.mLottieOfficeTab.setNormalImageDrawable(getResources().getDrawable(R.mipmap.ic_bom_nav_icon_office));
        this.mLottieOfficeTab.setOnClickListener(onClickListener);



        this.mLottieMsgTab = (LottieTabView) findViewById(R.id.tab_view_msg);
        this.mLottieMsgTab.setOnClickListener(onClickListener);

        this.mLottieMyTab = (LottieTabView) findViewById(R.id.tab_view_my);
        this.mLottieMyTab.setOnClickListener(onClickListener);

        vibrator = (Vibrator) getSystemService(VIBRATOR_SERVICE);

    }

    private void initVersionInfo() {
        PackageInfo packageInfo;
        try {
            packageInfo = getBaseContext().getPackageManager().getPackageInfo(getBaseContext().getPackageName(), 0);
        } catch (NameNotFoundException e) {
            e.printStackTrace();
            packageInfo = null;
        }
        HashMap hashMap = new HashMap();
        hashMap.put("versionName", packageInfo.versionName);
        hashMap.put("versionCode", Integer.valueOf(packageInfo.versionCode));
        this.spUtils.putString("versionInfo", GsonUtil.toJson(hashMap));
    }

    private void checkVersion() {
        this.appUpdateUtils = new AppUpdateUtils(getBaseContext());
        SpUtils spUtils2 = this.spUtils;
        if (spUtils.getBoolean("loginStatus", false)) {
            this.appUpdateUtils.checkVersion(new MsgHandlerCallBack() {


                public void handlerMessage(JSONObject jSONObject) throws JSONException {
                    if (jSONObject.getInt("rs") == -1) {
                        String str = "data";
                        final String string = jSONObject.getJSONObject(str).getString("downloadUrl");
                        String string2 = jSONObject.getJSONObject(str).getString("versionIntro");
                        Boolean forceUpdate = jSONObject.getJSONObject(str).getBoolean("forceUpdate");
                        if(forceUpdate){
                            MessageDialog.show((AppCompatActivity) MainActivity.this, "有新版本更新", string2.replace("\\n", "\n"), "立即下载" ).setOnOkButtonClickListener(new OnDialogButtonClickListener() {
                                public boolean onClick(BaseDialog baseDialog, View view) {
                                    MainActivity.this.appUpdateUtils.downloadBySelf(MainActivity.this.getBaseContext(), string, "kou_an_tong.apk");
                                    return false;
                                }
                            });
                        } else {
                            MessageDialog
                                    .show(MainActivity.this, "有新版本更新", string2.replace("\\n", "\n"), "立即下载", "以后再说")
                                    .setOnCancelButtonClickListener(new OnDialogButtonClickListener() {
                                        @Override
                                        public boolean onClick(BaseDialog baseDialog, View v) {
                                            return false;
                                        }
                                    })
                                    .setOnOkButtonClickListener(new OnDialogButtonClickListener() {
                                        @Override
                                        public boolean onClick(BaseDialog baseDialog, View v) {
                                            appUpdateUtils.downloadBySelf(getBaseContext(), string, "kou_an_tong.apk");
                                            return false;
                                        }
                                    });
                        }

                    }
                }

                @Override
                public void handlerMessage(String data) throws Exception {

                }
            });
        }
    }

    public void displayFragment(int position) {
        FragmentTransaction beginTransaction = this.fragmentManager.beginTransaction();
        hideFragments(beginTransaction);
        if (position == 0) {
            mainHomeFragment Fragment = this.mHomeFragment;
            if (Fragment == null) {
                this.mHomeFragment = new mainHomeFragment();

                beginTransaction.add(R.id.container_fragment, this.mHomeFragment);
            } else {
                beginTransaction.show(Fragment);
            }

        } else if (position == 1) {
            mainOfficeFragment Fragment = this.mOfficeFragment;


            if (Fragment == null) {
                this.mOfficeFragment = new mainOfficeFragment();

                beginTransaction.add(R.id.container_fragment, this.mOfficeFragment);
            } else {
                beginTransaction.show(Fragment);
            }
        }  else if (position == 2) {
            mainMsgFragment Fragment = this.mMsgFragment;
            if (Fragment == null) {
                this.mMsgFragment = new mainMsgFragment();
                beginTransaction.add(R.id.container_fragment, this.mMsgFragment );
            } else {
                beginTransaction.show(Fragment);
            }
        } else if (position == 3) {
            mainMyFragment Fragment = this.mMyFragment;
            if (Fragment == null) {
                this.mMyFragment = new mainMyFragment();
                beginTransaction.add(R.id.container_fragment, this.mMyFragment);
            } else {
                beginTransaction.show(Fragment);
            }
        }
        beginTransaction.commit();
    }

    private void hideFragments(FragmentTransaction fragmentTransaction) {

        mainHomeFragment mainHomeFragment2 = this.mHomeFragment;
        if (mainHomeFragment2 != null) {
            fragmentTransaction.hide(mainHomeFragment2);
        }
        mainOfficeFragment mainInfoFragment2 = this.mOfficeFragment;
        if (mainInfoFragment2 != null) {
            fragmentTransaction.hide(mainInfoFragment2);
        }

        mainMsgFragment mainMessageFragment2 = this.mMsgFragment;
        if (mainMessageFragment2 != null) {
            fragmentTransaction.hide(mainMessageFragment2);
        }
        mainMyFragment mainMeListFragment2 = this.mMyFragment;
        if (mainMeListFragment2 != null) {
            fragmentTransaction.hide(mainMeListFragment2);
        }

    }

    @SuppressLint("WrongConstant")
    public void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        setIntent(intent);
        Bundle extras = getIntent().getExtras();
        if (extras != null) {
            String str = "type";
            if (extras.containsKey(str) && Integer.parseInt(extras.getString(str)) == 1001) {
//                this.mBottomNavigationView.setSelectedItemId(R.id.mainMessageFragmentNav);
//                BottomNavigationMenuView bottomNavigationMenuView = (BottomNavigationMenuView) this.mBottomNavigationView.getChildAt(0);
//                BottomNavigationItemView bottomNavigationItemView = (BottomNavigationItemView) bottomNavigationMenuView.getChildAt(2);
//                View inflate = LayoutInflater.from(this).inflate(R.layout.im_badge, bottomNavigationMenuView, false);
//                bottomNavigationItemView.addView(inflate);
//                ((TextView) inflate.findViewById(R.id.tv_msg_count)).setVisibility(0);
                displayFragment(3);
                mLottieHomeTab.unSelected();
                mLottieOfficeTab.unSelected();
                mLottieMsgTab.selected();
                mLottieMyTab.unSelected();
            }
        }
    }

    public void onDestroy() {
        super.onDestroy();
        Log.d(TAG, "onDestroy: onDestroy MainActivity");
    }

    @Override
    public void onSaveInstanceState(Bundle bundle) {
        String str = "neo";
        bundle.putInt(str, this.currentPage);
        super.onSaveInstanceState(bundle);
        Log.i(str, "onSaveInstanceState");
    }
}