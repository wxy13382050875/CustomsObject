//
//  PPInterfacedConst.m
//  PPNetworkHelper
//
//  Created by YiAi on 2017/7/6.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import "xw_InterfacedConst.h"

#if DevelopSever
#elif TestSever
/** 接口前缀-测试服务器*/
NSString *const kApiPrefix = @"http://port.bt-dev.yndth.cn";
//NSString *const kApiPrefix = @"http://eport.bt-market.yndth.cn";
#elif ProductSever
/** 接口前缀-生产服务器*/
//NSString *const kApiPrefix = @"http://ds.bt-dev.yndth.cn";

NSString *const kApiPrefix = @"http://port.bt-dev.yndth.cn";
//NSString *const kApiPrefix = @"http://eport.bt-market.yndth.cn";
#endif

/** 登录*/
NSString *const kLogin = @"/user/login";

/** 用户注册接口*/
NSString *const kRegister = @"/user/register";

/** 重置密码*/
NSString *const kResetPassword = @"/user/resetPassword";

/** 发送短信验证码*/
NSString *const kSendCode = @"/shortMessage/sendSmsCode";

/** 口岸通首页*/
NSString *const kGetHome = @"/home";

/** 口岸通首页新版*/
NSString *const kGetHomeV2 = @"/home/v2";

/** 口岸通首页新版*/
NSString *const kGetHomeInfo = @"/newsHome";

/** 更新用户信息*/
NSString *const kUpdateUserInfo = @"/user/saveUser";

/** 用户退出登录（解绑token）*/
NSString *const kLoginOut = @"/user/out";

/** 修改密码*/
NSString *const kChangePwd = @"/user/modifyPassword";

/** 当日进出口数据统计*/
NSString *const kCurrentData = @"/stats/today";

/** 统计报表-当年进出口交易统计和当日统计*/
NSString *const kStatisticalReports= @"/stats/trade/currentMonth";

/** 进出口统计*/
NSString *const kImportAndExport= @"/stats/inAndOut";

/** 商品交易额统计*/
NSString *const kGoodsTrade= @"/stats/goodsTrade";

/** 交易结算录单统计*/
NSString *const kTradeBill= @"/stats/tradeBill";

/** 获取边民备案状态*/
NSString *const kGetCivilFaceStatus= @"/face/setCivilFaceStatus";

/** 获取人脸token*/
NSString *const kGetFaceVerifyToken= @"/face/getVerifyToken";

/** 获取认证结果token*/
NSString *const kGetVerifyResult= @"/face/getVerifyResultOfRealPerson";

/** 获取工作台数据*/
NSString *const kGetWorkStation= @"/workStation/list";

/** 获取工作台数据*/
NSString *const kGetWorkStationShow= @"/workStation/show";

/** 获取工作台数据*/
NSString *const kGetNewsList= @"/news";

/** 获取工作台数据*/
NSString *const kGetArticleShow= @"/article/show";

/** 获取工作台数据*/
NSString *const kGetMsgList= @"/msg/listPage";

/** 设置消息为已读*/
NSString *const kSetMsgRead= @"/msg/read";

/** 刷新用户信息*/
NSString *const kRefreshUserInfo = @"/user/refresh";

/** 用户绑定DeviceToken*/
NSString *const kBindDeviceToken = @"/user/bindDeviceToken";


NSString *const kPostPayOrder = @"/face/charge/order";

NSString *const kGetPayOrderState = @"/face/charge/ckeckPayStatus";

NSString *const kGetAccountInfo = @"/account/info";

/** 获取协议组信息*/
NSString *const kGetProtocolGroup= @"/protocolHandle/getProtocolGroup";

/** 获取协议组信息*/
NSString *const kGetProtocolDetail= @"/protocolHandle/getProtocolDetail";

NSString *const kGetProtocolDetailNoAuth = @"/protocolHandle/getProtocolDetailNoAuth";

/** 协议同意动作*/
NSString *const kConsentProtocol= @"/protocolHandle/consent";

/** 用户菜单使用次数统计*/
NSString *const kUserMenuCount =@"/menu/userMenuCount";

/** 用户菜单使用次数统计*/
NSString *const kGetAmcAccountVip =@"/vip/checkAccountVipStatus";

/** 实人认证或委托代理弹窗信息提示*/
NSString *const kGetRealPersonOrAgentDeclare=@"/popUps/realPersonOrAgentDeclare";

NSString *const kGetGuideInfo =@"/guide/";

NSString *const kPostCompleteGuide =@"/guide/completeGuide";

NSString *const kGetAdShow =@"/adShow";

/** 发送注销验证码*/
NSString *const kPostLoginOffCode =@"/shortMessage/sendUserLogoffVerifyCode";

/** 确认注销*/
NSString *const kPostVerifyLoginOff =@"/user/logoff";

/** 重新实人认证验证码*/
NSString *const kPostFaceAuthCode =@"/shortMessage/sendReFaceAuthVerifyCode";

/** 发送实人认证申请*/
NSString *const kPostVerifyFaceAuth =@"/face/charge/reFaceAuthApply";
