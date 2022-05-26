package com.technology.center.utils;

import android.app.DownloadManager;
import android.content.BroadcastReceiver;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.database.Cursor;
import android.net.Uri;
import android.os.Build;
import android.os.Environment;
import android.provider.MediaStore;
import android.text.TextUtils;
import android.util.Log;

import androidx.core.content.FileProvider;

import com.technology.center.handler.MsgHandlerCallBack;
import com.technology.center.http.RequestRetrofit;
import com.technology.center.service.DownLoadFileService;

import org.json.JSONObject;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.Objects;


import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/**
 * app更新工具类
 */
public class AppUpdateUtils {
    private static final String TAG = "AppUpdateUtils";
    private static Context mContext;
    private Map versionInfo;
    private DownloadManager downloadManager;
    private String downloadUpdateApkFilePath;
    //下载的ID
    private long downloadId;

    public AppUpdateUtils(Context baseContext) {
        SpUtils spUtils = new SpUtils(baseContext);
        versionInfo = GsonUtil.fromJson(spUtils.getString("versionInfo"), Map.class);
        this.mContext = baseContext;
    }


    /**
     * 检查版本更新
     *
     * @return true 表示服务器有新版 false 表示服务器没有新版本
     */
    public void checkVersion(MsgHandlerCallBack msgHandlerCallBack) {

        RequestRetrofit.getInstance(DownLoadFileService.class).getVersionInfo().enqueue(new Callback<ResponseBody>() {
            @Override
            public void onResponse(Call<ResponseBody> call, Response<ResponseBody> response) {
                try {
                    assert response.body() != null;

                    String result = response.body().string();
                    JSONObject jsonObject = new JSONObject(result);
                    new JSONObject(jsonObject.getJSONObject("data").toString());
                    //版本比较
                    int comRs = compareVersion(Objects.requireNonNull(versionInfo.get("versionName")).toString(), jsonObject.getJSONObject("data").getString("versionName"));
                    Log.d(TAG, "onResponse: " + comRs);
                    JSONObject comRsJson = new JSONObject();
                    comRsJson.put("rs", comRs);
                    comRsJson.put("data", jsonObject.getJSONObject("data"));
                    msgHandlerCallBack.handlerMessage(comRsJson);
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
     * 安装apk
     *
     * @param context context
     * @param apkFile 安装文件
     */
    private void installAPk(Context context, File apkFile) {
        Intent installAPKIntent = getApkInStallIntent(context, apkFile);
        context.startActivity(installAPKIntent);
        android.os.Process.killProcess(android.os.Process.myPid());

    }

    /**
     * 获取安装文件意图
     *
     * @param context context
     * @param apkFile 安装文件
     * @return 安装意图
     */
    private Intent getApkInStallIntent(Context context, File apkFile) {

        try {
            Process p = Runtime.getRuntime().exec("chmod 755 " + apkFile.getPath());
            p.waitFor();
        } catch (Exception e) {
            e.printStackTrace();
        }

        Intent intent = new Intent(Intent.ACTION_VIEW);
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        Log.d(TAG, "getApkInStallIntent: " + apkFile.length());
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.N) {
            Uri uri = FileProvider.getUriForFile(context, "com.technology.center.fileprovider", apkFile);
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
            intent.setDataAndType(uri, "application/vnd.android.package-archive");
        } else {
            Uri uri = getApkUri(apkFile);
            intent.setDataAndType(uri, "application/vnd.android.package-archive");

        }
        return intent;
    }

    /**
     * 获取安装文件的Uri
     *
     * @param apkFile 安装文件
     * @return Uri
     */
    private Uri getApkUri(File apkFile) {
        //如果没有设置 SDCard 写权限，或者没有 SDCard,apk 文件保存在内存中，需要授予权限才能安装
        try {
            String[] command = {"chmod", "777", apkFile.toString()};
            ProcessBuilder builder = new ProcessBuilder(command);
            builder.start();
        } catch (IOException ignored) {
        }
        return Uri.fromFile(apkFile);
    }


    /**
     * 版本号比较
     *
     * @param version1 本地版本
     * @param version2 服务器版本
     * @return 0代表相等，1代表version1大于version2，-1代表version1小于version2
     */
    private static int compareVersion(String version1, String version2) {
        if (version1.equals(version2)) {
            return 0;
        }
        String[] version1Array = version1.split("\\.");
        String[] version2Array = version2.split("\\.");
        Log.d("HomePageActivity", "version1Array==" + version1Array.length);
        Log.d("HomePageActivity", "version2Array==" + version2Array.length);
        int index = 0;
        // 获取最小长度值
        int minLen = Math.min(version1Array.length, version2Array.length);
        int diff = 0;
        // 循环判断每位的大小
        Log.d("HomePageActivity", "verTag2=2222=" + version1Array[index]);
        while (index < minLen
                && (diff = Integer.parseInt(version1Array[index])
                - Integer.parseInt(version2Array[index])) == 0) {
            index++;
        }
        if (diff == 0) {
            // 如果位数不一致，比较多余位数
            for (int i = index; i < version1Array.length; i++) {
                if (Integer.parseInt(version1Array[i]) > 0) {
                    return 1;
                }
            }

            for (int i = index; i < version2Array.length; i++) {
                if (Integer.parseInt(version2Array[i]) > 0) {
                    return -1;
                }
            }
            return 0;
        } else {
            return diff > 0 ? 1 : -1;
        }
    }

    public void downloadBySelf(Context context, String apkUrl, String fileName) {
        if (TextUtils.isEmpty(apkUrl)) {
            return;
        }
        try {
            Uri uri = Uri.parse(apkUrl);
            downloadManager = (DownloadManager) context
                    .getSystemService(Context.DOWNLOAD_SERVICE);
            DownloadManager.Request request = new DownloadManager.Request(uri);
            //在通知栏中显示
            request.setVisibleInDownloadsUi(true);
            request.setTitle("应用更新");
            request.setDescription("下载完后，请点击安装");
            //MIME_MapTable是所有文件的后缀名所对应的MIME类型的一个String数组  {".apk",    "application/vnd.android.package-archive"},
            request.setMimeType("application/vnd.android.package-archive");
            // 在通知栏通知下载中和下载完成
            // 下载完成后该Notification才会被显示
            if (Build.VERSION.SDK_INT > Build.VERSION_CODES.HONEYCOMB) {
                // Android 3.0版本 以后才有该方法
                //在下载过程中通知栏会一直显示该下载的Notification，在下载完成后该Notification会继续显示，直到用户点击该Notification或者消除该Notification
                request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
            }
            String filePath = null;
            if (Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED)) {//外部存储卡
                filePath = Environment.getExternalStorageDirectory().getAbsolutePath();
            } else {
                Log.i(TAG, "没有SD卡");
                return;
            }
            downloadUpdateApkFilePath = filePath + File.separator + fileName + System.currentTimeMillis() + ".apk";
            // 若存在，则删除 (这里具体逻辑具体看,我这里是删除)
            deleteFile(downloadUpdateApkFilePath);
            Uri fileUri = Uri.fromFile(new File(downloadUpdateApkFilePath));
            request.setDestinationUri(fileUri);
            //下载管理Id
            downloadId = downloadManager.enqueue(request);

            mContext.registerReceiver(receiver, new IntentFilter(DownloadManager.ACTION_DOWNLOAD_COMPLETE));

        } catch (Exception e) {
            e.printStackTrace();
            //注意:如果文件下载失败则 使用浏览器下载
            downloadByWeb(context, apkUrl);
        }
    }

    //广播监听下载的各个状态
    private BroadcastReceiver receiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            if (intent.getAction().equals(DownloadManager.ACTION_DOWNLOAD_COMPLETE)) {
                Uri downloadFileUri = downloadManager.getUriForDownloadedFile(downloadId);
                installApk(downloadFileUri, context);
            }
        }
    };

    private void installApk(Uri downLoadApkUri, Context context) {

        if (downLoadApkUri == null) {
            Log.e(TAG, "Download apk failed,empty apk uri");
            return;
        } else {
            Log.d(TAG, "Download apk finish ,apkUri:%s" + downLoadApkUri.toString());
        }

        //获取待安装的apk文件
        File apkFile = new File(getRealFilePath(context, downLoadApkUri));
        if (!apkFile.exists()) {
            Log.d(TAG, "Apk file is not exist.");
            return;
        }

        //调用系统安装apk
        Intent intent = new Intent();
        intent.setAction(Intent.ACTION_VIEW);
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {   //7.0版本以上
            Uri uriForFile = FileProvider.getUriForFile(context, "com.technology.center.fileProvider", apkFile);
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
            intent.setDataAndType(uriForFile, "application/vnd.android.package-archive");
            Log.d(TAG, "Install apk,\ndata: %s" + uriForFile);
        } else {
            Uri uri = Uri.fromFile(apkFile);
            intent.setDataAndType(uri, "application/vnd.android.package-archive");
            Log.d(TAG, "Install apk,\ndata: %s" + uri);
        }

        try {
            context.startActivity(intent);
        } catch (Exception e) {
            Log.e(TAG, "Start system install activity exception: %s" + e.getLocalizedMessage());
        }

    }


    private static void deleteFile(String path) {
        File file = new File(path);
        if (file.exists()) {
            file.delete();
        }
    }

    private String getRealFilePath(Context context, Uri uri) {
        if (null == uri) return null;
        final String scheme = uri.getScheme();
        String data = null;
        if (scheme == null)
            data = uri.getPath();
        else if (ContentResolver.SCHEME_FILE.equals(scheme)) {
            data = uri.getPath();
        } else if (ContentResolver.SCHEME_CONTENT.equals(scheme)) {
            Cursor cursor = context.getContentResolver().query(uri, new String[]{MediaStore.Images.ImageColumns.DATA}, null, null, null);
            if (null != cursor) {
                if (cursor.moveToFirst()) {
                    int index = cursor.getColumnIndex(MediaStore.Images.ImageColumns.DATA);
                    if (index > -1) {
                        data = cursor.getString(index);
                    }
                }
                cursor.close();
            }
        }
        return data;
    }

    //通过浏览器方式下载并安装
    private static void downloadByWeb(Context context, String apkPath) {
        Uri uri = Uri.parse(apkPath);
        //String android.intent.action.VIEW 比较通用，会根据用户的数据类型打开相应的Activity。如:浏览器,电话,播放器,地图
        Intent intent = new Intent(Intent.ACTION_VIEW, uri);
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        context.startActivity(intent);
    }

}
