package com.technology.center.utils;

import android.widget.TextView;

import java.util.LinkedList;
import java.util.Random;

/**
 * @package: com.huodao.hdphone.utils
 * @date: on 2017/8/17 16:35
 * @author: LiangJi-34
 * @describe:
 * @email:
 */

public class NumAnim {


    //每秒刷新多少次
    private static final int COUNTPERS = 100;

    public static void startAnim(TextView textV, float num, int m) {
        startAnim(textV, num, 500);
    }

    public static void startAnim(TextView textV, float num, int m, long time) {
        if (num == 0) {
            textV.setText(NumUtil.NumberFormat(num, m));
            return;
        }
        if (num <= 0) {
            num = 20;
        }
        Float[] nums = splitnum(num, (int) ((time / 1000f) * COUNTPERS), m);

        Counter counter = new Counter(textV, nums, time, m);

        textV.removeCallbacks(counter);
        textV.post(counter);
    }

    private static Float[] splitnum(float num, int count, int m) {
        Random random = new Random();
        float numtemp = num;
        float sum = 0;
        LinkedList<Float> nums = new LinkedList<Float>();
        nums.add(0f);
        while (true) {
            float nextFloat = NumUtil.NumberFormatFloat(
                    (random.nextFloat() * num * 2f) / (float) count,
                    2);
            if (nextFloat < 0) {
                nextFloat = 2;
            }
            System.out.println("next:" + nextFloat);
            if (numtemp - nextFloat >= 0 && numtemp > 1) {
                sum = NumUtil.NumberFormatFloat(sum + nextFloat, m);
                nums.add(sum);
                numtemp -= nextFloat;
            } else {
                nums.add(num);
                return nums.toArray(new Float[0]);
            }
        }
    }

    static class Counter implements Runnable {

        private final TextView view;
        private Float[] nums;
        private long pertime;

        private int m;

        private int i = 0;

        Counter(TextView view, Float[] nums, long time, int m) {
            this.view = view;
            this.nums = nums;
            this.pertime = time / nums.length;
            this.m = m;
        }

        @Override
        public void run() {
            if (i > nums.length - 1) {
                view.removeCallbacks(Counter.this);
                return;
            }
            view.setText(NumUtil.NumberFormat(nums[i++], m));
            view.removeCallbacks(Counter.this);
            view.postDelayed(Counter.this, pertime);
        }
    }


}
