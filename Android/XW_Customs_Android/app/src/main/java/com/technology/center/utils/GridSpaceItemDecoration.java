package com.technology.center.utils;

import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.Rect;
import android.util.Log;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

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

public class GridSpaceItemDecoration extends RecyclerView.ItemDecoration {

    private int mSpanCount;//横条目数量
    private int mRowSpacing;//行间距
    private int mColumnSpacing;// 列间距

    /**
     * @param spanCount     列数
     * @param rowSpacing    行间距
     * @param columnSpacing 列间距
     */
    public GridSpaceItemDecoration(int spanCount, int rowSpacing, int columnSpacing) {
        this.mSpanCount = spanCount;
        this.mRowSpacing = rowSpacing;
        this.mColumnSpacing = columnSpacing;
    }

    @Override
    public void getItemOffsets(@NonNull Rect outRect, @NonNull View view, @NonNull RecyclerView parent, @NonNull RecyclerView.State state) {
        int position = parent.getChildAdapterPosition(view); // 获取view 在adapter中的位置。
        int column = position % mSpanCount; // view 所在的列

        if (column == 0){
            outRect.left = 0; // column * (列间距 * (1f / 列数))
            outRect.right = mColumnSpacing;
        } else if(column == mSpanCount -1){
            outRect.left = mColumnSpacing; // column * (列间距 * (1f / 列数))
            outRect.right = 0;
        } else {
            outRect.left = mColumnSpacing; // column * (列间距 * (1f / 列数))
            outRect.right = mColumnSpacing;
        }
        outRect.left = column * mColumnSpacing / mSpanCount; // column * (列间距 * (1f / 列数))
        outRect.right = mColumnSpacing - (column + 1) * mColumnSpacing / mSpanCount; // 列间距 - (column + 1) * (列间距 * (1f /列数))

//        Log.e(TAG, "position:" + position
//                + "    columnIndex: " + column
//                + "    left,right ->" + outRect.left + "," + outRect.right);

        // 如果position > 行数，说明不是在第一行，则不指定行高，其他行的上间距为 top=mRowSpacing
        if (position >= mSpanCount) {
            outRect.top = mRowSpacing; // item top
        }
    }
}
