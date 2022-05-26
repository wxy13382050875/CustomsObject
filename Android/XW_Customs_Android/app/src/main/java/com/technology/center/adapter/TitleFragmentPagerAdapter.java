package com.technology.center.adapter;


import android.os.Bundle;
import android.util.Log;

import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentPagerAdapter;

import com.technology.center.model.AcceptQueryModel;
import com.technology.center.view.fragment.DelegagteAcceptFragment;

import java.util.ArrayList;
import java.util.List;


public class TitleFragmentPagerAdapter extends FragmentPagerAdapter {


    /**
     * The m fragment list.
     */
    private List<Fragment> mFragmentList = null;

    private String[] titles;

    /**
     * Instantiates a new ab fragment pager adapter.
     *
     * @param mFragmentManager the m fragment manager
     * @param fragmentList     the fragment list
     */
    public TitleFragmentPagerAdapter(FragmentManager mFragmentManager,
                                     ArrayList<Fragment> fragmentList) {
        super(mFragmentManager);
        mFragmentList = fragmentList;
    }

    /**
     * titles是给TabLayout设置title用的
     *
     * @param mFragmentManager
     * @param fragmentList
     * @param titles
     */
    public TitleFragmentPagerAdapter(FragmentManager mFragmentManager,
                                     List<Fragment> fragmentList, String[] titles) {
        super(mFragmentManager);
        mFragmentList = fragmentList;
        this.titles = titles;
    }

    /**
     * 描述：获取数量.
     *
     * @return the count
     * @see android.support.v4.view.PagerAdapter#getCount()
     */
    @Override
    public int getCount() {
        return mFragmentList.size();
    }

    /**
     * 描述：获取索引位置的Fragment.
     *
     * @param position the position
     * @return the item
     * @see android.support.v4.app.FragmentPagerAdapter#getItem(int)
     */
    @Override
    public Fragment getItem(int position) {

        DelegagteAcceptFragment fragment = null;
        String title = "";
        if (position < mFragmentList.size()) {
            fragment = (DelegagteAcceptFragment)mFragmentList.get(position);
            title = this.titles[position];
        } else {
            fragment = (DelegagteAcceptFragment)mFragmentList.get(0);
            title = this.titles[0];
        }

        Log.d("zzz","pager adapter ***********"+title);
        Bundle bundle=new Bundle();
        bundle.putString("title",title);
        fragment.setArguments(bundle);

        return fragment;
    }

    @Override
    public CharSequence getPageTitle(int position) {
        if (titles != null && titles.length > 0)
            return titles[position];
        return null;
    }
    public void update(int position,AcceptQueryModel model){
        DelegagteAcceptFragment fragment =(DelegagteAcceptFragment)mFragmentList.get(position);
        if(fragment == null){
            return;
        }
        if(fragment instanceof UpdateAble){//这里唯一的要求是Fragment要实现UpdateAble接口
            ((UpdateAble)fragment).update(model);
        }
    }
    public interface UpdateAble {
        public void update(AcceptQueryModel model);
    }
}
