package com.technology.center.view.custom;


import static com.technology.center.App.getContext;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.widget.EditText;
import android.widget.LinearLayout;

import androidx.annotation.NonNull;
import androidx.drawerlayout.widget.DrawerLayout;
import androidx.lifecycle.Observer;

import com.donkingliang.groupedadapter.adapter.GroupedRecyclerViewAdapter;
import com.donkingliang.groupedadapter.holder.BaseViewHolder;
import com.donkingliang.groupedadapter.layoutmanger.GroupedGridLayoutManager;
import com.github.gzuliyujiang.calendarpicker.CalendarPicker;
import com.github.gzuliyujiang.calendarpicker.OnRangeDatePickListener;
import com.github.gzuliyujiang.calendarpicker.core.ColorScheme;
import com.kongzue.dialog.v3.CustomDialog;
import com.liaoinstan.springview.aliheader.AliFooter;
import com.liaoinstan.springview.container.AutoFooter;
import com.technology.center.R;
import com.technology.center.Constant;
import com.technology.center.adapter.CertificateAdapter;
import com.technology.center.http.base.BaseDto;
import com.technology.center.model.AcceptQueryModel;
import com.technology.center.model.EntrustInspectModel;
import com.technology.center.model.EntrustOrgModel;
import com.technology.center.model.MenuListModel;

import com.technology.center.repository.impl.UserRepository;
import com.technology.center.utils.GsonUtil;
import com.technology.center.utils.ToastUtil;
import com.technology.center.view.base.BaseActionListBarActivity;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import lombok.SneakyThrows;

public class CertificateManageActivity extends BaseActionListBarActivity {


    private static final String TAG = "CertificateManageActivity";
    private long startTimeInMillis, endTimeInMillis ;
    private List<EntrustInspectModel.ContentBean> dataSource = new ArrayList<>();
    private CertificateAdapter adapter;
    private int page = 1;
    private int size = 20;
    private final UserRepository userRepository = new UserRepository();
    private LinearLayout sreenViewbtn;
    private AcceptQueryModel queryModel;
    private DrawerLayout mDrawerLayout;
    private String from = "";
    private String to = "";

    @BindView(R.id.txt_sn)
    EditText txtSn;

    @BindView(R.id.txt_sampleName)
    EditText txtsampleName;


    @BindView(R.id.txt_createTime)
    EditText txtcreateTime;



    @Override
    protected int getLayoutId() {
        return R.layout.activity_certificate_manage;
    }

    @Override
    protected void onViewCreated() {
        ButterKnife.bind(this);
        sreenViewbtn= findViewById(R.id.iv_screen_btn);
        sreenViewbtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
//                Log.d("筛选");
                mDrawerLayout.openDrawer(Gravity.END);
            }
        });
        mDrawerLayout = findViewById(R.id.drawer_layout);


        txtcreateTime.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                showCalendarPicker();
            }
        });
        initAdapter();
    }
    private void initAdapter() {
        adapter = new CertificateAdapter(getContext(), dataSource);
        GroupedGridLayoutManager gridLayoutManager = new GroupedGridLayoutManager(getContext(), 1, adapter);
        adapter.setOnChildClickListener(listener);
        rvList.setAdapter(adapter);
        rvList.setLayoutManager(gridLayoutManager);
        springView.setFooter(new AutoFooter());
    }
    /**
     * 处理菜单点击事件
     */
    private GroupedRecyclerViewAdapter.OnChildClickListener listener = new GroupedRecyclerViewAdapter.OnChildClickListener() {
        @Override
        public void onChildClick(GroupedRecyclerViewAdapter adapter, BaseViewHolder holder, int groupPosition, int childPosition) {
            Intent intent = new Intent(getContext(), CertificateQueryActivity.class);
            //用Bundle携带数据
            Bundle bundle = new Bundle();
            //传递name参数为tinyphp
            bundle.putSerializable("model",dataSource.get(childPosition));

            intent.putExtras(bundle);
            startActivity(intent);

        }
    };
    @Override
    protected void initEventAndData() {
        getData();
    }

    @Override
    protected void loadDataSource() {
        springView.getFooter(AutoFooter.class).showProgress();
        page = 1;
        dataSource.clear();
        getData();
    }

    @Override
    protected void loadMoreDataSource() {
        if (springView.getFooter(AutoFooter.class).isInProgress()) {
            page++;
            getData();
        }
    }
    private void getData(){
        EntrustOrgModel model = GsonUtil.fromJson(spUtils.getString("entrustOrg"), EntrustOrgModel.class);
        Map<String, String> params = new HashMap<>();

        params.put("status", "DONE");
        params.put("entrustOrgId", model.getId());
        params.put("page", page + "");
        params.put("size", size + "");
        if(queryModel != null){
            params.put("sn", queryModel.getSn());
            params.put("sampleName", queryModel.getSampleName());
            params.put("from", queryModel.getFrom());
            params.put("to", queryModel.getTo());
        }

        userRepository.getEntrustInspect(params).observe(CertificateManageActivity.this, new Observer<BaseDto<EntrustInspectModel>>() {
            @Override
            public void onChanged(BaseDto<EntrustInspectModel> entrustInspectModelBaseDto) {

                springView.onFinishFreshAndLoad();
                if (entrustInspectModelBaseDto.getCode().equals(Constant.RespCode.R200)) {
                    if(entrustInspectModelBaseDto.getData().getContent().size() < size) {
                        springView.getFooter(AutoFooter.class).showBottomLine();
                    }
                    dataSource.addAll(entrustInspectModelBaseDto.getData().getContent());
                    Message msg = new Message();
                    msg.what = 1;
                    mHandler.sendMessage(msg);
                } else {
                    ToastUtil.show(getContext(), entrustInspectModelBaseDto.getMessage());
                }
            }
        });
    }
    private void showCalendarPicker(){
        CalendarPicker picker = new CalendarPicker(CertificateManageActivity.this);
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
                from = bf.format(startDate);
                to = bf.format(endDate);
                txtcreateTime.setText(from
                        + "至" + to);

            }
        });
        picker.show();
    }

    //handler
    private Handler mHandler = new Handler() {
        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            switch (msg.what) {
                case 1:
                    adapter.mGroups = dataSource;

                    adapter.notifyDataChanged();


                    break;
                default:
                    break;
            }
        }
    };



    //处理点击注册事件
    @OnClick({R.id.btn_reset})
    public void resetClick(View v) {
        txtSn.setText("");
        txtsampleName.setText("");
        txtcreateTime.setText("");
        from = "";
        to = "";
        queryModel = null;

    }
    @OnClick({R.id.btn_confirm})
    public void confirmClick(View v) {
        queryModel = new AcceptQueryModel();
        queryModel.setSn(txtSn.getText().toString());
        queryModel.setSampleName(txtsampleName.getText().toString());

        queryModel.setFrom(from);
        queryModel.setTo(to);
        loadDataSource();
        mDrawerLayout.closeDrawers();
    }
}