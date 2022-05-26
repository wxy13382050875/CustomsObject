//
//  AppDelegate.m
//  CustomsApp
//
//  Created by wuxinyi on 2022/4/29.
//

#import "AppDelegate.h"
#import "AppDelegate+XW.h"
#import <UMLink/UMLink.h>//
#import "xw_UmengHelper.h"
#ifndef __OPTIMIZE__
#import "JPFPSStatus.h"
#endif
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/ASIdentifierManager.h>
#import <UserNotifications/UserNotifications.h>
@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 初始化项目
    [self registerRoutes];
    
    //友盟初始化
    
    [xw_UmengHelper xw_InitUmengPush:launchOptions delegate:self];
    
    if (@available(iOS 14, *)) {
            // iOS14及以上版本需要先请求权限
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            // 获取到权限后，依然使用老方法获取idfa
            if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
                NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
                NSLog(@"%@",idfa);
            } else {
                NSLog(@"请在设置-隐私-跟踪中允许App请求跟踪");
            }
        }];
    } else {
        // iOS14以下版本依然使用老方法
        // 判断在设置-隐私里用户是否打开了广告跟踪
        if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
            NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
            NSLog(@"%@",idfa);
        } else {
            NSLog(@"请在设置-隐私-广告中打开广告跟踪功能");
        }
    }
            
#if defined(DEBUG)||defined(_DEBUG)
    [[JPFPSStatus sharedInstance] open];
    [PPNetworkHelper openLog];
#else
    [[GHConsole sharedConsole]startPrintLog];
#endif
    
    return YES;
}


- (BOOL)application:(UIApplication *)application continueUserActivity:(nonnull NSUserActivity *)userActivity restorationHandler:(nonnull void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler
{
    UINavigationController *platformVc = (UINavigationController *)self.window.rootViewController;
    UIViewController *vc = platformVc.viewControllers[0];
    if([xw_UmengHelper xw_handleUniversalLink:userActivity delegate:(id<MobClickLinkDelegate>)vc])
    {
        return YES;
    }
    //其它第三方处理
    return YES;
}

//iOS9以上，走这个方法
- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    NSLog(@"url:%@", url);
    UINavigationController *platformVc = (UINavigationController *)self.window.rootViewController;
    UIViewController *vc = platformVc.viewControllers[0];
    if([xw_UmengHelper xw_handleLinkURL:url delegate:(id<MobClickLinkDelegate>)vc])
    {
        return YES;
    }
    //其它第三方处理
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation
{
    NSLog(@"url:%@", url);
    UINavigationController *platformVc = (UINavigationController *)self.window.rootViewController;
    UIViewController *vc = platformVc.viewControllers[0];
    if([xw_UmengHelper xw_handleLinkURL:url delegate:(id<MobClickLinkDelegate>)vc])
    {
        return YES;
    }
    //其它第三方处理
    return YES;
}

//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭U-Push自带的弹出框
        [xw_UmengHelper xw_setAutoAlert:NO];
        //必须加这句代码
        [xw_UmengHelper xw_didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于前台时的本地推送接受
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [xw_UmengHelper xw_didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于后台时的本地推送接受
    }
}
//#pragma mark - 如需使用远程推送相关功能，请实现以下方法
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

    
    
    if(![deviceToken isKindOfClass:[NSData class]])return;
       const unsigned *tokenBytes =(const unsigned*)[deviceToken bytes];
       NSString*hexToken =[NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                             ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                             ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                             ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
       NSLog(@"deviceToken:%@",hexToken);
       //1.2.7版本开始不需要用户再手动注册devicetoken，SDK会自动注册
       //传入的devicetoken是系统回调didRegisterForRemoteNotificationsWithDeviceToken的入参，切记
    [xw_ConfigHelper sharedInstance].deviceToken = hexToken;
}

@end
