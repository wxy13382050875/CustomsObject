package com.chason.lottieview;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Color;
import android.graphics.drawable.Drawable;
import android.text.TextUtils;
import android.util.AttributeSet;
import android.util.Log;
import android.util.TypedValue;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.airbnb.lottie.LottieAnimationView;
import com.airbnb.lottie.LottieCompositionFactory;
import com.blankj.utilcode.util.SizeUtils;


public class LottieTabView extends FrameLayout {
    private int mTextNormalColor;
    private int mTextSelectColor;
    private float mTextSize;
    private String mTabName;
    private Drawable mIconNormal;
    private String mAnimationPath;
    private LottieAnimationView mLottieView;
    private TextView mTabNameView;
    private TextView mMsgView;
    private boolean isSelected;
    boolean floatingEnable;
    public LottieTabView(Context context) {
        super(context);
    }

    public LottieTabView(Context context, AttributeSet attrs) {
        super(context, attrs);
        init(context, attrs);
    }

    public LottieTabView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        init(context, attrs);
    }


    private void init(Context context, AttributeSet attrs) {
        TypedArray ta = context.obtainStyledAttributes(attrs, R.styleable.LottieTabView);
        mTextNormalColor = ta.getColor(R.styleable.LottieTabView_text_normal_color, Color.BLACK);
        mTextSelectColor = ta.getColor(R.styleable.LottieTabView_text_selected_color, Color.BLUE);
        mTextSize = ta.getDimension(R.styleable.LottieTabView_text_size, SizeUtils.dp2px(5));
        mIconNormal = ta.getDrawable(R.styleable.LottieTabView_icon_normal);
        mAnimationPath = ta.getString(R.styleable.LottieTabView_lottie_path);
        mTabName = ta.getString(R.styleable.LottieTabView_tab_name);
        isSelected = ta.getBoolean(R.styleable.LottieTabView_tab_selected, false);
        floatingEnable = ta.getBoolean(R.styleable.LottieTabView_oneFloatingEnable, false);
        ta.recycle();
        initView(context);
    }

    private void initView(Context context) {
        View containView = LayoutInflater.from(context).inflate(R.layout.lottie_tab_view, null, false);
        mLottieView = containView.findViewById(R.id.animation_view);
        mLottieView.setRepeatCount(0);
        mTabNameView = containView.findViewById(R.id.tab_name);
        mTabNameView.setTextSize(TypedValue.COMPLEX_UNIT_PX, mTextSize);
        mTabNameView.setTextColor(mTextNormalColor);
        mTabNameView.setText(mTabName);
        mMsgView = containView.findViewById(R.id.msg_view);
        this.addView(containView);

        if (floatingEnable){
            LinearLayout.LayoutParams params = (LinearLayout.LayoutParams) mLottieView.getLayoutParams();
            Log.d("---selected--","params.topMargin = "+params.topMargin +"");
//            params.topMargin = 0;
//                if (params.topMargin == 0)
            {
                params.width = SizeUtils.dp2px(72);
                params.height = params.height + SizeUtils.dp2px(15);
                params.topMargin = params.topMargin - SizeUtils.dp2px(15);
                mLottieView.setLayoutParams(params);
            }

        }
        if (isSelected) {
            selected();
        } else {
            unSelected();
        }
    }



    /**
     * 选中状态
     */
    public void selected() {
        if (TextUtils.isEmpty(mAnimationPath)) {
            throw new NullPointerException("ainmation path must be not empty");
        } else {
//取控件当前的布局参数



            mLottieView.setAnimation(mAnimationPath);
            mLottieView.playAnimation();
            mTabNameView.setTextColor(mTextSelectColor);
//            if (floatingEnable){
//                LinearLayout.LayoutParams params = (LinearLayout.LayoutParams) mLottieView.getLayoutParams();
//                Log.d("---selected--","params.topMargin = "+params.topMargin +"");
//                params.topMargin = 0;
////                if (params.topMargin == 0)
//                {
//                    params.width = SizeUtils.dp2px(72);
//                    params.height = params.height + SizeUtils.dp2px(15);
//                    params.topMargin = params.topMargin - SizeUtils.dp2px(15);
//                    mLottieView.setLayoutParams(params);
//                }
//
//            }
        }
    }

    /**
     * 未选中
     */
    public void unSelected() {

//        if (floatingEnable){
//            LinearLayout.LayoutParams params = (LinearLayout.LayoutParams) mLottieView.getLayoutParams();
//            Log.d("---unSelected--","params.topMargin = "+params.topMargin +"");
//            params.topMargin = 0;
////            if (params.topMargin <= 0)
//            {
//                params.width = SizeUtils.dp2px(72);
//                params.height = params.height + SizeUtils.dp2px(15);
//                params.topMargin = params.topMargin - SizeUtils.dp2px(15);
//                mLottieView.setLayoutParams(params);
//            }
//
//        }

        mTabNameView.setTextColor(mTextNormalColor);
        mLottieView.clearAnimation();
        mLottieView.setImageDrawable(mIconNormal);
    }

    /**
     * 显示红点消息数，默认不显示
     * @param num
     */
    public void showMsg(int num) {
        if (num > 0 && num <= 99) {
            mMsgView.setVisibility(VISIBLE);
            mMsgView.setText(num + "");
        } else if (num > 99) {
            mMsgView.setVisibility(VISIBLE);
            mMsgView.setText("99+");
        } else {
            mMsgView.setVisibility(View.INVISIBLE);
        }
    }
    public void setImageAssetsFolder(String imageAssetsFolder) {
        mLottieView.setImageAssetsFolder(imageAssetsFolder);
    }
    public void setAnimation(String assetName) {
        mLottieView.setAnimation(assetName);

    }
    public void setNormalImageDrawable(Drawable drawable) {
        mLottieView.setImageDrawable(drawable);
    }
}
