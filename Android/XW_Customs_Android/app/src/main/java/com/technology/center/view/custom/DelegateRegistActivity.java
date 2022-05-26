package com.technology.center.view.custom;


import android.view.View;
import android.view.animation.Animation;
import android.widget.Button;
import android.widget.EditText;

import androidx.lifecycle.Observer;

import com.github.gzuliyujiang.wheelpicker.OptionPicker;
import com.github.gzuliyujiang.wheelpicker.contract.OnOptionPickedListener;
import com.github.gzuliyujiang.wheelpicker.contract.OnOptionSelectedListener;
import com.google.gson.reflect.TypeToken;
import com.kongzue.dialog.interfaces.OnDismissListener;
import com.kongzue.dialog.v3.TipDialog;
import com.kongzue.dialog.v3.WaitDialog;
import com.technology.center.R;
import com.technology.center.Constant;
import com.technology.center.http.base.BaseDto;
import com.technology.center.model.DictAllModel;
import com.technology.center.model.EntrustInspectModel;
import com.technology.center.model.CurrentUserModel;
import com.technology.center.model.EntrustOrgModel;
import com.technology.center.repository.impl.UserRepository;
import com.technology.center.utils.GsonUtil;
import com.technology.center.utils.MyDictUtils;
import com.technology.center.utils.SpUtils;
import com.technology.center.utils.ToastUtil;
import com.technology.center.view.base.BaseActionBarActivity;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import butterknife.BindView;
import butterknife.BindViews;
import butterknife.ButterKnife;
import butterknife.OnClick;
import cxy.com.validate.IValidateResult;
import cxy.com.validate.Validate;
import cxy.com.validate.annotation.Index;
import cxy.com.validate.annotation.MaxLength;
import cxy.com.validate.annotation.NotNull;
import cxy.com.validate.annotation.RE;

public class DelegateRegistActivity extends BaseActionBarActivity {


    private static final String TAG = "DelegateRegistActivity";
    private final UserRepository userRepository = new UserRepository();
    private String userId;
    private String orgType;
    private EntrustOrgModel model = new EntrustOrgModel();
    @Index(1)
    @NotNull(msg = "企业类型不能为空！")
//    @MaxLength(length = 11, msg = "请输入企业类型")
    @BindView(R.id.txt_type)
    EditText txttype;

    @Index(2)
    @NotNull(msg = "单位名称不能为空！")
//    @MaxLength(length = 11, msg = "请输入单位名称")
    @BindView(R.id.txt_name)
    EditText txtname;

    @Index(3)
    @NotNull(msg = "营业执照不能为空！")
//    @MaxLength(length = 11, msg = "请输入营业执照")
    @BindView(R.id.txt_papersNo)
    EditText txtpapersNo;

    @Index(4)
    @NotNull(msg = "地址")
//    @MaxLength(length = 11, msg = "请输入地址")
    @BindView(R.id.txt_address)
    EditText txtaddress;

    @Index(5)
    @NotNull(msg = "联系人不能为空！")
//    @MaxLength(length = 11, msg = "请输入联系人")
    @BindView(R.id.txt_contacts)
    EditText txtcontacts;

    @Index(6)
    @NotNull(msg = "电话不能为空！")
    @MaxLength(length = 11, msg = "请输入电话")
    @BindView(R.id.txt_phone)
    EditText txtphone;

//    @Index(7)
//    @NotNull(msg = "传真不能为空！")
//    @MaxLength(length = 11, msg = "请输入传真")
    @BindView(R.id.txt_fax)
    EditText txtfax;

    @Index(8)
    @NotNull(msg = "邮箱不能为空！")
    @RE(re = RE.email, msg = "请输入正确的邮箱")
    @BindView(R.id.txt_email)
    EditText txtemail;

    @Override
    protected int getLayoutId() {
        return R.layout.activity_delegate_regist;
    }

    @Override
    protected void onViewCreated() {
        spUtils = new SpUtils(getBaseContext());
        CurrentUserModel model = GsonUtil.fromJson(spUtils.getString("userInfo"), CurrentUserModel.class);
        userId = model.getId();
        initView();
        Validate.reg(this);
    }

    @Override
    protected void initEventAndData() {

        model = GsonUtil.fromJson(spUtils.getString("entrustOrg"), EntrustOrgModel.class);
        if(model != null){

            MyDictUtils myUtils = new MyDictUtils(getBaseContext());
            txttype.setText(myUtils.getDictNameBySubCode("ENTRUST_ORG_TYPE",model.getType()));
            txtname.setText(model.getName());
            txtpapersNo.setText(model.getPapersNo());
            txtaddress.setText(model.getAddress());
            txtcontacts.setText(model.getContacts());
            txtphone.setText(model.getPhone());
            txtfax.setText(model.getFax());
            txtemail.setText(model.getEmail());
        }
    }
    //初始化控件
    private void initView() {
        ButterKnife.bind(this);
        txttype.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                showPicker();
            }
        });
    }
    private void showPicker(){

        MyDictUtils myUtils = new MyDictUtils(getBaseContext());
        List<DictAllModel.ItemsBean>  currentItems = myUtils.getDictItemByCode("ENTRUST_ORG_TYPE");

        OptionPicker picker = new OptionPicker(this);
        picker.setData(currentItems);
        picker.setOnOptionPickedListener(new OnOptionPickedListener() {
            @Override
            public void onOptionPicked(int position, Object item) {
                DictAllModel.ItemsBean dictModel = (DictAllModel.ItemsBean)item;
                txttype.setText(dictModel.getName());
                orgType = dictModel.getCode();
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
    //提交注册
    private void saveClick() {
        Map<String, String> params = new HashMap<>();
        params.put("userId",userId);
        params.put("name", txtname.getText().toString());
        params.put("type", orgType);
        params.put("papersNo", txtpapersNo.getText().toString());
        params.put("address", txtaddress.getText().toString());
        params.put("contacts", txtcontacts.getText().toString());
        params.put("phone", txtphone.getText().toString());
        params.put("fax", txtfax.getText().toString());
        params.put("email", txtemail.getText().toString());
        WaitDialog.show(DelegateRegistActivity.this, "正在提交...");
        if(model != null){
            params.put("id",model.getId());
            userRepository.putEntrustOrg(model.getId(),params).observe(DelegateRegistActivity.this, new Observer<BaseDto<EntrustOrgModel>>() {
                @Override
                public void onChanged(BaseDto<EntrustOrgModel> entrustOrgModelBaseDto) {
                    if (entrustOrgModelBaseDto.getCode().equals(Constant.RespCode.R200)) {
                        TipDialog.show(DelegateRegistActivity.this, "保存成功！", TipDialog.TYPE.SUCCESS).setOnDismissListener(new OnDismissListener() {
                            @Override
                            public void onDismiss() {
                                spUtils.putString("entrustOrg", GsonUtil.toJson(entrustOrgModelBaseDto.getData()));
                                finish();
                            }
                        });

                    } else {
                        TipDialog.show(DelegateRegistActivity.this, entrustOrgModelBaseDto.getMessage(), TipDialog.TYPE.WARNING);
                    }
                }
            });
        } else {
            params.put("userId",userId);
            userRepository.postEntrustOrg(params).observe(DelegateRegistActivity.this, new Observer<BaseDto<EntrustOrgModel>>() {
                @Override
                public void onChanged(BaseDto<EntrustOrgModel> entrustOrgModelBaseDto) {
                    if (entrustOrgModelBaseDto.getCode().equals(Constant.RespCode.R200)) {
                        TipDialog.show(DelegateRegistActivity.this, "暂存成功！", TipDialog.TYPE.SUCCESS).setOnDismissListener(new OnDismissListener() {
                            @Override
                            public void onDismiss() {
                                spUtils.putString("entrustOrg", GsonUtil.toJson(entrustOrgModelBaseDto.getData()));
                                finish();
                            }
                        });

                    } else {
                        TipDialog.show(DelegateRegistActivity.this, entrustOrgModelBaseDto.getMessage(), TipDialog.TYPE.WARNING);
                    }
                }
            });
        }

    }

    //处理点击注册事件
    @OnClick(R.id.btn_save)
    public void submit() {
        Validate.check(this, new IValidateResult() {
            @Override
            public void onValidateSuccess() {
                saveClick();
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
    protected void onDestroy() {
        super.onDestroy();
    }
}