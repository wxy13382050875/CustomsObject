package com.technology.center.view.custom;


import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.animation.Animation;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.RadioGroup;

import androidx.annotation.NonNull;
import androidx.lifecycle.Observer;

import com.github.gzuliyujiang.calendarpicker.CalendarPicker;
import com.github.gzuliyujiang.calendarpicker.OnSingleDatePickListener;
import com.github.gzuliyujiang.calendarpicker.core.DateUtils;
import com.github.gzuliyujiang.wheelpicker.OptionPicker;
import com.github.gzuliyujiang.wheelpicker.contract.OnLinkagePickedListener;
import com.github.gzuliyujiang.wheelpicker.contract.OnOptionPickedListener;
import com.github.gzuliyujiang.wheelpicker.contract.OnOptionSelectedListener;
import com.kongzue.dialog.interfaces.OnDismissListener;
import com.kongzue.dialog.v3.TipDialog;
import com.kongzue.dialog.v3.WaitDialog;
import com.technology.center.Constant;
import com.technology.center.R;
import com.technology.center.http.base.BaseDto;
import com.technology.center.model.ApplyModel;
import com.technology.center.model.CanSelectOrgsModel;
import com.technology.center.model.DictAllModel;
import com.technology.center.model.EntrustInspectModel;
import com.technology.center.model.EntrustOrgModel;
import com.technology.center.repository.impl.UserRepository;
import com.technology.center.utils.GsonUtil;
import com.technology.center.utils.MyDictUtils;
import com.technology.center.utils.SpUtils;
import com.technology.center.utils.ToastUtil;
import com.technology.center.view.base.BaseActionBarActivity;
import com.technology.center.view.picker.InstitutionsLikePicker;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import cxy.com.validate.IValidateResult;
import cxy.com.validate.Validate;
import cxy.com.validate.annotation.Index;
import cxy.com.validate.annotation.NotNull;

public class DelegateApplyActivity extends BaseActionBarActivity {


    private static final String TAG = "DelegateRegistActivity";
    private long singleTimeInMillis;
    private String inspectOrgId;

    private String takeWay;

    private final UserRepository userRepository = new UserRepository();
    private EntrustOrgModel model;
    private EntrustInspectModel.ContentBean cacheModel;
    private String type = "";
    @BindView(R.id.txt_entrustOrg)
    EditText txt_entrustOrg;

    @BindView(R.id.txt_address)
    EditText txt_address;

    @BindView(R.id.txt_contacts)
    EditText txt_contacts;

    @BindView(R.id.txt_phone)
    EditText txt_phone;

    @Index(2)
    @NotNull(msg = "样品名称不能为空！")
    @BindView(R.id.txt_sampleName)
    EditText txt_sampleName;

    @Index(3)
    @NotNull(msg = "样品份数不能为空！")
    @BindView(R.id.txt_sampleNum)
    EditText txt_sampleNum;


    @Index(4)
    @NotNull(msg = "规格型号不能为空！")
    @BindView(R.id.txt_spec)
    EditText txt_spec;

    @Index(5)
    @NotNull(msg = "生产日期不能为空！")
    @BindView(R.id.txt_productionDate)
    EditText txt_productionDate;

    @BindView(R.id.txt_excStandard)
    EditText txt_excStandard;

    @BindView(R.id.txt_sampleMark)
    EditText txt_sampleMark;

    @Index(8)
    @NotNull(msg = "样品数量不能为空！")
    @BindView(R.id.txt_sampleQuantity)
    EditText txt_sampleQuantity;

    @Index(9)
    @NotNull(msg = "样品重量不能为空！")
    @BindView(R.id.txt_sampleWeight)
    EditText txt_sampleWeight;

    @BindView(R.id.txt_project)
    EditText txt_project;

    @BindView(R.id.txt_projectBasis)
    EditText txt_projectBasis;

    @Index(10)
    @NotNull(msg = "生产商不能为空！")
    @BindView(R.id.txt_producer)
    EditText txt_producer;

    @Index(11)
    @NotNull(msg = "生产商地址不能为空！")
    @BindView(R.id.txt_producerAddress)
    EditText txt_producerAddress;

    @Index(11)
    @NotNull(msg = "检测机构不能为空！")
    @BindView(R.id.txt_inspectOrg)
    EditText txt_inspectOrg;

    @BindView(R.id.btn_save)
    Button btn_save;


    private RadioGroup mRadioGroup;
    @Override
    protected int getLayoutId() {
        return R.layout.activity_delegate_apply;
    }

    @Override
    protected void onViewCreated() {
        spUtils = new SpUtils(getBaseContext());
        initView();
        Validate.reg(this);
    }

    @Override
    protected void initEventAndData() {
        model = GsonUtil.fromJson(spUtils.getString("entrustOrg"), EntrustOrgModel.class);
        txt_entrustOrg.setText(model.getName());
        txt_address.setText(model.getAddress());
        txt_contacts.setText(model.getContacts());
        txt_phone.setText(model.getPhone());
        Bundle bundle = this.getIntent().getExtras();
        if (bundle != null) {
            // 从bundle数据包中取出数据
            cacheModel = (EntrustInspectModel.ContentBean) bundle.getSerializable("model");
            type = bundle.getString("type");
            initData();
            btn_save.setVisibility(View.GONE);

        } else {
            userRepository.getOneCache().observe(DelegateApplyActivity.this, new Observer<BaseDto<EntrustInspectModel.ContentBean>>() {
                @Override
                public void onChanged(BaseDto<EntrustInspectModel.ContentBean> contentBeanBaseDto) {

                    if (contentBeanBaseDto.getCode().equals(Constant.RespCode.R200)) {
                        cacheModel = contentBeanBaseDto.getData();
                        initData();
                    } else {
                        ToastUtil.show(getBaseContext(), contentBeanBaseDto.getMessage());
                    }

                }
            });
        }

    }
    private void initData(){
        MyDictUtils myUtils = new MyDictUtils(getBaseContext());
        if(cacheModel != null){

            txt_sampleName.setText(cacheModel.getSampleName() != null ? cacheModel.getSampleName():"");
            txt_sampleNum.setText(cacheModel.getSampleNum() != null ? cacheModel.getSampleNum():"");
            txt_spec.setText(cacheModel.getSpec() != null ? cacheModel.getSpec():"");
            txt_productionDate.setText(cacheModel.getProductionDate() != null ? cacheModel.getProductionDate():"");
            txt_excStandard.setText(cacheModel.getExcStandard() != null ? cacheModel.getExcStandard():"");
            txt_sampleMark.setText(cacheModel.getSampleMark() != null ? cacheModel.getSampleMark():"");
            txt_sampleQuantity.setText(cacheModel.getSampleQuantity() != null ? cacheModel.getSampleQuantity():"");
            txt_project.setText(cacheModel.getProject() != null ? cacheModel.getProject():"");
            txt_projectBasis.setText(cacheModel.getProjectBasis() != null ? cacheModel.getProjectBasis():"");
            txt_producer.setText(cacheModel.getProducer() != null ? cacheModel.getProducer():"");
            txt_producerAddress.setText(cacheModel.getProducerAddress() != null ? cacheModel.getProducerAddress():"");
            txt_inspectOrg.setText(cacheModel.getInspectOrgId() != null ? myUtils.getSingleOrgsNameById(cacheModel.getInspectOrgId()):"");
            txt_sampleWeight.setText(cacheModel.getSampleWeight() != null ? cacheModel.getSampleWeight():"");


        }
        List<DictAllModel.ItemsBean>  Items = myUtils.getDictItemByCode("TAKE_WAY");
        for(int i=0; i<Items.size(); i++)
        {
            RadioButton radioButton = new RadioButton(this);
            RadioGroup.LayoutParams lp = new RadioGroup.LayoutParams(RadioGroup.LayoutParams.WRAP_CONTENT, RadioGroup.LayoutParams.WRAP_CONTENT);
            //设置RadioButton边距 (int left, int top, int right, int bottom)
            lp.setMargins(15,0,0,0);
            //设置RadioButton背景
            //radioButton.setBackgroundResource(R.drawable.xx);
            //设置RadioButton的样式
//            radioButton.setButtonDrawable(R.drawable.radio_bg);
            //设置文字距离四周的距离
            radioButton.setPadding(5, 0, 0, 0);
            //设置文字
            radioButton.setText(Items.get(i).getName());
            final int finalI = i;
            //设置radioButton的点击事件
            radioButton.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    takeWay = Items.get(finalI).getCode();
                }
            });
            if(cacheModel != null && cacheModel.getTakeWay() != null) {
                if(cacheModel.getTakeWay().equals(Items.get(i).getCode())){
                    radioButton.setChecked(true);
                    takeWay = Items.get(i).getCode();
                }
            }

            mRadioGroup.addView(radioButton);
        }
    }
    //初始化控件
    private void initView() {
        ButterKnife.bind(this);

        mRadioGroup = findViewById(R.id.rg_takeWay);

        txt_inspectOrg.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                showOrgPicker();
            }
        });
        txt_productionDate.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onCalendarDateSingle();
            }
        });
    }
    private void onCalendarDateSingle(){


        CalendarPicker picker = new CalendarPicker(this);
        Date currentDate = new Date(System.currentTimeMillis());
        Calendar minCalendar = DateUtils.calendar(currentDate);
        minCalendar.add(Calendar.MONTH, -12);
        minCalendar.set(Calendar.DAY_OF_MONTH, DateUtils.maxDaysOfMonth(minCalendar.getTime()));
        Date minDate = minCalendar.getTime();
        Calendar maxCalendar = DateUtils.calendar(currentDate);
        maxCalendar.setTime(currentDate);
        maxCalendar.add(Calendar.MONTH, 12);
        maxCalendar.set(Calendar.DAY_OF_MONTH, DateUtils.maxDaysOfMonth(maxCalendar.getTime()));
        Date maxDate = maxCalendar.getTime();
        picker.setRangeDate(minDate, maxDate);
//        picker.setRangeDateOnFuture(3);
        if (singleTimeInMillis == 0) {
            singleTimeInMillis = System.currentTimeMillis();
        }
        picker.setSelectedDate(singleTimeInMillis);
//        picker.setFestivalProvider(new MyFestivalProvider());
        picker.setOnSingleDatePickListener(new OnSingleDatePickListener() {
            @Override
            public void onSingleDatePicked(@NonNull Date date) {
                singleTimeInMillis = date.getTime();
                DateFormat bf = new SimpleDateFormat("yyyy-MM-dd");
                txt_productionDate.setText(bf.format(date));
            }
        });
        picker.show();

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
//        picker.getWheelView().setStyle(R.style.WheelStyleDemo);
        picker.show();
    }
    private void showLikePicker(){
        InstitutionsLikePicker picker = new InstitutionsLikePicker(DelegateApplyActivity.this);
        picker.setOnLinkagePickedListener(new OnLinkagePickedListener() {
            @Override
            public void onLinkagePicked(Object first, Object second, Object third) {
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
    //提交
    private void submitClick() {
        if(takeWay == null){
            ToastUtil.show(getBaseContext(), "请选择报告拿取方式");
            return;
        }
        Map<String, String> params = new HashMap<>();
        params.put("entrustOrgId",model.getId());
        params.put("inspectOrgId", inspectOrgId);
        params.put("sampleName", txt_sampleName.getText().toString());
        params.put("sampleNum", txt_sampleNum.getText().toString());
        params.put("sampleQuantity", txt_sampleQuantity.getText().toString());
        params.put("sampleWeight", txt_sampleWeight.getText().toString());
        params.put("sampleMark", txt_sampleMark.getText().toString());
        params.put("spec", txt_spec.getText().toString());

        params.put("productionDate",txt_productionDate.getText().toString());
        params.put("excStandard", txt_excStandard.getText().toString());
        params.put("project", txt_project.getText().toString());
        params.put("projectBasis", txt_projectBasis.getText().toString());
        params.put("producer", txt_producer.getText().toString());
        params.put("producerAddress", txt_producerAddress.getText().toString());

        params.put("takeWay", takeWay);

        if(cacheModel != null){
            params.put("id", cacheModel.getId());
        }
        WaitDialog.show(DelegateApplyActivity.this, "正在提交...");
        userRepository.postApplyEntrustInspect(params).observe(DelegateApplyActivity.this, new Observer<BaseDto<ApplyModel>>() {
            @Override
            public void onChanged(BaseDto<ApplyModel> applyModelBaseDto) {

                if (applyModelBaseDto.getCode().equals(Constant.RespCode.R200)) {
                    TipDialog.show(DelegateApplyActivity.this, "成功！", TipDialog.TYPE.SUCCESS).setOnDismissListener(new OnDismissListener() {
                        @Override
                        public void onDismiss() {
                            if(!type.equals("")){
                                Intent intent = new Intent(DelegateApplyActivity.this,DelegateRecordActivity.class);
                                setResult(1000, intent);// 设置resultCode，记住一定要大于等于0噢！！！返回到FirstActivity
                            }
                            finish();
                        }
                    });

                } else {
                    TipDialog.show(DelegateApplyActivity.this, applyModelBaseDto.getMessage(), TipDialog.TYPE.WARNING);
                }

            }
        });



    }
    //暂存
    private void saveClick() {

        Map<String, String> params = new HashMap<>();
        params.put("entrustOrgId",model.getId());
        params.put("inspectOrgId", inspectOrgId);
        params.put("sampleName", txt_sampleName.getText().toString());
        params.put("sampleNum", txt_sampleNum.getText().toString());
        params.put("sampleQuantity", txt_sampleQuantity.getText().toString());
        params.put("sampleWeight", txt_sampleWeight.getText().toString());
        params.put("sampleMark", txt_sampleMark.getText().toString());
        params.put("spec", txt_spec.getText().toString());

        params.put("productionDate",txt_productionDate.getText().toString());
        params.put("excStandard", txt_excStandard.getText().toString());
        params.put("project", txt_project.getText().toString());
        params.put("projectBasis", txt_projectBasis.getText().toString());
        params.put("producer", txt_producer.getText().toString());
        params.put("producerAddress", txt_producerAddress.getText().toString());

        params.put("takeWay", takeWay);

        if(cacheModel != null){
            params.put("id", cacheModel.getId());
        }
        WaitDialog.show(DelegateApplyActivity.this, "正在提交...");
        userRepository.postCache(params).observe(DelegateApplyActivity.this, new Observer<BaseDto<EntrustInspectModel.ContentBean>>() {
            @Override
            public void onChanged(BaseDto<EntrustInspectModel.ContentBean> contentBeanBaseDto) {

                if (contentBeanBaseDto.getCode().equals(Constant.RespCode.R200)) {

                    TipDialog.show(DelegateApplyActivity.this, "成功！", TipDialog.TYPE.SUCCESS).setOnDismissListener(new OnDismissListener() {
                        @Override
                        public void onDismiss() {
                            finish();
                        }
                    });

                } else {
                    TipDialog.show(DelegateApplyActivity.this, contentBeanBaseDto.getMessage(), TipDialog.TYPE.WARNING);
                }

            }
        });


    }
    //处理点击注册事件
    @OnClick({R.id.btn_save,R.id.btn_submit})
    public void submit(View v) {
        if(v.getId() == R.id.btn_submit){
            Validate.check(this, new IValidateResult() {
                @Override
                public void onValidateSuccess() {
                    submitClick();
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
        } else {
            saveClick();
        }

    }
    protected void onDestroy() {
        super.onDestroy();

    }

}