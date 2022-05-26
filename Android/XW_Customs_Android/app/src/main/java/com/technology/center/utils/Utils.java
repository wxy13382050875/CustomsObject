package com.technology.center.utils;

import android.content.Context;
import android.content.res.Resources;
import android.graphics.Point;
import android.os.Build;
import android.view.Display;
import android.view.KeyCharacterMap;
import android.view.KeyEvent;
import android.view.ViewConfiguration;
import android.view.WindowManager;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import java.math.RoundingMode;
import java.text.DecimalFormat;

public class Utils {
    /**
     * 格式化
     */
    private static DecimalFormat dfs = null;

    public static DecimalFormat format(String pattern) {
        if (dfs == null) {
            dfs = new DecimalFormat();
        }
        dfs.setRoundingMode(RoundingMode.FLOOR);
        dfs.applyPattern(pattern);
        return dfs;
    }

    /**
     * 判断你一个类是否存在某个属性（字段）
     *
     * @param field 字段
     * @param obj   类对象
     * @return true:存在，false:不存在, null:参数不合法
     */
    public static Boolean isExistField(String field, Object obj) {
        Object o = JSON.toJSON(obj);
        JSONObject jsonObj = new JSONObject();
        if (o instanceof JSONObject) {
            jsonObj = (JSONObject) o;
        }
        return jsonObj.containsKey(field);
    }

    /**
     * 获取屏幕的宽高
     *
     * @param context 字段
     * @return true:存在，false:不存在, null:参数不合法
     */
    public static Point getWindowManagerSize(Context context) {
        WindowManager windowManager = (WindowManager) context.getApplicationContext().getSystemService(Context.WINDOW_SERVICE);
        Display display = windowManager.getDefaultDisplay();
        Point outPoint = new Point();
        if (Build.VERSION.SDK_INT >= 19) {
            // 可能有虚拟按键的情况
            display.getRealSize(outPoint);
        } else {
            // 不可能有虚拟按键
            display.getSize(outPoint);
        }
        return outPoint;
    }
    /**
     * 获取是否有虚拟按键
     * 通过判断是否有物理返回键反向判断是否有虚拟按键
     * @param context
     * @return
     */
    public static boolean checkDeviceHasNavigationBar(Context context) {

        boolean hasMenuKey = ViewConfiguration.get(context)
                .hasPermanentMenuKey();
        boolean hasBackKey = KeyCharacterMap
                .deviceHasKey(KeyEvent.KEYCODE_BACK);
        if (!hasMenuKey & !hasBackKey) {
            // 做任何你需要做的,这个设备有一个导航栏
            return true;
        }
        return false;
    }
    //获取虚拟按键的高度
    public static int getNavigationBarHeight(Context context) {
        int result = 0;
        if (!checkDeviceHasNavigationBar(context)) {
            Resources res = context.getResources();
            int resourceId = res.getIdentifier("navigation_bar_height", "dimen", "android");
            if (resourceId > 0) {
                result = res.getDimensionPixelSize(resourceId);
            }
        }
        return result;
    }
    //获取虚拟按键的高度
    public static int getStatusBarHeight(Context context) {
        Resources res = context.getResources();
        int resourceId = res.getIdentifier("status_bar_height", "dimen", "android");

        return res.getDimensionPixelSize(resourceId);
    }
    /**
     * dp转px
     */
    public static int dp2px(Context ctx, float dp) {
        float density = ctx.getResources().getDisplayMetrics().density;
        int px = (int) (dp * density + 0.5f);// 4.9->5 4.4->4

        return px;
    }

    /**
     * px转dp
     */
    public static float px2dp(Context ctx, int px) {
        float density = ctx.getResources().getDisplayMetrics().density;
        float dp = px / density;

        return dp;
    }

}

