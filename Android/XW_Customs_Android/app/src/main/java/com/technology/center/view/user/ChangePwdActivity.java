package com.technology.center.view.user;


import android.view.View;
import android.view.animation.Animation;
import android.widget.Button;
import android.widget.TextView;

import com.technology.center.utils.GsonUtil;
import com.technology.center.utils.ToastUtil;
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

    @Index(1)
    @NotNull(msg = "原始密码不能为空")
    @MinLength(length = 6, msg = "请输入正确的原始密码")
    private TextView oldPwdText;

    @Index(2)
    @NotNull(msg = "密码不能为空")
    @MinLength(length = 7, msg = "最少为7位到18位密码")
    @RE(re = "^(?![\\d]+$)(?![a-zA-Z]+$)(?![^\\da-zA-Z]+$).{7,18}$", msg = "密码至少包含字母、数字、符号两种类型(7-18位)")
    private TextView newPwdText;

    private Button btnReset;


    @Override
    protected int getLayoutId() {
        return R.layout.activity_change_pwd;
    }

    @Override
    protected void onViewCreated() {



        oldPwdText = findViewById(R.id.tv_old_password);
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
        Map<String, String> params = new HashMap<>();
//        LoginDto loginDto = GsonUtil.fromJson(spUtils.getString("userInfo"), LoginDto.class);

//        params.put("phone", loginDto.getPhone());
        params.put("password", oldPwdText.getText().toString());
        params.put("newPassword", newPwdText.getText().toString());

//        dialog.show();
//        userViewModel.modifyPassword(params).observe(ChangePwdActivity.this, new Observer<BaseDto<String>>() {
//            @Override
//            public void onChanged(BaseDto<String> rs) {
//                dialog.hide();
//                if (rs.getCode().equals(Constant.RespCode.R200)) {
//                    ToastUtil.show(getBaseContext(), "密码重置成功");
//                    finish();
//                } else {
//                    switch (rs.getCode()) {
//                        case "1002":
//                            ToastUtil.show(getBaseContext(), "验证码错误");
//                            break;
//
//                        case "1006":
//                            ToastUtil.show(getBaseContext(), "帐号未注册，请注册");
//                            break;
//                        default:
//                            ToastUtil.show(getBaseContext(), rs.getMsg());
//                            break;
//                    }
//
//                }
//            }
//        });
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
