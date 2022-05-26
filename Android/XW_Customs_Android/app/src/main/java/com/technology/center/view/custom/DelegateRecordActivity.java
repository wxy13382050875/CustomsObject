package com.technology.center.view.custom;

import static com.technology.center.App.getContext;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.Gravity;
import android.view.View;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.RadioButton;
import android.widget.RadioGroup;

import androidx.annotation.NonNull;
import androidx.drawerlayout.widget.DrawerLayout;
import androidx.lifecycle.Observer;

import com.donkingliang.groupedadapter.adapter.GroupedRecyclerViewAdapter;
import com.donkingliang.groupedadapter.holder.BaseViewHolder;
import com.donkingliang.groupedadapter.layoutmanger.GroupedGridLayoutManager;
import com.github.gzuliyujiang.calendarpicker.CalendarPicker;
import com.github.gzuliyujiang.calendarpicker.OnRangeDatePickListener;
import com.github.gzuliyujiang.calendarpicker.core.ColorScheme;
import com.github.gzuliyujiang.wheelpicker.OptionPicker;
import com.github.gzuliyujiang.wheelpicker.contract.OnLinkagePickedListener;
import com.github.gzuliyujiang.wheelpicker.contract.OnOptionPickedListener;
import com.github.gzuliyujiang.wheelpicker.contract.OnOptionSelectedListener;
import com.google.gson.reflect.TypeToken;
import com.liaoinstan.springview.container.AutoFooter;
import com.technology.center.R;
import com.technology.center.Constant;
import com.technology.center.utils.ToastUtil;
import com.technology.center.adapter.RecordAdapter;
import com.technology.center.http.base.BaseDto;
import com.technology.center.model.AcceptQueryModel;
import com.technology.center.model.CanSelectOrgsModel;
import com.technology.center.model.DictAllModel;
import com.technology.center.model.EntrustInspectModel;
import com.technology.center.model.EntrustOrgModel;

import com.technology.center.repository.impl.UserRepository;
import com.technology.center.utils.GsonUtil;
import com.technology.center.utils.MyDictUtils;
import com.technology.center.view.base.BaseActionListBarActivity;

import java.lang.reflect.Type;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.technology.center.view.custom.DelegateRecordDetailActivity;
import com.technology.center.view.fragment.DelegagteAcceptFragment;
import com.technology.center.view.picker.InstitutionsLikePicker;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class DelegateRecordActivity extends BaseActionListBarActivity {
    private List<EntrustInspectModel.ContentBean> dataSource = new ArrayList<>();
    private RecordAdapter adapter;
    private int page = 1;
    private int size = 20;
    private final UserRepository userRepository = new UserRepository();

    private LinearLayout sreenViewbtn;
    private AcceptQueryModel queryModel;
    private DrawerLayout mDrawerLayout;
    private String from = "";
    private String to = "";
    private String status = "";

    private String inspectOrgId = "";
    private long startTimeInMillis, endTimeInMillis ;


    @BindView(R.id.txt_sampleName)
    EditText txtsampleName;

    @BindView(R.id.txt_inspectOrg)
    EditText txt_inspectOrg;


    @BindView(R.id.txt_createTime)
    EditText txtcreateTime;


    private RadioGroup mRadioGroup;

    private RadioButton radio;
    @Override
    protected int getLayoutId() {
        return R.layout.activity_delegate_record;
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

        txt_inspectOrg.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                showOrgPicker();
            }
        });
        txtcreateTime.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                showCalendarPicker();
            }
        });

        mRadioGroup = findViewById(R.id.rg_status);

        MyDictUtils myUtils = new MyDictUtils(getBaseContext());
        List<DictAllModel.ItemsBean>  Items = myUtils.getDictItemByCode("ENTRUST_STATUS");
        for(int i=0; i<Items.size(); i++)
        {
            RadioButton radioButton = new RadioButton(this);
            RadioGroup.LayoutParams lp = new RadioGroup.LayoutParams(RadioGroup.LayoutParams.WRAP_CONTENT, 50);
            //设置RadioButton边距 (int left, int top, int right, int bottom)
            lp.setMargins(0,0,15,0);
            radioButton.setLayoutParams(lp);
            //设置RadioButton背景'
            radioButton.setButtonDrawable(getResources().getDrawable(android.R.color.transparent));
            radioButton.setBackgroundResource(R.drawable.radio_button_selector);
            radioButton.setTextColor(getResources().getColorStateList(R.color.color_radiobutton));
            //设置RadioButton的样式
//            radioButton.setButtonDrawable(R.drawable.radio_button_selector);
            //设置文字距离四周的距离
            radioButton.setPadding(15, 5, 15, 5);
            //设置文字
            radioButton.setText(Items.get(i).getName());
            radioButton.setTextSize(13);
            final int finalI = i;
            //设置radioButton的点击事件
            radioButton.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    status = Items.get(finalI).getCode();
                    radio = radioButton;

                }
            });
            mRadioGroup.addView(radioButton);
        }

        initAdapter();
    }
    private void initAdapter() {
        adapter = new RecordAdapter(getContext(), dataSource);
        GroupedGridLayoutManager gridLayoutManager = new GroupedGridLayoutManager(getContext(), 1, adapter);
        adapter.setOnChildClickListener(listener);
        rvList.setAdapter(adapter);
        rvList.setLayoutManager(gridLayoutManager);
        springView.setFooter(new AutoFooter());

    }
    @Override
    protected void initEventAndData() {
        getData();
    }
    @Override
    protected void loadDataSource() {
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
        params.put("entrustOrgId", model.getId());
        params.put("page", page + "");
        params.put("size", size + "");

        if(queryModel != null){
            params.put("sampleName", queryModel.getSampleName());
            params.put("inspectOrgId", inspectOrgId);
            params.put("from", queryModel.getFrom());
            params.put("to", queryModel.getTo());
            params.put("status", status);
        }
        userRepository.getEntrustInspect(params).observe(DelegateRecordActivity.this, new Observer<BaseDto<EntrustInspectModel>>() {
            @Override
            public void onChanged(BaseDto<EntrustInspectModel> entrustInspectModelBaseDto) {
                springView.onFinishFreshAndLoad();

                if (entrustInspectModelBaseDto.getCode().equals(Constant.RespCode.R200)) {
                    if(entrustInspectModelBaseDto.getData().getContent().size() < size){
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

    /**
     * 处理菜单点击事件
     */
    private GroupedRecyclerViewAdapter.OnChildClickListener listener = new GroupedRecyclerViewAdapter.OnChildClickListener() {
        @Override
        public void onChildClick(GroupedRecyclerViewAdapter adapter, BaseViewHolder holder, int groupPosition, int childPosition) {
            EntrustInspectModel.ContentBean model = dataSource.get(groupPosition);
            if(!model.getStatus().equals("BACK")){
                Intent intent = new Intent(getContext(), DelegateRecordDetailActivity.class);
                //用Bundle携带数据
                Bundle bundle = new Bundle();
                //传递name参数为tinyphp
                bundle.putSerializable("model",model);

                intent.putExtras(bundle);
                startActivity(intent);
            } else {
                Intent intent = new Intent(getContext(), DelegateApplyActivity.class);
                //用Bundle携带数据
                Bundle bundle = new Bundle();
                //传递name参数为tinyphp
                bundle.putSerializable("model",model);
                bundle.putString("type","detail");
                intent.putExtras(bundle);
                startActivityForResult(intent,1000);

            }

        }
    };
    private void showOrgPicker(){

        MyDictUtils myUtils = new MyDictUtils(getBaseContext());
        List<CanSelectOrgsModel.ChildrenBean> model = myUtils.getOrgsSingleList();
        OptionPicker picker = new OptionPicker(this);
        picker.setData(model);
        picker.setOnOptionPickedListener(new OnOptionPickedListener() {
            @Override
            public void onOptionPicked(int position, Object item) {
                CanSelectOrgsModel.ChildrenBean dictModel = (CanSelectOrgsModel.ChildrenBean)item;
                txt_inspectOrg.setText(dictModel.getName());
                inspectOrgId = dictModel.getId()+"";
            }
        });
        picker.getWheelLayout().setOnOptionSelectedListener(new OnOptionSelectedListener() {
            @Override
            public void onOptionSelected(int position, Object item) {
                picker.getTitleView().setText(picker.getWheelView().formatItem(position));
            }
        });
        picker.show();
    }

    private void showLinkPicker(){
        InstitutionsLikePicker picker = new InstitutionsLikePicker(DelegateRecordActivity.this);
        picker.setOnLinkagePickedListener(new OnLinkagePickedListener() {
            @Override
            public void onLinkagePicked(Object first, Object second, Object third) {
//                        ToastUtil.show(getBaseContext(), first + "-" + second + "-" + third);
//                        Log.d("onLinkagePicked",first + "\n" + second + "\n" + third);
                String str = "";
                if(first != null){
                    CanSelectOrgsModel fristModel = (CanSelectOrgsModel)first;
                    str = fristModel.getName();
                    inspectOrgId = fristModel.getId()+"";
                }
                if(second != null){
                    CanSelectOrgsModel.ChildrenBean secModel = (CanSelectOrgsModel.ChildrenBean)second;
                    str +="/";
                    str += secModel.getName();
                    inspectOrgId = secModel.getId()+"";
                }
                if(third != null){
                    CanSelectOrgsModel.ChildrenBean thrModel = (CanSelectOrgsModel.ChildrenBean)third;
                    str +="/";
                    str += thrModel.getName();
                    inspectOrgId = thrModel.getId()+"";
                }
                txt_inspectOrg.setText(str);
            }
        });
        picker.show();
    }
    private void showCalendarPicker(){
        CalendarPicker picker = new CalendarPicker(DelegateRecordActivity.this);
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
        txtsampleName.setText("");
        txtcreateTime.setText("");
        txt_inspectOrg.setText("");
        from = "";
        to = "";
        status = "";
        inspectOrgId ="";
        radio.setChecked(false);
        queryModel = null;

    }
    @OnClick({R.id.btn_confirm})
    public void confirmClick(View v) {
        queryModel = new AcceptQueryModel();
        queryModel.setInspectOrgId(inspectOrgId);
        queryModel.setSampleName(txtsampleName.getText().toString());

        queryModel.setFrom(from);
        queryModel.setTo(to);
        queryModel.setStatus(status);
        loadDataSource();
        mDrawerLayout.closeDrawers();
    }
    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        switch (requestCode) {
            case 1000:{
                //刷新页面，获取更新个人资料后的内容
                loadDataSource();
                break;
            }
            //……
            default:
                break;
        }
    }
}