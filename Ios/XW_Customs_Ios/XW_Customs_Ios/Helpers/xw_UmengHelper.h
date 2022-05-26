//
//  xw_UmengHelper.h
//  XW_Customs_Ios
//
//  Created by wuxinyi on 2022/5/5.
//

#import <Foundation/Foundation.h>
#import <UMLink/UMLink.h>
#import <UserNotifications/UserNotifications.h>

NS_ASSUME_NONNULL_BEGIN

#define kUmengKey @"5e82a616167edd82a4000260"

@interface xw_UmengHelper : NSObject
////如果要在iOS10显示交互式的通知，必须注意实现以下代码
+ (void)xw_InitUmengPush:(NSDictionary *)launchOptions delegate:(id<UNUserNotificationCenterDelegate>)delegate;

+(BOOL) xw_handleUniversalLink:(nonnull NSUserActivity *)userActivity delegate:(id<MobClickLinkDelegate>)delegate;

+(BOOL) xw_handleLinkURL:(nonnull NSURL *)url delegate:(id<MobClickLinkDelegate>)delegate;
//获取U-Link智能超链接参数
+(void) xw_getUmengLinkInstallParamInfo;

/** 设置是否允许SDK当应用在前台运行收到Push时弹出Alert框（默认开启）
 @param value 是否开启弹出框
 */
+(void) xw_setAutoAlert:(BOOL)value;
//应用处于运行时（前台、后台）的消息处理，回传点击数据
+(void) xw_didReceiveRemoteNotification:(nullable NSDictionary*)userInfo;


@end

NS_ASSUME_NONNULL_END
