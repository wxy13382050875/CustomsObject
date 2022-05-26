//
//  xw_UmengHelper.m
//  XW_Customs_Ios
//
//  Created by wuxinyi on 2022/5/5.
//

#import "xw_UmengHelper.h"
#import <UMCommon/UMConfigure.h>
//#import <UMCommon/UMCommon.h>

//#import <UMAPM/UMCrashConfigure.h>
//#import <UMAPM/UMLaunch.h>
#import <UMAPM/UMAPMConfig.h>
#import <UMPush/UMessage.h>
#import "xw_BaseViewController.h"
@implementation xw_UmengHelper

+ (void)xw_InitUmengPush:(NSDictionary *)launchOptions delegate:(id<UNUserNotificationCenterDelegate>)delegate{
    
    [self xw_InitUmengKey];
    // Push's basic setting
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionAlert;
    //如果要在iOS10显示交互式的通知，必须注意实现以下代码
    if (@available(iOS 10.0, *)) {
        UNNotificationAction *action1_ios10 = [UNNotificationAction actionWithIdentifier:@"action1_identifier" title:@"打开应用" options:UNNotificationActionOptionForeground];
        UNNotificationAction *action2_ios10 = [UNNotificationAction actionWithIdentifier:@"action2_identifier" title:@"忽略" options:UNNotificationActionOptionForeground];
        //UNNotificationCategoryOptionNone
        //UNNotificationCategoryOptionCustomDismissAction  清除通知被触发会走通知的代理方法
        //UNNotificationCategoryOptionAllowInCarPlay       适用于行车模式
        UNNotificationCategory *category1_ios10 = [UNNotificationCategory categoryWithIdentifier:@"category1" actions:@[action1_ios10,action2_ios10]   intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
        NSSet *categories = [NSSet setWithObjects:category1_ios10, nil];
        entity.categories=categories;
    }
    
    [UNUserNotificationCenter currentNotificationCenter].delegate=delegate;
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            [xw_ConfigHelper sharedInstance].isUMPush = YES;
        }else
        {
            [xw_ConfigHelper sharedInstance].isUMPush = NO;
        }
    }];
}

+(void)xw_InitUmengKey{
    [UMConfigure initWithAppkey:kUmengKey channel:@"App Store"];
#if defined(DEBUG)||defined(_DEBUG)
    [UMConfigure setLogEnabled:YES];
#else
    [UMConfigure setLogEnabled:NO];
#endif
}

//处理U-Link回调
+(BOOL) xw_handleUniversalLink:(nonnull NSUserActivity *)userActivity delegate:(id<MobClickLinkDelegate>)delegate{
    return [MobClickLink handleUniversalLink:userActivity delegate:delegate];
}
+(BOOL) xw_handleLinkURL:(nonnull NSURL *)url delegate:(id<MobClickLinkDelegate>)delegate{
    return [MobClickLink handleLinkURL:url delegate:delegate];
}
+(void) xw_getUmengLinkInstallParamInfo{
    BOOL hasGetInstallParams = [[NSUserDefaults standardUserDefaults] boolForKey:@"key_Has_Get_InstallParams"];
    if (!hasGetInstallParams) {
        [MobClickLink getInstallParams:^(NSDictionary *params, NSURL *URL, NSError *error) {
            if (error) {
                return;
            }
            AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
            UINavigationController *platformVc = (UINavigationController *)app.window.rootViewController;
            xw_BaseViewController *vc = platformVc.viewControllers[0];
            if (URL.absoluteString.length > 0||params.count > 0) {
                vc.install_params = params;
                [MobClickLink handleLinkURL:URL delegate:(id<MobClickLinkDelegate>)vc];
            }else{
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                                   message:@"没有匹配到安装参数"
                                                                            preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                          handler:nil];
                 
                    [alert addAction:defaultAction];
                [vc presentViewController:alert animated:YES completion:nil];
            }
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"key_Has_Get_InstallParams"];
        }];
    }else{
        //已经调用过getInstallParam方法，没必要在下次启动时再调用
        //但后续仍可在需要时调用，比如demo中的按钮点击
    }
}
////关闭U-Push自带的弹出框
+(void) xw_setAutoAlert:(BOOL)value{
    [UMessage setAutoAlert:value];
}
+(void) xw_didReceiveRemoteNotification:(nullable NSDictionary*)userInfo{
    [UMessage didReceiveRemoteNotification:userInfo];
    [self xw_UmengNotificationHandle:userInfo];
}
//处理后台点击通知的代理方法
+ (void) xw_UmengNotificationHandle:(nullable NSDictionary*)userInfo{
    [UMessage setBadgeClear:YES];
//    if(){
//        //处理后台点击通知处理方法
//    }
}
@end
