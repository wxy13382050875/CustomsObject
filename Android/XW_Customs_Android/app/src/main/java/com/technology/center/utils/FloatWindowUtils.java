package com.technology.center.utils;

import android.content.Context;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.BounceInterpolator;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.yhao.floatwindow.FloatWindow;
import com.yhao.floatwindow.MoveType;
import com.yhao.floatwindow.PermissionListener;
import com.yhao.floatwindow.ViewStateListener;

import com.technology.center.R;

/**
 * app更新工具类
 */
public class FloatWindowUtils {
    private static final String TAG = "FloatWindowUtils";
    private static Context mContext;


    public FloatWindowUtils(Context baseContext) {
        this.mContext = baseContext;
    }

    public void showWindow( @NonNull Class... activities){

        //        MoveType.slide : 可拖动，释放后自动贴边 （默认）
//        MoveType.back : 可拖动，释放后自动回到原位置
//        MoveType.active : 可拖动
//        MoveType.inactive : 不可拖动
        int moveType = MoveType.slide;


        int offset_X = 0;
        int offset_Y = 0;
        String localtion ="bottom-left";

        int mRealSizeWidth = com.technology.center.utils.Utils.getWindowManagerSize(mContext).x;//手机屏幕真实宽度
        int mRealSizeHeight =com.technology.center.utils.Utils.getWindowManagerSize(mContext).y;//手机屏幕真实高度

//        LayoutInflater inflater = (LayoutInflater)mContext.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
//        View child = inflater.inflate(R.layout.float_image_display, null);
//
//
//        ImageView imageView = (ImageView)child.findViewById(R.id.image_display_imageview);
//        imageView.setImageResource(R.drawable.image1);


        FrameLayout layout = new FrameLayout(mContext);
//        FrameLayout.LayoutParams layoutParam = new FrameLayout.LayoutParams(DensityUtil.px2dip(mContext,500),DensityUtil.px2dip(mContext,300));
        FrameLayout.LayoutParams viewParam = new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.WRAP_CONTENT,
                ViewGroup.LayoutParams.WRAP_CONTENT);
        ImageView img = new ImageView(mContext);
        img.setImageResource(R.drawable.image1);

        LinearLayout linearLayout = new LinearLayout(mContext);
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT,
                ViewGroup.LayoutParams.WRAP_CONTENT);
        params.gravity = Gravity.RIGHT;

        ImageView imageView = new ImageView(mContext);
        imageView.setImageResource(R.drawable.ic_about_app);
        layout.addView(img,viewParam);
        layout.addView(linearLayout,viewParam);
        linearLayout.addView(imageView,params);

//        // 等待ImageVivew加载完成
//        imageView.post(new Runnable() {
//
//            @Override
//            public void run() {
//                // TODO Auto-generated method stub
//                // ImageView的宽和高，
//                Log.i(TAG, "iv_W = " + imageView.getWidth() + ", iv_H = " + imageView.getHeight());
//                // 显示的逻辑密度==密度/160
//                float density = mContext.getResources().getDisplayMetrics().density;
//                // 通过getIntrinsic 获得ImageView中Image的真实宽高，
//                int dw = (int) (imageView.getDrawable().getBounds().width()/density);
//                int dh = (int) (imageView.getDrawable().getBounds().height()/density);
//                Log.i(TAG, mContext.getResources().getDisplayMetrics().density
//                        +"drawable_X = " + dw + ", drawable_Y = " + dh);
//                // 通过get获得ImageView中Image的真实宽高，
//                int inDw = (int) (imageView.getDrawable().getIntrinsicWidth()/density); //单位是dp
//                int inDh = (int) (imageView.getDrawable().getIntrinsicHeight()/density); //单位是dp
//                Log.i(TAG, mContext.getResources().getDisplayMetrics().density
//                        +"Intrinsic_drawable_X = " + dw + ", Intrinsic_drawable_Y = " + dh);
//            }
//        });



        int mAdWidth=500;
        int mAdHeight = 300;

        if (mAdWidth > mRealSizeWidth){
            mAdWidth = mRealSizeWidth;
        }


        if (mAdHeight > mRealSizeHeight){
            mAdHeight = mRealSizeHeight;
        }

        int barHeight = com.technology.center.utils.Utils.getNavigationBarHeight(mContext);
        int statusBarHeight = com.technology.center.utils.Utils.getStatusBarHeight(mContext);


        if (localtion.equals("top-left")){
            Log.d("23456","左上");
            offset_X = 0;
            offset_Y = 0;
        } else if(localtion.equals("top")){
            offset_X = (mRealSizeWidth-mAdWidth)/2;
            offset_Y = 0;
        } else if(localtion.equals("top-right")){
            offset_X = mRealSizeWidth-mAdWidth;
            offset_Y = 0;
        } else if(localtion.equals("bottom-left")){
            offset_X = 0;
            offset_Y = mRealSizeHeight - mAdHeight - barHeight - statusBarHeight;
        } else if(localtion.equals("bottom")){
            offset_X = (mRealSizeWidth-mAdWidth)/2;
            offset_Y = mRealSizeHeight - mAdHeight -barHeight - statusBarHeight;
        } else if(localtion.equals("bottom-right")){
            offset_X = mRealSizeWidth-mAdWidth;
            offset_Y = mRealSizeHeight - mAdHeight - barHeight - statusBarHeight;
        } else if(localtion.equals("center")){
            offset_X = (mRealSizeWidth-mAdWidth)/2;
            offset_Y = (mRealSizeHeight - mAdHeight)/2;
        } else {
            offset_X = 100;
            offset_Y = 100;
        }

        FloatWindow
                .with(mContext)
                .setView(layout)
                .setWidth(mAdWidth) //设置悬浮控件宽高
                .setHeight(mAdHeight)
                .setX(offset_X)
                .setY(offset_Y)
                .setMoveType(moveType)
                .setMoveStyle(500, new BounceInterpolator())
                .setViewStateListener(mViewStateListener)
                .setPermissionListener(mPermissionListener)
                .setDesktopShow(false)
                .setFilter(true, activities)
                .build();


        imageView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Toast.makeText(mContext, "onClick", Toast.LENGTH_SHORT).show();
            }
        });

    }
    private PermissionListener mPermissionListener = new PermissionListener() {
        @Override
        public void onSuccess() {
            Log.d(TAG, "onSuccess");
        }

        @Override
        public void onFail() {
            Log.d(TAG, "onFail");
        }
    };

    private ViewStateListener mViewStateListener = new ViewStateListener() {
        @Override
        public void onPositionUpdate(int x, int y) {
            Log.d(TAG, "onPositionUpdate: x=" + x + " y=" + y);
        }

        @Override
        public void onShow() {
            Log.d(TAG, "onShow");
        }

        @Override
        public void onHide() {
            Log.d(TAG, "onHide");
        }

        @Override
        public void onDismiss() {
            Log.d(TAG, "onDismiss");
        }

        @Override
        public void onMoveAnimStart() {
            Log.d(TAG, "onMoveAnimStart");
        }

        @Override
        public void onMoveAnimEnd() {
            Log.d(TAG, "onMoveAnimEnd");
        }

        @Override
        public void onBackToDesktop() {
            Log.d(TAG, "onBackToDesktop");
        }
    };


}
