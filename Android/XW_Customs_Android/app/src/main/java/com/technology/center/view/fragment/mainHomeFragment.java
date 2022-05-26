package com.technology.center.view.fragment;


import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.widget.ProgressBar;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import androidx.viewpager.widget.ViewPager;

import com.google.android.material.tabs.TabLayout;
import com.technology.center.adapter.CenterPagerAdapter;
import com.technology.center.adapter.TitleFragmentPagerAdapter;
import com.technology.center.view.base.BaseToolBarFragment;
import com.technology.center.R;
import com.technology.center.view.custom.CertificateQueryActivity;
import com.wuhenzhizao.titlebar.widget.CommonTitleBar;

import java.util.ArrayList;
import java.util.List;

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link mainHomeFragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class mainHomeFragment extends Fragment {

    private TabLayout tabLayout;
    private CenterPagerAdapter adapter;
    private CommonTitleBar titleBar;
    private ViewPager viewpager;
    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {

        return inflater.inflate(R.layout.fragment_main_home, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        titleBar = (CommonTitleBar) view.findViewById(R.id.titlebar);//进度条
        titleBar.setBackgroundResource(R.drawable.top_bg_shape);
        titleBar.setListener(new CommonTitleBar.OnTitleBarListener() {
            @Override
            public void onClicked(View v, int action, String extra) {
                if (action == CommonTitleBar.ACTION_LEFT_TEXT) {
                } else if(action == CommonTitleBar.ACTION_SEARCH){

                } else if(action == CommonTitleBar.ACTION_RIGHT_BUTTON){

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
                Intent intent = new Intent(getContext(), CertificateQueryActivity.class);
                startActivity(intent);
            }
        });
        tabLayout= view.findViewById(R.id.tab_layou);
        viewpager= view.findViewById(R.id.view_pager);

        initView();
    }



    private void initView(){

        List<Fragment> fragments = new ArrayList<>();
        List<String> titles = new ArrayList<>();
        CenterFragment fragment = new CenterFragment();
        fragments.add(fragment);
        titles.add("技术中心");
        BranchCenterFragment fragment1 = new BranchCenterFragment();
        fragments.add(fragment1);
        titles.add("技术分中心");
        adapter = new CenterPagerAdapter(getFragmentManager(), fragments, titles.toArray(new String[]{}));
        viewpager.setOffscreenPageLimit(titles.size());
        viewpager.setAdapter(adapter);

        tabLayout.setupWithViewPager(viewpager);
    }

}