package com.technology.center.view.user;


import android.util.Log;
import android.view.View;
import android.view.animation.Animation;
import android.widget.Button;
import android.widget.TextView;

import androidx.lifecycle.Observer;

import com.technology.center.Constant;
import com.technology.center.http.base.BaseDto;
import com.technology.center.model.CurrentUserModel;
import com.technology.center.repository.impl.UserRepository;
import com.technology.center.utils.GsonUtil;
import com.technology.center.utils.MD5Utils;
import com.technology.center.utils.ToastUtil;
import com.technology.center.utils.Utils;
import com.technology.center.view.base.BaseActionBarActivity;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import com.technology.center.R;
import cxy.com.validate.IValidateResult;
import cxy.com.validate.Validate;
import cxy.com.validate.annotation.Index;
import cxy.com.validate.annotation.MinLength;
import cxy.com.validate.annotation.NotNull;
import cxy.com.validate.annotation.RE;

public class ChangePwdActivity extends BaseActionBarActivity {

//    @Index(1)
//    @NotNull(msg = "原始密码不能为空")
//    @MinLength(length = 6, msg = "请输入正确的原始密码")
//    private TextView oldPwdText;

    @Index(2)
    @NotNull(msg = "密码不能为空")
//    @RE(re = "^(?![\\d]+$)(?![a-zA-Z]+$)(?![^\\da-zA-Z]+$).{7,18}$", msg = "密码至少包含字母、数字、符号两种类型(7-18位)")
    private TextView newPwdText;

    private Button btnReset;
    private final UserRepository userRepository = new UserRepository();

    @Override
    protected int getLayoutId() {
        return R.layout.activity_change_pwd;
    }

    @Override
    protected void onViewCreated() {



//        oldPwdText = findViewById(R.id.tv_old_password);
        newPwdText = findViewById(R.id.tv_new_password);
        btnReset = findViewById(R.id.btnReset);

        Validate.reg(this);


    }

    @Override
    protected void initEventAndData() {
        btnReset.setOnClickListener(view -> {
            submit();
        });


    }


    //处理点击注册事件
    private void submit() {
        Validate.check(this, new IValidateResult() {
            @Override
            public void onValidateSuccess() {
                modifyPasswordSubmit();
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

    private void modifyPasswordSubmit() {

        CurrentUserModel userModel = GsonUtil.fromJson(spUtils.getString("userInfo"), CurrentUserModel.class);

        Map<String, String> params = new HashMap<>();
        params.put("id", userModel.getId());
        params.put("password", newPwdText.getText().toString());

//        dialog.show();
        userRepository.updatePassword(params).observe(ChangePwdActivity.this, new Observer<BaseDto<CurrentUserModel>>() {
            @Override
            public void onChanged(BaseDto<CurrentUserModel> currentUserModelBaseDto) {
                finish();
            }
        });
    }


    @Override
    protected void onDestroy() {
        super.onDestroy();
        Validate.unreg(this);
//        if (dialog != null) {
//            dialog.dismiss();
//        }
    }
}
