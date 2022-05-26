package com.technology.center.utils;

import android.os.CountDownTimer;
import android.view.View;
import android.widget.Button;


public class TimeCount extends CountDownTimer {
    private Button btn_send;

    public TimeCount(long millisInFuture, long countDownInterval, View btn) {
        super(millisInFuture, countDownInterval);
        this.btn_send = (Button) btn;
    }

    @Override
    public void onTick(long l) {
        btn_send.setClickable(false);
        btn_send.setText(l / 1000 + "秒后重发");
    }

    @Override
    public void onFinish() {

        btn_send.setText("重新发送");
        btn_send.setClickable(true);
        btn_send.setAlpha(1f);
    }
}
