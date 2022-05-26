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

import android.content.Context;

import androidx.annotation.NonNull;

import com.github.gzuliyujiang.wheelpicker.contract.LinkageProvider;
import com.github.gzuliyujiang.wheelpicker.entity.CityEntity;
import com.github.gzuliyujiang.wheelpicker.entity.CountyEntity;
import com.google.gson.reflect.TypeToken;
import com.technology.center.model.CanSelectOrgsModel;
import com.technology.center.utils.GsonUtil;
import com.technology.center.utils.SpUtils;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.ResourceBundle;

/**
 * @author 贵州山野羡民（1032694760@qq.com）
 * @since 2021/6/7 12:22
 */
public class InstitutionsLikeProvider implements LinkageProvider {
    private List<CanSelectOrgsModel> models;
    public InstitutionsLikeProvider(List<CanSelectOrgsModel> data) {



        models = data;
    }

    @Override
    public boolean firstLevelVisible() {
        return true;
    }

    @Override
    public boolean thirdLevelVisible() {
        return true;
    }

    @NonNull
    @Override
    public List<CanSelectOrgsModel> provideFirstData() {
        return models;
    }

    @NonNull
    @Override
    public List<CanSelectOrgsModel.ChildrenBean> linkageSecondData(int firstIndex) {
        if (models.size() == 0) {
            return new ArrayList<>();
        }
        if (firstIndex == INDEX_NO_FOUND) {
            firstIndex = 0;
        }
        return models.get(firstIndex).getChildren();
    }

    @NonNull
    @Override
    public List<CanSelectOrgsModel.ChildrenBean> linkageThirdData(int firstIndex, int secondIndex) {
        if (models.size() == 0) {
            return new ArrayList<>();
        }
        if (firstIndex == INDEX_NO_FOUND) {
            firstIndex = 0;
        }
        if (secondIndex == INDEX_NO_FOUND) {
            secondIndex = 0;
        }
        return models.get(firstIndex).getChildren().get(secondIndex).getChildren();
    }

    @Override
    public int findFirstIndex(Object firstValue) {
        if (firstValue == null) {
            return INDEX_NO_FOUND;
        }
        if (firstValue instanceof CanSelectOrgsModel.ChildrenBean) {
            return models.indexOf(firstValue);
        }
        for (int i = 0, n = models.size(); i < n; i++) {
            CanSelectOrgsModel entity = models.get(i);
            if (entity.getCode().equals(firstValue.toString()) ||
                    entity.getName().contains(firstValue.toString())) {
                return i;
            }
        }
        return INDEX_NO_FOUND;
    }

    @Override
    public int findSecondIndex(int firstIndex, Object secondValue) {
        if (secondValue == null) {
            return INDEX_NO_FOUND;
        }
        List<CanSelectOrgsModel.ChildrenBean> cityList = linkageSecondData(firstIndex);
        if (secondValue instanceof CanSelectOrgsModel.ChildrenBean) {
            return cityList.indexOf(secondValue);
        }
        for (int i = 0, n = cityList.size(); i < n; i++) {
            CanSelectOrgsModel.ChildrenBean entity = cityList.get(i);
            if (entity.getCode().equals(secondValue.toString()) ||
                    entity.getName().contains(secondValue.toString())) {
                return i;
            }
        }
        return INDEX_NO_FOUND;
    }

    @Override
    public int findThirdIndex(int firstIndex, int secondIndex, Object thirdValue) {
        if (thirdValue == null) {
            return INDEX_NO_FOUND;
        }
        List<CanSelectOrgsModel.ChildrenBean> countyList = linkageThirdData(firstIndex, secondIndex);
        if (thirdValue instanceof CanSelectOrgsModel.ChildrenBean) {
            return countyList.indexOf(thirdValue);
        }
        for (int i = 0, n = countyList.size(); i < n; i++) {
            CanSelectOrgsModel.ChildrenBean entity = countyList.get(i);
            if (entity.getCode().equals(thirdValue.toString()) ||
                    entity.getName().contains(thirdValue.toString())) {
                return i;
            }
        }
        return INDEX_NO_FOUND;
    }

}
