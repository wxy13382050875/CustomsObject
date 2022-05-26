package com.technology.center.view.welcome;

import static com.technology.center.App.getContext;
import android.content.Intent;
import android.graphics.Color;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.TextPaint;
import android.text.style.BackgroundColorSpan;
import android.text.style.ClickableSpan;
import android.text.style.ForegroundColorSpan;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.TextView;

import com.kongzue.dialog.v3.CustomDialog;
import com.technology.center.App;
import com.technology.center.Constant;
import com.technology.center.http.RequestRetrofit;
import com.technology.center.model.LaunchAdModel;
import com.technology.center.model.ProtocolModel;
import com.technology.center.service.DownLoadFileService;
import com.technology.center.utils.CircleProgressbar;
import com.technology.center.utils.GsonUtil;
import com.technology.center.utils.SpUtils;
import com.technology.center.utils.uMengHelper.PushHelper;
import com.technology.center.view.MainActivity;
import com.technology.center.view.base.BaseCompatActivity;
import com.technology.center.view.splash.CustomerVideoView;
import com.technology.center.view.user.LoginActivity;
import com.technology.center.view.user.WebViewActivity;

import org.jetbrains.annotations.NotNull;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import com.technology.center.R;
import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/**
 * @desc 启动屏
 */
public class SplashActivity extends BaseCompatActivity {

    private static final String TAG = "SplashActivity";
    private SpUtils spUtils;
    private LaunchAdModel bean;
    private ImageView image;
    private CustomerVideoView videoView;
    private CircleProgressbar bar;
    private String localPath = getContext().getFilesDir() + File.separator + "res/";

    @Override
    protected void onStart() {
//        Log.d("34567","g工始");
        if (bar != null ){
            enterHomeActivity();
        }
        super.onStart();
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        spUtils = new SpUtils(Objects.requireNonNull(getContext()));

        // 判断是否是第一次开启应用
        boolean isFirstOpen = spUtils.getBoolean(Constant.FIRST_OPEN, false);

        // 如果是第一次启动，则先进入功能引导页
        if (!isFirstOpen) {
            Intent intent = new Intent(this, WelcomeGuideActivity.class);
            startActivity(intent);
            finish();
            return;
        }

        requestWindowFeature(Window.FEATURE_NO_TITLE);  //无title
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,
                WindowManager.LayoutParams.FLAG_FULLSCREEN);  //全屏
        // 如果不是第一次启动app，则正常显示启动屏
        setContentView(R.layout.activity_splash);
        //创建广告位


        boolean agreed = spUtils.getBoolean("agreed",false);;
        if (!agreed) {
            //对于未实例化的布局：
            CustomDialog.show(SplashActivity.this, R.layout.layout_custom_dialog, new CustomDialog.OnBindView() {
                @Override
                public void onBind(final CustomDialog dialog, View v) {
                    TextView title = v.findViewById(R.id.title);
                    TextView message = v.findViewById(R.id.message);
                    TextView btnConfirm = v.findViewById(R.id.confirm);
                    TextView btnCancel = v.findViewById(R.id.cancel);

                    title.setText("隐私政策");
                    String content ="{\"createDate\":\"2020-09-10 15:42:23\",\"id\":1,\"groupKey\":\"REGIST_LOGIN_PROTOCOL\",\"name\":\"用户使用须知\",\"outline\":\"亲爱的用户，欢迎来到边互通！我们根据最新的监管要求更新了边互通《用户隐私政策》和《服务条款》（点击查看），特向您说明如下:\\n1.为保障服务所需，我们会申请系统权限收集您的手机设备信息用于信息推送和安全风控，并申请存储权限用于下载、缓存相关文件。\\n2.基于您的明确授权，我们可能会获取您的相机权限等信息用于人脸认证，您有权拒绝或取消授权。\\n3.您可以查询、更正您的个人信息，我们也提供账户注销渠道。\\n 如对本政策内容有任何疑问、意见或建议，您可以及时通过客服邮箱：chenlijuan@yndth.cn与我们取得联系。\",\"protocols\":[{\"createDate\":\"2020-09-10 15:42:23\",\"id\":2,\"name\":\"《用户隐私政策》\"},{\"createDate\":\"2020-09-10 15:42:23\",\"id\":7,\"name\":\"《服务条款》\"}],\"consent\":true}";
                    ProtocolModel proBean  = GsonUtil.fromJson(content, ProtocolModel.class);
                    message.setText(generateSp(proBean.getOutline(), proBean.getProtocols()));
                    btnConfirm.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            dialog.doDismiss();
                            spUtils.putBoolean("agreed",true);;
                            PushHelper.init(getContext(), new PushHelper.onSuccessListener() {
                                @Override
                                public void onSuccess(String deviceToken) {
                                    App.mDeviceToken = deviceToken;
                                }
                            });

                            new Handler().postDelayed(new Runnable() {

                                @Override
                                public void run() {
                                    enterHomeActivity();
                                }
                            }, 2000);
                        }
                    });
                    btnCancel.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            System.exit(0);//正常退出App
                        }
                    });
                }
            }).show();;

        } else {
            enterHomeActivity();
        }

//


    }
    private void getLocalAd(){
        if (spUtils.getBoolean("loginStatus", false)) {
            Map<String, String> params = new HashMap<>();


            params.put("adSpaceName", "开屏广告");

            params.put("size", "1");
//            userViewModel.getAdShow(params).observe(SplashActivity.this, new Observer<BaseDto<List<LaunchAdBean>>>() {
//                @Override
//                public void onChanged(BaseDto<List<LaunchAdBean>> listBaseDto) {
//                    Log.d("getAdShow",listBaseDto.toString());
//
//
//                    if (listBaseDto.getCode().equals("200")) {
//                        FrameLayout layout = findViewById(R.id.splash_ad);
//                        layout.getLayoutParams().height= ScreenUtils.getScreenHeight(getContext());
//                        if (listBaseDto.getData().size() > 0){
//                            bean = listBaseDto.getData().get(0);
//
//                            layout.setVisibility(View.VISIBLE);
//                            layout.setOnClickListener(new View.OnClickListener() {
//                                @Override
//                                public void onClick(View v) {
////                                Log.d("2345678","跳转到web");
//
//                                    bar.stop();
//                                    Intent intent = new Intent(getContext(), WebViewActivity.class);
//                                    //用Bundle携带数据
//                                    Bundle bundle = new Bundle();
//                                    //传递name参数为tinyphp
//                                    bundle.putString("url", bean.getJumpTargetPage());
//                                    bundle.putString("type", "ad");
//                                    intent.putExtras(bundle);
//                                    startActivity(intent);
//                                }
//                            });
//
//
//                            image = findViewById(R.id.iv_splash_image);
//                            videoView = (CustomerVideoView)findViewById(R.id.iv_splash_video);
//                            bar = findViewById(R.id.tv_ad_skip);
//                            videoView.setOnPreparedListener(new MediaPlayer.OnPreparedListener() {
//                                @Override
//                                public void onPrepared(MediaPlayer mp) {
//                                    Log.d("2345678","加载完成");
//                                    showSkipBtn();
//                                }
//                            });
//
//                            if(!bean.getAdCreativeForm().getResourcesType().equals("veido")){
//                                image.setVisibility(View.VISIBLE);
//                                Glide.with(getContext()).load(bean.getResourcesUrl()).listener(new RequestListener<Drawable>() {
//                                    @Override
//                                    public boolean onLoadFailed(@Nullable GlideException e, Object model, Target<Drawable> target, boolean isFirstResource) {
//                                        return false;
//                                    }
//
//                                    @Override
//                                    public boolean onResourceReady(Drawable resource, Object model, Target<Drawable> target, DataSource dataSource, boolean isFirstResource) {
//                                        showSkipBtn();
//                                        return false;
//                                    }
//                                }).diskCacheStrategy(DiskCacheStrategy.RESOURCE).into(image);
//
//                            } else {
//                                Log.d("下载视频",bean.getResourcesUrl());
//
//
//                                videoView.setVisibility(View.VISIBLE);
//
//                                download();
//                            }
//
//
//                        }
//                        else {
//                            layout.setVisibility(View.GONE);
//                            new Handler().postDelayed(new Runnable() {
//
//                                @Override
//                                public void run() {
//                                    enterHomeActivity();
//                                }
//                            }, 2000);
//                        }
//                    } else {
//                        new Handler().postDelayed(new Runnable() {
//
//                            @Override
//                            public void run() {
//                                enterHomeActivity();
//                            }
//                        }, 2000);
//                    }
//
//
//                }
//            });
        } else {
            new Handler().postDelayed(new Runnable() {

                @Override
                public void run() {
                    enterHomeActivity();
                }
            }, 2000);
        }
    }


    private void showSkipBtn(){

        bar.setVisibility(View.VISIBLE);
        bar.setTimeMillis(5000);
        bar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Log.d("2345678","跳过");
                videoView.stopPlayback();
                enterHomeActivity();
            }
        });
        bar.setCountdownProgressListener(1, new CircleProgressbar.OnCountdownProgressListener() {
            @Override
            public void onProgress(int what, int progress) {
                Log.d("2345678",progress+"");
            }

            @Override
            public void onStop() {
                Log.d("2345678","结束");
                videoView.stopPlayback();
                enterHomeActivity();
            }
        });
        bar.start();
    }

    private void enterHomeActivity() {

        if (!spUtils.getBoolean("loginStatus", false)) {
            Intent intent = new Intent(SplashActivity.this, LoginActivity.class);
            startActivity(intent);
            finish();
        } else {
            Intent intent = new Intent(this, MainActivity.class);
            startActivity(intent);
            finish();
        }

    }

    //开屏页一定要禁止用户对返回按钮的控制，否则将可能导致用户手动退出了App而广告无法正常曝光和计费
    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if(KeyEvent.KEYCODE_BACK==keyCode|| KeyEvent.KEYCODE_HOME==keyCode){
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
    }

    private SpannableString generateSp(String text, List<ProtocolModel.Protocols> protocols) {
        //定义需要操作的内容


        SpannableString spannableString = new SpannableString(text);

        for (int i = 0; i < protocols.size(); i++) {

            int index = text.indexOf(protocols.get(i).getName());
            int end = index + protocols.get(i).getName().length();
            spannableString.setSpan(new ForegroundColorSpan(Color.parseColor("#62839A")), index, end, Spannable.SPAN_INCLUSIVE_INCLUSIVE);
            spannableString.setSpan(new BackgroundColorSpan(Color.parseColor("#FFFFFF")), index, end, Spannable.SPAN_INCLUSIVE_INCLUSIVE);
            spannableString.setSpan(new Clickable(protocols.get(i)), index, end, Spannable.SPAN_INCLUSIVE_INCLUSIVE);
//
        }

//
        //最后返回SpannableString
        return spannableString;
    }

    /**
     * 内部类，用于截获点击富文本后的事件
     */
    class Clickable extends ClickableSpan {
        private final ProtocolModel.Protocols protocols;

        public Clickable(ProtocolModel.Protocols protocols) {
            this.protocols = protocols;
        }

        @Override
        public void onClick(View v) {
//            Toast.makeText(getContext(),"Click Success-----" + this.protocols.getName(), Toast.LENGTH_SHORT).show();
            String type = "onAuth";
            skipWebView(this.protocols.getId(), type);
        }

        @Override
        public void updateDrawState(TextPaint ds) {
            ds.setColor(ds.linkColor);
            ds.setUnderlineText(false);    //去除超链接的下划线
        }
    }
    private void skipWebView(String webId, String type) {
        Intent intent = new Intent(getContext(), WebViewActivity.class);
        //用Bundle携带数据
        Bundle bundle = new Bundle();
        //传递name参数为tinyphp
        bundle.putString("id", webId);
        bundle.putString("type", type);
        intent.putExtras(bundle);
        startActivity(intent);
    }
    private  void download(){
        String path = localPath + bean.getResourcesName();
        if(fileIsExists(path))
        {
            Log.d("视频已存在",path);

            videoView.setVideoURI(Uri.parse(path));
            videoView.start();


            return ;
        }
        Log.d("下载视频",path);
        RequestRetrofit.getInstance(DownLoadFileService.class).downloadSplashVedio(bean.getResourcesUrl()).enqueue(new Callback<ResponseBody>() {
            @Override
            public void onResponse(Call<ResponseBody> call, Response<ResponseBody> response) {
                try {
                    if (response.body() != null) {
                        writeResponseBodyToDisk(response.body());
                    } else {
//                        ToastUtil.show(context, "加载页面资源失败，请您反馈给客服人员");
//                        try {
//                            msgHandlerCallBack.handlerMessage(new JSONObject());
//                        } catch (JSONException e) {
//                            e.printStackTrace();
//                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            @Override
            public void onFailure(Call<ResponseBody> call, Throwable t) {

            }
        });
    }
    /**
     * 保存文件
     *
     * @param body 文件流
     */
    private void writeResponseBodyToDisk(ResponseBody body) {
        try {

            File dir = new File(localPath);
            if (!dir.exists()) dir.mkdirs();

            File path = new File(dir, bean.getResourcesName() );
            String absolutePath = path.getAbsolutePath();

            File futureStudioIconFile = new File(absolutePath);

            InputStream inputStream = null;
            OutputStream outputStream = null;

            try {
                byte[] fileReader = new byte[1024];

                inputStream = body.byteStream();
                outputStream = new FileOutputStream(futureStudioIconFile);

                int len;
                while ((len = inputStream.read(fileReader)) != -1) {
                    outputStream.write(fileReader, 0, len);
                }

            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                if (inputStream != null) {
                    inputStream.close();
                }

                if (outputStream != null) {
                    outputStream.close();
                }
                Message msg = new Message();
                msg.what = 1;
                msg.obj = path.getPath();
                mHandler.sendMessage(msg);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
    private Handler mHandler = new Handler() {
        @Override
        public void handleMessage(@NotNull Message msg) {
            if (msg.what == 1) {
//                installUniApp();
                Log.d("下载完成",(String) msg.obj);
                videoView.setVideoURI(Uri.parse((String) msg.obj));
                videoView.start();
                showSkipBtn();
            }
        }
    };
    public boolean fileIsExists(String strFile)
    {
        try
        {
            File f=new File(strFile);
            if(!f.exists())
            {
                return false;
            }

        }
        catch (Exception e)
        {
            return false;
        }

        return true;
    }
}
