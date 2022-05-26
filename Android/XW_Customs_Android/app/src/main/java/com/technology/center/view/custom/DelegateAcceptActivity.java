package com.technology.center.view.custom;


import android.content.Intent;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.view.animation.Animation;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.Toast;

import com.github.gzuliyujiang.calendarpicker.CalendarPicker;
import com.github.gzuliyujiang.calendarpicker.OnRangeDatePickListener;
import com.github.gzuliyujiang.calendarpicker.OnSingleDatePickListener;
import com.github.gzuliyujiang.calendarpicker.core.ColorScheme;
import com.github.gzuliyujiang.wheelpicker.OptionPicker;
import com.github.gzuliyujiang.wheelpicker.contract.OnLinkagePickedListener;
import com.github.gzuliyujiang.wheelpicker.contract.OnOptionPickedListener;
import com.github.gzuliyujiang.wheelpicker.contract.OnOptionSelectedListener;
import com.google.gson.reflect.TypeToken;
import com.technology.center.R;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.drawerlayout.widget.DrawerLayout;
import androidx.fragment.app.Fragment;
import androidx.viewpager.widget.ViewPager;

import com.google.android.material.tabs.TabLayout;
import com.technology.center.adapter.TitleFragmentPagerAdapter;
import com.technology.center.model.AcceptQueryModel;
import com.technology.center.model.CanSelectOrgsModel;
import com.technology.center.model.DictAllModel;
import com.technology.center.utils.GsonUtil;
import com.technology.center.utils.MyDictUtils;
import com.technology.center.utils.ToastUtil;
import com.technology.center.view.base.BaseActionBarActivity;
import com.technology.center.view.fragment.DelegagteAcceptFragment;
import com.technology.center.view.picker.InstitutionsLikePicker;

import java.lang.reflect.Type;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import cxy.com.validate.IValidateResult;
import cxy.com.validate.Validate;

public class DelegateAcceptActivity extends BaseActionBarActivity {

    private TabLayout tabLayout;
    private ViewPager viewpager;
    private DrawerLayout mDrawerLayout;
    private LinearLayout sreenViewbtn;
    private TitleFragmentPagerAdapter adapter;
    private long startTimeInMillis, endTimeInMillis ;
    private String frome;
    private String to;
    private String acceptTimeFrom;
    private String acceptTimeTo;
    private String inspectOrgId;
    @BindView(R.id.txt_sn)
    EditText txtSn;

    @BindView(R.id.txt_sampleName)
    EditText txtsampleName;

    @BindView(R.id.txt_inspectOrg)
    EditText txtinspectOrg;

    @BindView(R.id.txt_entrustOrg)
    EditText txtentrustOrg;

    @BindView(R.id.txt_createTime)
    EditText txtcreateTime;

    @BindView(R.id.txt_acceptUserName)
    EditText txtacceptUserName;

    @BindView(R.id.txt_acceptTime)
    EditText txtacceptTime;

    @Override
    protected int getLayoutId() {
        return R.layout.activity_delegate_accept;
    }

    @Override
    protected void onViewCreated() {
        ButterKnife.bind(this);



        tabLayout= findViewById(R.id.tab_layou);

        viewpager= findViewById(R.id.view_pager);

        List<Fragment> fragments = new ArrayList<>();
        List<String> titles = new ArrayList<>();
        DelegagteAcceptFragment fragment = new DelegagteAcceptFragment();
        fragment.type = DelegagteAcceptFragment.TypeEnum.WAIT_ACCEPT;
        fragments.add(fragment);
        titles.add("待受理");
        DelegagteAcceptFragment fragment1 = new DelegagteAcceptFragment();
        fragment1.type = DelegagteAcceptFragment.TypeEnum.ACCEPTED;
        fragments.add(fragment1);
        titles.add("已受理");
        adapter = new TitleFragmentPagerAdapter(getSupportFragmentManager(), fragments, titles.toArray(new String[]{}));
        viewpager.setOffscreenPageLimit(titles.size());
        viewpager.setAdapter(adapter);
//        if(isSame){
//            tabLayout.setTabMode(TabLayout.MODE_SCROLLABLE);
//        }

        tabLayout.setupWithViewPager(viewpager);
        tabLayout.addOnTabSelectedListener(new TabLayout.OnTabSelectedListener() {
            @Override
            public void onTabSelected(TabLayout.Tab tab) {
                adapter.update(tab.getPosition(),null);
            }

            @Override
            public void onTabUnselected(TabLayout.Tab tab) {

            }

            @Override
            public void onTabReselected(TabLayout.Tab tab) {

            }
        });
        sreenViewbtn= findViewById(R.id.iv_screen_btn);
        sreenViewbtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
//                Log.d("筛选");
                mDrawerLayout.openDrawer(Gravity.END);
            }
        });
        mDrawerLayout = findViewById(R.id.drawer_layout);
        txtinspectOrg.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
//                showLinkPicker();
                showOrgPicker();
            }
        });
        txtacceptTime.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                showCalendarPicker("accept");
            }
        });
        txtcreateTime.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                showCalendarPicker("create");
            }
        });

        LinearLayout lv_inspectResult = findViewById(R.id.lv_inspectResult);
        lv_inspectResult.setVisibility(View.GONE);

        MyDictUtils myUtils = new MyDictUtils(getBaseContext());

    }

    private void showOrgPicker(){

        MyDictUtils myUtils = new MyDictUtils(getBaseContext());
        List<CanSelectOrgsModel.ChildrenBean> model = myUtils.getOrgsSingleList();
        OptionPicker picker = new OptionPicker(this);
        picker.setData(model);
        picker.setOnOptionPickedListener(new OnOptionPickedListener() {
            @Override
            public void onOptionPicked(int position, Object item) {
                CanSelectOrgsModel.ChildrenBean dictModel = (CanSelectOrgsModel.ChildrenBean)item;
                txtinspectOrg.setText(dictModel.getName());
                inspectOrgId = dictModel.getId()+"";
            }
        });
        picker.getWheelLayout().setOnOptionSelectedListener(new OnOptionSelectedListener() {
            @Override
            public void onOptionSelected(int position, Object item) {
                picker.getTitleView().setText(picker.getWheelView().formatItem(position));
            }
        });
//        picker.getWheelView().setStyle(R.style.WheelStyleDemo);
        picker.show();
    }

    private void showLinkPicker(){
//        InstitutionsLikePicker picker = new InstitutionsLikePicker(DelegateAcceptActivity.this);
//        picker.setOnLinkagePickedListener(new OnLinkagePickedListener() {
//            @Override
//            public void onLinkagePicked(Object first, Object second, Object third) {
////                        ToastUtil.show(getBaseContext(), first + "-" + second + "-" + third);
////                        Log.d("onLinkagePicked",first + "\n" + second + "\n" + third);
//                String str = "";
//                if(first != null){
//                    CanSelectOrgsModel fristModel = (CanSelectOrgsModel)first;
//                    str = fristModel.getName();
//                    inspectOrgId = fristModel.getId()+"";
//                }
//                if(second != null){
//                    CanSelectOrgsModel.ChildrenBean secModel = (CanSelectOrgsModel.ChildrenBean)second;
//                    str +="/";
//                    str += secModel.getName();
//                    inspectOrgId = secModel.getId()+"";
//                }
//                if(third != null){
//                    CanSelectOrgsModel.ChildrenBean thrModel = (CanSelectOrgsModel.ChildrenBean)third;
//                    str +="/";
//                    str += thrModel.getName();
//                    inspectOrgId = thrModel.getId()+"";
//                }
//                txtinspectOrg.setText(str);
//            }
//        });
//        picker.show();
    }
    private void showCalendarPicker(String type){
        CalendarPicker picker = new CalendarPicker(DelegateAcceptActivity.this);
        Date currentDate = new Date(System.currentTimeMillis());
        if (startTimeInMillis == 0 && endTimeInMillis == 0) {
            startTimeInMillis = currentDate.getTime() - 3 * android.text.format.DateUtils.DAY_IN_MILLIS;
            endTimeInMillis = currentDate.getTime() + 3 * android.text.format.DateUtils.DAY_IN_MILLIS;
        }
//                picker.setSelectedDate(singleTimeInMillis);
        picker.setSelectedDate(startTimeInMillis, endTimeInMillis);
        picker.setColorScheme(new ColorScheme()
                .daySelectBackgroundColor(0xFF00CC00)
                .dayStressTextColor(0xFF00AA00));
        picker.setOnRangeDatePickListener(new OnRangeDatePickListener() {
            @Override
            public void onRangeDatePicked(@NonNull Date startDate, @NonNull Date endDate) {
                startTimeInMillis = startDate.getTime();
                endTimeInMillis = endDate.getTime();
                DateFormat bf = new SimpleDateFormat("yyyy-MM-dd");
                if(type.equals("accept")){
                    acceptTimeFrom = bf.format(startDate);
                    acceptTimeTo = bf.format(endDate);
                    txtacceptTime.setText(acceptTimeFrom
                            + "至" + acceptTimeTo);
                } else {
                    frome = bf.format(startDate);
                    to = bf.format(endDate);
                    txtcreateTime.setText(frome
                            + "至" + to);
                }

            }
        });
        picker.show();
    }
    @Override
    protected void initEventAndData() {

    }
    //处理点击注册事件
    @OnClick({R.id.btn_reset})
    public void resetClick(View v) {
        txtSn.setText("");
        txtsampleName.setText("");
        txtinspectOrg.setText("");
        txtentrustOrg.setText("");
        txtcreateTime.setText("");
        txtacceptUserName.setText("");
        txtacceptTime.setText("");
        frome = "";
        to= "";
        acceptTimeFrom= "";
        acceptTimeTo= "";
        inspectOrgId= "";

    }
    @OnClick({R.id.btn_confirm})
    public void confirmClick(View v) {
        Log.d("wxyi则试" ,tabLayout.getSelectedTabPosition()+"");
        AcceptQueryModel model = new AcceptQueryModel();
        model.setSn(txtSn.getText().toString());
        model.setSampleName(txtsampleName.getText().toString());
        model.setInspectOrgId(inspectOrgId);
        model.setEntrustOrgName(txtentrustOrg.getText().toString());
        model.setFrom(frome);
        model.setTo(to);
        model.setAcceptUserName(txtacceptUserName.getText().toString());
        model.setAcceptTimeFrom(acceptTimeFrom);
        model.setAcceptTimeTo(acceptTimeTo);
        adapter.update(tabLayout.getSelectedTabPosition(),model);
        mDrawerLayout.closeDrawers();
    }

    @Override
    public void onResume() {
        super.onResume();
//        adapter.update(0,null);
//        adapter.update(1,null);
    }

}