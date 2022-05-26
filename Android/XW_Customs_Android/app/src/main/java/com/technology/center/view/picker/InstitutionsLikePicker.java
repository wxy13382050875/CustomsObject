/*
 * Copyright (c) 2016-present 贵州纳雍穿青人李裕江<1032694760@qq.com>
 *
 * The software is licensed under the Mulan PSL v2.
 * You can use this software according to the terms and conditions of the Mulan PSL v2.
 * You may obtain a copy of Mulan PSL v2 at:
 *     http://license.coscl.org.cn/MulanPSL2
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FIT FOR A PARTICULAR
 * PURPOSE.
 * See the Mulan PSL v2 for more details.
 */

package com.technology.center.view.picker;

import android.app.Activity;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Bundle;
import android.view.Gravity;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.github.gzuliyujiang.dialog.DialogConfig;
import com.github.gzuliyujiang.dialog.DialogStyle;
import com.google.gson.reflect.TypeToken;
import com.technology.center.R;
import com.github.gzuliyujiang.wheelpicker.LinkagePicker;
import com.technology.center.model.CanSelectOrgsModel;
import com.technology.center.utils.MyDictUtils;
import com.technology.center.utils.SpUtils;
import com.technology.center.utils.GsonUtil;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

/**
 * @author 贵州山野羡民（1032694760@qq.com）
 * @since 2021/6/7 12:20
 */
public class InstitutionsLikePicker extends LinkagePicker {
    private int lastDialogStyle;
    private Context mContext;

    public InstitutionsLikePicker(@NonNull Activity activity) {
        super(activity, R.style.DialogTheme_Sheet);
    }


    @Override
    public void onInit(@Nullable Bundle savedInstanceState) {
        super.onInit(savedInstanceState);
        lastDialogStyle = DialogConfig.getDialogStyle();
        DialogConfig.setDialogStyle(DialogStyle.Default);
        setWidth(activity.getResources().getDisplayMetrics().widthPixels);
        setGravity(Gravity.BOTTOM);
    }

    @Override
    public void onDismiss(DialogInterface dialog) {
        super.onDismiss(dialog);
        DialogConfig.setDialogStyle(lastDialogStyle);
    }

    @Override
    protected void initData() {
        super.initData();

//        SpUtils spUtils = new SpUtils(getContext());
//        Type type = new TypeToken<ArrayList<CanSelectOrgsModel>>() {
//        }.getType();
//
//
//        List<CanSelectOrgsModel>  models = GsonUtil.fromJson(spUtils.getString("Orgs"),type );
        MyDictUtils myUtils = new MyDictUtils(getContext());
        SpUtils spUtils = new SpUtils(getContext());
        setBackgroundColor(0xFFFFFFFF);
        cancelView.setText("取消");
        cancelView.setTextSize(16);
        cancelView.setTextColor(0xFF0081FF);
        okView.setTextColor(0xFF0081FF);
        okView.setText("确定");
        okView.setTextSize(16);
        titleView.setTextColor(0xFF333333);
        titleView.setText("检测机构选择");
        titleView.setTextSize(16);
        wheelLayout.setData(new InstitutionsLikeProvider(myUtils.getOrgsList()));
        wheelLayout.setAtmosphericEnabled(true);
        wheelLayout.setVisibleItemCount(7);
        wheelLayout.setCyclicEnabled(false);
        wheelLayout.setIndicatorEnabled(true);
        wheelLayout.setIndicatorColor(0xFFDDDDDD);
        wheelLayout.setIndicatorSize((int) (contentView.getResources().getDisplayMetrics().density * 1));
        wheelLayout.setTextColor(0xFF999999);
        wheelLayout.setSelectedTextColor(0xFF333333);
        wheelLayout.setCurtainEnabled(false);
        wheelLayout.setCurvedEnabled(false);
    }

}
