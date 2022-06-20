package com.technology.center.adapter;

import android.app.Activity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.annotation.NonNull;

import java.util.ArrayList;
import java.util.List;

import com.technology.center.R;

public class ListPopupWindowAdapter extends BaseAdapter {
    public OnClickDeleteButtonListener clickDeleteButtonListener;
    private LayoutInflater layoutInflater;
    private Activity mActivity;
    private List<String> mDataSource = new ArrayList();
    public OnClickTextViewListener onClickTextViewListener;

    public interface OnClickDeleteButtonListener {
        void onClickDeleteButton(int i);
    }

    public interface OnClickTextViewListener {
        void onClickSelect(int i);
    }

    public class ViewHolder {
        public LinearLayout btnDelete;
        public TextView tvTitle;

        public ViewHolder() {
        }
    }

    public long getItemId(int i) {
        return 0;
    }

    public ListPopupWindowAdapter(Activity activity, List<String> list, @NonNull OnClickDeleteButtonListener onClickDeleteButtonListener, OnClickTextViewListener onClickTextViewListener) {
        this.mActivity = activity;
        this.mDataSource = list;
        this.layoutInflater = this.mActivity.getLayoutInflater();
        this.clickDeleteButtonListener = onClickDeleteButtonListener;
        this.onClickTextViewListener = onClickTextViewListener;
    }

    public int getCount() {
        return this.mDataSource.size();
    }

    public String getItem(int i) {
        return (String) this.mDataSource.get(i);
    }

    public View getView(final int i, View view, ViewGroup viewGroup) {
        View view2;
        ViewHolder viewHolder;
        if (view == null) {
            viewHolder = new ViewHolder();
            view2 = this.layoutInflater.inflate(R.layout.item_list_popup_window, null);
            viewHolder.tvTitle = (TextView) view2.findViewById(R.id.text_title);
            viewHolder.btnDelete = (LinearLayout) view2.findViewById(R.id.button_delete);
            view2.setTag(viewHolder);
        } else {
            view2 = view;
            viewHolder = (ViewHolder) view.getTag();
        }
        viewHolder.tvTitle.setText(getItem(i));
        viewHolder.btnDelete.setOnClickListener(new View.OnClickListener() {
            public void onClick(View view) {
                ListPopupWindowAdapter.this.clickDeleteButtonListener.onClickDeleteButton(i);
            }
        });
        viewHolder.tvTitle.setOnClickListener(new View.OnClickListener() {
            public void onClick(View view) {
                ListPopupWindowAdapter.this.onClickTextViewListener.onClickSelect(i);
            }
        });
        return view2;
    }
}
