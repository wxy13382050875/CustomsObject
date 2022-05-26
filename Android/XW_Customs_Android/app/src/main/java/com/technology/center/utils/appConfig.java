package com.technology.center.utils;

import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.util.Log;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;

import com.nostra13.universalimageloader.core.DisplayImageOptions;
import com.nostra13.universalimageloader.core.assist.ImageScaleType;
import com.nostra13.universalimageloader.core.display.SimpleBitmapDisplayer;

import com.technology.center.R;

/**
 * @package: com.huodao.hdphone.utils
 * @date: on 2017/8/17 16:35
 * @author: LiangJi-34
 * @describe:
 * @email:
 */

public class appConfig {


    public static DisplayImageOptions options = new DisplayImageOptions.Builder()
            .showImageOnLoading(R.drawable.img_site_gif_small) // 加载等待时显示的图片
            .showImageForEmptyUri(R.drawable.img_site_gif_small) // 加载数据为空时显示的图片
            .showImageOnFail(R.drawable.img_site_gif_small)// 加载失败时显示的图片
            .cacheInMemory(true)   //设置图片不缓存于内存中
            .resetViewBeforeLoading(true) // default
            .bitmapConfig(Bitmap.Config.RGB_565)    //设置图片的质量
            .imageScaleType(ImageScaleType.EXACTLY)
            .build();

    public static DisplayImageOptions options1 = new DisplayImageOptions.Builder()
            .showImageOnLoading(R.drawable.imgbg) // 加载等待时显示的图片
            .showImageForEmptyUri(R.drawable.imgbg) // 加载数据为空时显示的图片
            .showImageOnFail(R.drawable.imgbg)// 加载失败时显示的图片
            .considerExifParams(true)
            .displayer(new SimpleBitmapDisplayer())
            .cacheInMemory(true)   //设置图片不缓存于内存中
            .resetViewBeforeLoading(true) // default
            .bitmapConfig(Bitmap.Config.RGB_565)    //设置图片的质量
            .imageScaleType(ImageScaleType.EXACTLY)
            .build();

    public static DisplayImageOptions options_null = new DisplayImageOptions.Builder()
            .showImageOnLoading(R.drawable.img_site_gif_small) // 加载等待时显示的图片
            .showImageForEmptyUri(R.drawable.img_site_gif_small) // 加载数据为空时显示的图片
            .showImageOnFail(R.drawable.img_site_gif_small)// 加载失败时显示的图片
            .cacheInMemory(false)   //设置图片不缓存于内存中
            .resetViewBeforeLoading(true) // default
            .bitmapConfig(Bitmap.Config.RGB_565)    //设置图片的质量
            .imageScaleType(ImageScaleType.EXACTLY)
            .build();

    /**
     * 关闭软键盘
     */
    public static void closeKeybord(EditText mEditText, Context mContext) {
        InputMethodManager imm = (InputMethodManager) mContext
                .getSystemService(Context.INPUT_METHOD_SERVICE);

        imm.hideSoftInputFromWindow(mEditText.getWindowToken(), 0);
    }

    /**
     * 打开软键盘
     * @param mEditText
     * @param mContext
     */
    public static void openKeybord(EditText mEditText, Context mContext) {
        InputMethodManager imm = (InputMethodManager) mContext
                .getSystemService(Context.INPUT_METHOD_SERVICE);
        imm.showSoftInput(mEditText, InputMethodManager.RESULT_SHOWN);
        imm.toggleSoftInput(InputMethodManager.SHOW_FORCED,
                InputMethodManager.HIDE_IMPLICIT_ONLY);
    }

    /**
     * 获取umeng的渠道名称
     */
    public static String getChannelName(Context context) {
        ApplicationInfo appInfo = null;
        String name = "";
        try {
            appInfo = context.getPackageManager().getApplicationInfo(
                    context.getPackageName(), PackageManager.GET_META_DATA);
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }
        if (appInfo != null) {
            name = appInfo.metaData.getString("UMENG_CHANNEL");
        }
        return name;
    }

    public static String getVersionName(Context context) {
        String versionName = "";
        try {
            PackageManager pm = context.getPackageManager();
            PackageInfo pi = pm.getPackageInfo(context.getPackageName(), 0);
            versionName = pi.versionName;
            if (versionName == null || versionName.length() <= 0) {
                return "";
            }
        } catch (Exception e) {
            Log.e("VersionInfo", "Exception", e);
        }
        return versionName;
    }

    public static int getVersionCode(Context context) {
        int versionCode = 0;
        String versionName = "";
        try {
            PackageManager pm = context.getPackageManager();
            PackageInfo pi = pm.getPackageInfo(context.getPackageName(), 0);
            versionCode = pi.versionCode;
        } catch (Exception e) {
            Log.e("VersionInfo", "Exception", e);
        }
        return versionCode;
    }



}
