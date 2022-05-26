//
//  PPInterfacedConst.h
//  PPNetworkHelper
//
//  Created by AndyPang on 2017/4/10.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */

#define DevelopSever 0
#define TestSever    1
#define ProductSever 0

/** 接口前缀-开发服务器*/
UIKIT_EXTERN NSString *const kApiPrefix;

#pragma mark - 详细接口地址
/** 登录*/
UIKIT_EXTERN NSString *const kLogin;

/** 用户注册接口*/
UIKIT_EXTERN NSString *const kRegister;

/** 重置密码*/
UIKIT_EXTERN NSString *const kResetPassword;

/** 发送短信验证码*/
UIKIT_EXTERN NSString *const kSendCode;

/** 更新用户信息*/
UIKIT_EXTERN NSString *const kUpdateUserInfo;

/** 用户退出登录（解绑token）*/
UIKIT_EXTERN NSString *const kLoginOut;

/** 修改密码*/
UIKIT_EXTERN NSString *const kChangePwd;

/** 口岸通首页*/
UIKIT_EXTERN NSString *const kGetHome;

/** 口岸通首页新版*/
UIKIT_EXTERN NSString *const kGetHomeV2;

/** 边互通资讯首页*/
UIKIT_EXTERN NSString *const kGetHomeInfo;

/** 获取个人信息*/
UIKIT_EXTERN NSString *const kGetInfo;

/** 编辑个人信息*/
UIKIT_EXTERN NSString *const kUpdateInfo;

/** 当日进出口数据统计*/
UIKIT_EXTERN NSString *const kCurrentData;

/** 统计报表-当年进出口交易统计和当日统计*/
UIKIT_EXTERN NSString *const kStatisticalReports;

/** 进出口统计*/
UIKIT_EXTERN NSString *const kImportAndExport;

/** 商品交易额统计*/
UIKIT_EXTERN NSString *const kGoodsTrade;

/** 交易结算录单统计*/
UIKIT_EXTERN NSString *const kTradeBill;

/** 获取边民备案状态*/
UIKIT_EXTERN NSString *const kGetCivilFaceStatus;

/** 获取边民备案状态*/
UIKIT_EXTERN NSString *const kGetFaceVerifyToken;

/** 获取认证结果*/
UIKIT_EXTERN NSString *const kGetVerifyResult;

/** 获取工作台数据*/
UIKIT_EXTERN NSString *const kGetWorkStation;

/** 获取工作台数据*/
UIKIT_EXTERN NSString *const kGetWorkStationShow;

/** 新闻按新闻模块分页查询*/
UIKIT_EXTERN NSString *const kGetNewsList;

/** 查看新闻或问题详情*/
UIKIT_EXTERN NSString *const kGetArticleShow;

/** 获取用户消息列表（分页）*/
UIKIT_EXTERN NSString *const kGetMsgList;

/** 设置消息为已读*/
UIKIT_EXTERN NSString *const kSetMsgRead;

/** 刷新用户信息*/
UIKIT_EXTERN NSString *const kRefreshUserInfo;


/** 用户绑定DeviceToken*/
UIKIT_EXTERN NSString *const kBindDeviceToken;

/** 下单*/
UIKIT_EXTERN NSString *const kPostPayOrder;

/** 获取下单状态*/
UIKIT_EXTERN NSString *const kGetPayOrderState;

/** 获取下单状态*/
UIKIT_EXTERN NSString *const kGetAccountInfo;

/** 获取协议组信息*/
UIKIT_EXTERN NSString *const kGetProtocolGroup;

/** 获取协议组信息*/
UIKIT_EXTERN NSString *const kGetProtocolDetail;

/** 获取协议组信息无token*/
UIKIT_EXTERN NSString *const kGetProtocolDetailNoAuth;

/** 协议同意动作*/
UIKIT_EXTERN NSString *const kConsentProtocol;

/** 用户菜单使用次数统计*/
UIKIT_EXTERN NSString *const kUserMenuCount;

/** 用户菜单使用次数统计*/
UIKIT_EXTERN NSString *const kGetAmcAccountVip;

/** 实人认证或委托代理弹窗信息提示*/
UIKIT_EXTERN NSString *const kGetRealPersonOrAgentDeclare;

/** 通过引导位置获取引导信息*/
UIKIT_EXTERN NSString *const kGetGuideInfo;
/** 完成引导*/
UIKIT_EXTERN NSString *const kPostCompleteGuide;

/** 通过广告位名称获取广告内容*/
UIKIT_EXTERN NSString *const kGetAdShow;

/** 发送注销验证码*/
UIKIT_EXTERN NSString *const kPostLoginOffCode;

/** 确认注销*/
UIKIT_EXTERN NSString *const kPostVerifyLoginOff;

/** 重新实人认证验证码*/
UIKIT_EXTERN NSString *const kPostFaceAuthCode;

/** 发送实人认证申请*/
UIKIT_EXTERN NSString *const kPostVerifyFaceAuth;
