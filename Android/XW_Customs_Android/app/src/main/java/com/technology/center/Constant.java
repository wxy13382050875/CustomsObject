package com.technology.center;

public class Constant {


    public static final String FIRST_OPEN = "first_open";

    public static class Server {
        //口岸通URL
//        public static final String PORT_BT_URL = BuildConfig.DEBUG ?
//                "http://port.bt-dev.yndth.cn" :
//                "http://eport.bt-market.yndth.cn";


        //public static final String PORT_BT_URL = "http://eport.bt-market.yndth.cn";
        public static final String PORT_BT_URL = "http://api.bt-dev.yndth.cn";


        /*人脸认证相关接口*/
        public static final String DTH_RP_TOKEN_URL = "/face/getVerifyToken";
        //校验用户信息是否备案
        public static final String DTH_RP_VALID_URL = "/face/setCivilFaceStatus";
        //获取认证结果
        public static final String DTH_RP_GET_VAL_RESULT = "/face/getVerifyResult";
        //获取阿里云认证结果V1版本
        public static final String DTH_RP_GET_VAL_RESULT_V1 = "/face/getVerifyResultOfRealPerson";


        /*用户相关接口*/
        //发送验证码
        public static final String USER_SEND_SMS_CODE_URL = "/shortMessage/sendSmsCode";
        //用户注册
        public static final String USER_REGISTER_URL = "/user/register";
        //用户登录
        public static final String USER_LOGIN_URL = "/user/login";
        //获取控制台
        public static final String GET_MENU_LIST_URL = "/workStation";
        //更新用户信息
        public static final String USER_INFO_UPDATE = "/user/saveUser";
        //用户密码重置
        public static final String USER_PWD_RESET = "user/resetPassword";

        //用户修改密码
        public static final String USER_PWD_MODIFY = "user/modifyPassword";
        //获取首页数据
        public static final String GET_HOME_LIST = "/home";

        //获取首页数据
        public static final String GET_HOME_NEW_LIST = "/home/v2";

        //获取首页数据
        public static final String GET_HOME_INFO_LIST = "/newsHome";
        //获取首页数据
        public static final String GET_NEWS_LIST = "/news";

        //获取首页数据
        public static final String GET_MSG_LIST = "/msg/listPage";

        //服务中心问题详情
        public static final String GET_Article_SHOW = "/article/show";

        //设置消息为已读
        public static final String SET_MSG_READ = "/msg/read";

        //工作台功能菜单列表
        public static final String GET_WORKSTATION_SHOW = "/workStation/show";

        //用户绑定DeviceToken
        public static final String USER_BindDeviceToken = "/user/bindDeviceToken";

        //用户绑定DeviceToken
        public static final String USER_OUT = "/user/out";

        //获取app版本信息
        public static final String GET_APP_VERSION_URL = "/appVersion/check";

        //刷新用户信息
        public static final String REFRESH_USERINFO = "/user/refresh";

        //用户退出登录（解绑token）
        public static final int TIME_OUT = 5;

        //检查边民是否支付实人认证费用
        public static final String CHECK_BORDERER_PAY = "/face/charge/ckeckPayStatus";

        //检查边民是否支付实人认证费用
        public static final String GET_ACCOUNT_INFO = "/account/info";

        //获取协议组信息
        public static final String GET_PROTOCOL_GROUP = "/protocolHandle/getProtocolGroup";

        //获取协议详情
        public static final String GET_PROTOCOL_DETAIL = "/protocolHandle/getProtocolDetail";

        //获取协议详情无token
        public static final String GET_PROTOCOL_DETAIL_NOAUTH = "/protocolHandle/getProtocolDetailNoAuth";

        //获取协议组信息
        public static final String CONSENT = "/protocolHandle/consent";

        //用户菜单使用次数统计
        public static final String USERMENUCOUNT = "/menu/userMenuCount";

        //判断当前账号是否存在有效期内的会员
        public static final String GET_VIP_STATUS = "/vip/checkAccountVipStatus";

        //判断当前账号是否存在有效期内的会员
        public static final String GET_ALERT_POP = "/popUps/realPersonOrAgentDeclare";

        //判断当前账号是否存在有效期内的会员
        public static final String GET_GUIDE = "/guide/{location}";


        //判断当前账号是否存在有效期内的会员
        public static final String POST_COMPLETEGUIDE = "/guide/completeGuide";
        //通过广告位名称获取广告内容
        public static final String GET_ADSHOW = "adShow";

        //发送注销验证码
        public  static  final  String LOGOFF_SMS = "/shortMessage/sendUserLogoffVerifyCode";
        //发送确认注销
        public static  final  String LOGOFF_SUBMIT = "/user/logoff";

        //发送重新实人认证验证码
        public  static final  String REFRESH_FACE_CODE = "/shortMessage/sendReFaceAuthVerifyCode";
        //发送实人认证申请
        public static  final  String REFRESH_FACE_APPLY = "/face/charge/reFaceAuthApply";

    }

    /**
     * 服务器返回状态码
     */
    public static class RespCode {
        public static final String R200 = "200";
        public static final String R401 = "401";
        public static final String R403 = "403";
    }




}
