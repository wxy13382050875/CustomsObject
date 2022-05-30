package com.technology.center.view.custom;


import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.util.Base64;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;

import androidx.lifecycle.Observer;
import androidx.print.PrintHelper;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.technology.center.Constant;
import com.technology.center.R;
import com.technology.center.http.base.BaseDto;
import com.technology.center.model.EntrustInspectModel;
import com.technology.center.repository.impl.UserRepository;
import com.technology.center.utils.ToastUtil;
import com.technology.center.view.base.BaseActionBarActivity;
import com.wuhenzhizao.titlebar.widget.CommonTitleBar;

import java.util.HashMap;
import java.util.Map;

import butterknife.BindView;
import butterknife.ButterKnife;
import cxy.com.validate.Validate;

public class MyQrActivity extends BaseActionBarActivity {


    private static final String TAG = "PaymentServicesActivity";
    private final UserRepository userRepository = new UserRepository();
    @BindView(R.id.iv_qr)
    ImageView QrImage;
    private EntrustInspectModel.ContentBean model;


    private Bitmap decodedByte;
    protected int getLayoutId() {
        return R.layout.activity_my_qr;
    }

    @Override
    protected void onViewCreated() {
        initView();
        Validate.reg(this);
    }

    @Override
    protected void initEventAndData() {
        Bundle bundle = this.getIntent().getExtras();
        if (bundle != null) {
            // 从bundle数据包中取出数据
            model = (EntrustInspectModel.ContentBean) bundle.getSerializable("model");
            getQrCode();

        }

    }
    //初始化控件
    private void initView() {
        ButterKnife.bind(this);
        commonTitleBar.setListener(new CommonTitleBar.OnTitleBarListener() {
            @Override
            public void onClicked(View v, int action, String extra) {
                if (action == CommonTitleBar.ACTION_RIGHT_TEXT) {
                    Log.d(TAG,"打印");
                    doPhotoPrint();
                }
                // CommonTitleBar.ACTION_LEFT_TEXT;        // 左边TextView被点击
                // CommonTitleBar.ACTION_LEFT_BUTTON;      // 左边ImageBtn被点击
                // CommonTitleBar.ACTION_RIGHT_TEXT;       // 右边TextView被点击
                // CommonTitleBar.ACTION_RIGHT_BUTTON;     // 右边ImageBtn被点击
                // CommonTitleBar.ACTION_SEARCH;           // 搜索框被点击,搜索框不可输入的状态下会被触发
                // CommonTitleBar.ACTION_SEARCH_SUBMIT;    // 搜索框输入状态下,键盘提交触发，此时，extra为输入内容
                // CommonTitleBar.ACTION_SEARCH_VOICE;     // 语音按钮被点击
                // CommonTitleBar.ACTION_SEARCH_DELETE;    // 搜索删除按钮被点击
                // CommonTitleBar.ACTION_CENTER_TEXT;      // 中间文字点击

            }
        });

    }
    private void doPhotoPrint() {
        PrintHelper photoPrinter = new PrintHelper(getBaseContext());
        photoPrinter.setScaleMode(PrintHelper.SCALE_MODE_FIT);

        photoPrinter.printBitmap("打印我的二维码", decodedByte);
    }
//    /**
//     * 生成固定大小的二维码(不需网络权限)
//     *
//     * @param content 需要生成的内容
//     * @param width   二维码宽度
//     * @param height  二维码高度
//     * @return
//     */
//    private Bitmap generateBitmap(String content, int width, int height) {
//        QRCodeWriter qrCodeWriter = new QRCodeWriter();
//        Map<EncodeHintType, String> hints = new HashMap<>();
//        hints.put(EncodeHintType.CHARACTER_SET, "utf-8");
//        try {
//            BitMatrix encode = qrCodeWriter.encode(content, BarcodeFormat.QR_CODE, width, height, hints);
//            int[] pixels = new int[width * height];
//            for (int i = 0; i < height; i++) {
//                for (int j = 0; j < width; j++) {
//                    if (encode.get(j, i)) {
//                        pixels[i * width + j] = 0x00000000;
//                    } else {
//                        pixels[i * width + j] = 0xffffffff;
//                    }
//                }
//            }
//            return Bitmap.createBitmap(pixels, 0, width, width, height, Bitmap.Config.RGB_565);
//        } catch (WriterException e) {
//            e.printStackTrace();
//        }
//        return null;
//    }
    private void getQrCode(){
        userRepository.getQrCode(model.getId()).observe(MyQrActivity.this, new Observer<BaseDto<String>>() {
            @Override
            public void onChanged(BaseDto<String> stringBaseDto) {
                if (stringBaseDto.getCode().equals(Constant.RespCode.R200)) {
                    String base64 = stringBaseDto.getData();
                    byte[] decodedString = Base64.decode(base64, Base64.DEFAULT);
                    decodedByte = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);
                    QrImage.setImageBitmap(decodedByte);
                } else {
                    ToastUtil.show(getBaseContext(), stringBaseDto.getMessage());
                }

            }
        });
    }
}