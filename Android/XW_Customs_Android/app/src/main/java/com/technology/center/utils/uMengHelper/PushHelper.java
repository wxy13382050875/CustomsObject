package com.technology.center.utils.uMengHelper;

import android.app.Application;
import android.app.Notification;
import android.content.Context;
import android.util.Log;


import com.google.gson.Gson;
import com.taobao.accs.ACCSClient;
import com.taobao.accs.AccsClientConfig;
import com.taobao.accs.utl.ALog;
import com.taobao.agoo.TaobaoRegister;
import com.technology.center.model.UmengPushModel;
import com.technology.center.utils.SpUtils;
import com.umeng.commonsdk.UMConfigure;
import com.umeng.commonsdk.utils.UMUtils;
import com.umeng.message.IUmengCallback;
import com.umeng.message.IUmengRegisterCallback;
import com.umeng.message.MsgConstant;
import com.umeng.message.PushAgent;
import com.umeng.message.UmengMessageHandler;
import com.umeng.message.UmengNotificationClickHandler;
import com.umeng.message.entity.UMessage;

import org.android.agoo.huawei.HuaWeiRegister;
import org.android.agoo.mezu.MeizuRegister;

import me.leolin.shortcutbadger.ShortcutBadger;



/**
 * PushSDK集成帮助类
 */
public class PushHelper {

    private static final String TAG = PushHelper.class.getSimpleName();

    /**
     * 预初始化，已添加子进程中初始化sdk。
     * 使用场景：用户未同意隐私政策协议授权时，延迟初始化
     *
     * @param context 应用上下文
     */
    private static UmengNotificationClickHandler notificationClickHandler = new UmengNotificationClickHandler(){
        @Override
        public void launchApp(Context context, UMessage uMessage) {
            super.launchApp(context, uMessage);
            ShortcutBadger.removeCount(context);
            Log.i(TAG, "UmengNotificationClickHandler launchApp" );
        }

        @Override
        public void openActivity(Context context, UMessage uMessage) {
            super.openActivity(context, uMessage);
            ShortcutBadger.removeCount(context);
            Log.i(TAG, "UmengNotificationClickHandler openActivity" );
        }

        @Override
        public void openUrl(Context context, UMessage uMessage) {
            super.openUrl(context, uMessage);
            ShortcutBadger.removeCount(context);
            Log.i(TAG, "UmengNotificationClickHandler openUrl" );
        }

        @Override
        public void dealWithCustomAction(Context context, UMessage uMessage) {
            super.dealWithCustomAction(context, uMessage);
            Log.i(TAG, "UmengNotificationClickHandler dealWithCustomAction" );
        }
    };
    private static UmengMessageHandler msgHandler = new UmengMessageHandler() {
        //处理通知栏消息
        @Override
        public void dealWithNotificationMessage(Context context, UMessage msg) {
            super.dealWithNotificationMessage(context, msg);

            int badgeCount = 5;
            UmengPushModel uBean = new Gson().fromJson(msg.getRaw().toString(), UmengPushModel.class);;

            Log.i(TAG, "UmengMessageHandler UmengMessageHandler receiver:" + uBean.getBody().getTitle() + uBean.getBody().getBadge());
            ShortcutBadger.applyCount(context, uBean.getBody().getBadge());
        }

        //自定义通知样式，此方法可以修改通知样式等
        @Override
        public Notification getNotification(Context context, UMessage msg) {
            return super.getNotification(context, msg);
        }

        //处理透传消息
        @Override
        public void dealWithCustomMessage(Context context, UMessage msg) {
            super.dealWithCustomMessage(context, msg);
            Log.i(TAG, "UmengMessageHandler custom receiver:" + msg.getRaw().toString());
        }
    };
    public static void preInit(Context context) {
        try {
            //解决厂商通道推送乱码问题
            AccsClientConfig.Builder builder = new AccsClientConfig.Builder();
            builder.setAppKey("umeng:" + PushConstants.APP_KEY);
            builder.setAppSecret(PushConstants.MESSAGE_SECRET);
            builder.setTag(AccsClientConfig.DEFAULT_CONFIGTAG);
            ACCSClient.init(context, builder.build());
            TaobaoRegister.setAccsConfigTag(context, AccsClientConfig.DEFAULT_CONFIGTAG);
        } catch (Exception e) {
            e.printStackTrace();
        }
        UMConfigure.preInit(context, PushConstants.APP_KEY, PushConstants.CHANNEL);
        if (!isMainProcess(context)) {
            init(context, new onSuccessListener() {
                @Override
                public void onSuccess(String deviceToken) {

                }
            });
        }
    }


    /**
     * 初始化。
     * 场景：用户已同意隐私政策协议授权时
     *
     * @param context 应用上下文
     */
    public static void init(Context context,onSuccessListener listener) {
        // 在此处调用基础组件包提供的初始化函数 相应信息可在应用管理 -> 应用信息 中找到 http://message.umeng.com/list/apps
        // 参数一：当前上下文context；
        // 参数二：应用申请的Appkey；
        // 参数三：渠道名称；
        // 参数四：设备类型，必须参数，传参数为UMConfigure.DEVICE_TYPE_PHONE则表示手机；传参数为UMConfigure.DEVICE_TYPE_BOX则表示盒子；默认为手机；
        // 参数五：Push推送业务的secret 填充Umeng Message Secret对应信息
        UMConfigure.init(
                context,
                PushConstants.APP_KEY,
                PushConstants.CHANNEL,
                UMConfigure.DEVICE_TYPE_PHONE,
                PushConstants.MESSAGE_SECRET
        );

        //获取消息推送实例
        final PushAgent pushAgent = PushAgent.getInstance(context);
        pushAgent.setNotificationPlaySound(MsgConstant.NOTIFICATION_PLAY_SERVER); //服务端控制声音
        pushAgent.setDisplayNotificationNumber(0);
        //注册推送服务，每次调用register方法都会回调该接口
        pushAgent.register(new IUmengRegisterCallback() {

            @Override
            public void onSuccess(String deviceToken) {
                //注册成功会返回deviceToken deviceToken是推送消息的唯一标志
                Log.i(TAG, "deviceToken --> " + deviceToken);
//                pushAgent.setAlias("xxx", "wx", new UTrack.ICallBack() {
//                    @Override
//                    public void onMessage(boolean b, String s) {
//                        Log.i(TAG, "b:" + b + " s:" + s);
//                    }
//                });
                if(listener != null){
                    listener.onSuccess(deviceToken);
                }
            }

            @Override
            public void onFailure(String errCode, String errDesc) {
                Log.e(TAG, "u-push register failure：--> " + "code:" + errCode + ",desc:" + errDesc);
            }
        });
        if (isMainProcess(context)) {
            registerDeviceChannel(context);
        }
        pushAgent.setMessageHandler(msgHandler);
        pushAgent.setNotificationClickHandler(notificationClickHandler);
    }

    /**
     * 注册设备推送通道（小米、华为等设备的推送）
     *
     * @param context 应用上下文
     */
    private static void registerDeviceChannel(Context context) {
        //打印日志开关
        ALog.isPrintLog = true;
        //小米通道，填写您在小米后台APP对应的xiaomi id和key
//        MiPushRegistar.register(context, PushConstants.MI_ID, PushConstants.MI_KEY);
//        //华为，注意华为通道的初始化参数在minifest中配置
        HuaWeiRegister.register((Application) context.getApplicationContext());
//        //魅族，填写您在魅族后台APP对应的app id和key
        MeizuRegister.register(context, PushConstants.MEI_ZU_ID, PushConstants.MEI_ZU_KEY);
//        //OPPO，填写您在OPPO后台APP对应的app key和secret
//        OppoRegister.register(context, PushConstants.OPPO_KEY, PushConstants.OPPO_SECRET);
//        //vivo，注意vivo通道的初始化参数在minifest中配置
//        VivoRegister.register(context);
    }

    /**
     * 是否运行在主进程
     *
     * @param context 应用上下文
     * @return true: 主进程；false: 子进程
     */
    public static boolean isMainProcess(Context context) {
        return UMUtils.isMainProgress(context);
    }

    public static void setPushSwitch(Context context,Boolean open){
//        final PushAgent pushAgent = PushAgent.getInstance(context);
        SpUtils spUtils = new SpUtils(context);
        if (!open){
            PushAgent.getInstance(context).disable(new IUmengCallback(){
                @Override
                public void onSuccess() {
                    Log.d("setPushSwitch","关闭消息推送功能成功");
                    spUtils.putBoolean("isOpenPush", false);
                }

                @Override
                public void onFailure(String s,String s1) {
                    Log.d("setPushSwitch","关闭消息推送功能失败");
                }
            });
        } else {
            PushAgent.getInstance(context).enable(new IUmengCallback() {
                @Override
                public void onSuccess() {
                    Log.d("setPushSwitch","再次开启推送成功");
                    spUtils.putBoolean("isOpenPush", true);
                }

                @Override
                public void onFailure(String s,String s1) {
                    Log.d("setPushSwitch","再次开启推送失败");
                }
            });
        }
    }

    /**
     * 定义一个接口
     */
    public interface onSuccessListener{
        void onSuccess(String deviceToken);
    }

}
