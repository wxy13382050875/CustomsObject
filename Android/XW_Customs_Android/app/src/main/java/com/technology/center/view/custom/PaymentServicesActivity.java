package com.technology.center.view.custom;


import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Base64;
import android.view.View;
import android.view.animation.Animation;
import android.widget.EditText;
import android.widget.ImageView;

import androidx.lifecycle.Observer;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.technology.center.R;
import com.technology.center.Constant;
import com.technology.center.http.base.BaseDto;
import com.technology.center.repository.impl.UserRepository;
import com.technology.center.utils.SpUtils;
import com.technology.center.utils.ToastUtil;
import com.technology.center.utils.Utils;
import com.technology.center.view.base.BaseActionBarActivity;

import java.util.HashMap;
import java.util.Map;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import butterknife.Optional;
import cxy.com.validate.IValidateResult;
import cxy.com.validate.Validate;
import cxy.com.validate.annotation.Index;
import cxy.com.validate.annotation.MaxLength;
import cxy.com.validate.annotation.NotNull;
import cxy.com.validate.annotation.RE;

public class PaymentServicesActivity extends BaseActionBarActivity {


    private static final String TAG = "PaymentServicesActivity";
    private final UserRepository userRepository = new UserRepository();
    @BindView(R.id.iv_qr)
    ImageView QrImage;


    protected int getLayoutId() {
        return R.layout.activity_payment_services;
    }

    @Override
    protected void onViewCreated() {
        initView();
        Validate.reg(this);
    }

    @Override
    protected void initEventAndData() {
        getQrCode();
    }
    //初始化控件
    private void initView() {
        ButterKnife.bind(this);
//        QrImage.setImageBitmap(generateBitmap("海关技术中心", Utils.dp2px(this,120), Utils.dp2px(this,120)));


    }

    /**
     * 生成固定大小的二维码(不需网络权限)
     *
     * @param content 需要生成的内容
     * @param width   二维码宽度
     * @param height  二维码高度
     * @return
     */
    private Bitmap generateBitmap(String content, int width, int height) {
        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        Map<EncodeHintType, String> hints = new HashMap<>();
        hints.put(EncodeHintType.CHARACTER_SET, "utf-8");
        try {
            BitMatrix encode = qrCodeWriter.encode(content, BarcodeFormat.QR_CODE, width, height, hints);
            int[] pixels = new int[width * height];
            for (int i = 0; i < height; i++) {
                for (int j = 0; j < width; j++) {
                    if (encode.get(j, i)) {
                        pixels[i * width + j] = 0x00000000;
                    } else {
                        pixels[i * width + j] = 0xffffffff;
                    }
                }
            }
            return Bitmap.createBitmap(pixels, 0, width, width, height, Bitmap.Config.RGB_565);
        } catch (WriterException e) {
            e.printStackTrace();
        }
        return null;
    }
    private void getQrCode(){
        userRepository.getQrCode("125").observe(PaymentServicesActivity.this, new Observer<BaseDto<String>>() {
            @Override
            public void onChanged(BaseDto<String> stringBaseDto) {
                if (stringBaseDto.getCode().equals(Constant.RespCode.R200)) {
                    String base64 = stringBaseDto.getData();
                    byte[] decodedString = Base64.decode(base64, Base64.DEFAULT);
                    Bitmap decodedByte = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);
                    QrImage.setImageBitmap(decodedByte);
                } else {
                    ToastUtil.show(getBaseContext(), stringBaseDto.getMessage());
                }

            }
        });
    }
}