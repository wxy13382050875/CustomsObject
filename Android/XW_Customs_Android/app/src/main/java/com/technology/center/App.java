package com.technology.center;

import android.app.Application;
import android.content.Context;
import android.os.Build;
import android.os.Handler;

import androidx.annotation.RequiresApi;


import com.nostra13.universalimageloader.cache.disc.naming.Md5FileNameGenerator;
import com.nostra13.universalimageloader.cache.memory.impl.WeakMemoryCache;
import com.nostra13.universalimageloader.core.DisplayImageOptions;
import com.nostra13.universalimageloader.core.ImageLoader;
import com.nostra13.universalimageloader.core.ImageLoaderConfiguration;
import com.nostra13.universalimageloader.core.assist.QueueProcessingType;
import com.nostra13.universalimageloader.core.download.BaseImageDownloader;
import com.technology.center.utils.SpUtils;
import com.technology.center.utils.uMengHelper.PushHelper;
import com.umeng.commonsdk.UMConfigure;




public class App extends Application {
    private static final String TAG = "App";
    public static final String UPDATE_STATUS_ACTION = "com.umeng.message.example.action.UPDATE_STATUS";
    private volatile static App instance = null;
    private static Context context;
    private Handler handler;

    public static String mDeviceToken;

    public static int badgeCount = 0;


    private SpUtils spUtils;


    @RequiresApi(api = Build.VERSION_CODES.P)
    @Override
    public void onCreate() {
        super.onCreate();

//        spUtils = new SpUtils(Objects.requireNonNull(context));


        context = getApplicationContext();


        initImageLoader(context);//初始化ImageLoader



        initPushSDK();


//        FloatWindowUtils floatWin = new FloatWindowUtils(context);
//        floatWin.showWindow(MainActivity.class);

        //初始DialogX
        initDialogX();

    }

    public static Context getContext() {
        return context;
    }

    //应用层的单例模式
    public static App getInstance() {
        if (instance == null) {
            synchronized (App.class) {
                if (instance == null) {
                    instance = new App();
                }
            }
        }
        return instance;
    }
    private void initDialogX(){
//        DialogX.init(this);
//        DialogX.implIMPLMode= DialogX.IMPL_MODE.VIEW;
//        DialogX.useHaptic = true;
//        DialogX.globalStyle = new MaterialStyle();
//        DialogX.globalTheme = DialogX.THEME.AUTO;
//        DialogX.onlyOnePopTip = false;
    }
    private void initPushSDK() {
        //日志开关
        UMConfigure.setLogEnabled(true);
        //预初始化
        PushHelper.preInit(context);
        /**
         * 初始化推送SDK，在用户隐私政策协议同意后，再做初始化
         */
//        TradPlusSdk.initSdk(this,"68D143864CC439A676E601D5FA52A829");

        SpUtils spUtils = new SpUtils(getBaseContext());
        boolean agreed = spUtils.getBoolean("agreed",false);;
        if (agreed && PushHelper.isMainProcess(context)) {
            //AppId是应用Id，需要去开发者后台添加APP后获取

            //建议在线程中执行初始化
            new Thread(new Runnable() {
                @Override
                public void run() {
                    PushHelper.init(getApplicationContext(), new PushHelper.onSuccessListener() {
                        @Override
                        public void onSuccess(String deviceToken) {
                            App.mDeviceToken = deviceToken;
                        }
                    });

                }
            }).start();
        } else {
            //若不是主进程（":channel"结尾的进程），直接初始化sdk，不可在子线程中执行
            PushHelper.init(getApplicationContext(), new PushHelper.onSuccessListener() {
                @Override
                public void onSuccess(String deviceToken) {
                    App.mDeviceToken = deviceToken;
                }
            });
        }


    }





    private void initImageLoader(Context context) {

        ImageLoaderConfiguration config = new ImageLoaderConfiguration
                .Builder(context)
                /*.memoryCacheExtraOptions(480, 800) //max width, max height，即保存的每个缓存文件的最大长宽*/
                .threadPoolSize(3)//线程池内加载的数量
                .threadPriority(Thread.NORM_PRIORITY - 2)//解释：当同一个Uri获取不同大小的图片，缓存到内存时，只缓存一个。默认会缓存多个不同的大小的相同图片
                //.denyCacheImageMultipleSizesInMemory()//拒绝缓存多个图片。
                .memoryCache(new WeakMemoryCache())//缓存策略你可以通过自己的内存缓存实现 ，这里用弱引用，缺点是太容易被回收了，不是很好！
                .memoryCacheSize(2 * 1024 * 1024)//设置内存缓存的大小
                .discCacheSize(50 * 1024 * 1024)//设置磁盘缓存大小 50M
                .discCacheFileNameGenerator(new Md5FileNameGenerator())//将保存的时候的URI名称用MD5 加密
                .tasksProcessingOrder(QueueProcessingType.LIFO)//设置图片下载和显示的工作队列排序
                //.diskCache(new UnlimitedDiskCache(cacheDir)) //自定义缓存路径
                .discCacheFileCount(100) //缓存的文件数量
                .defaultDisplayImageOptions(DisplayImageOptions.createSimple())//显示图片的参数，默认：DisplayImageOptions.createSimple()
                .imageDownloader(new BaseImageDownloader(this, 5 * 1000, 30 * 1000)) // connectTimeout (5 s), readTimeout (30 s)超时时间
                .writeDebugLogs() //打开调试日志
                .build();//开始构建
        ImageLoader.getInstance().init(config);//全局初始化此配置
    }




}
