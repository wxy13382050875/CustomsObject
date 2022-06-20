//
//  AppDelegate+HQ.m
//  HQMVVM_RAC_Router
//
//  Created by Mr_Han on 2018/11/13.
//  Copyright © 2018 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//
#import "AppDelegate+XW.h"
#import "JLRoutes.h"
#import "xw_TabBarController.h"
#import "xw_NavigationController.h"

#import "xw_NavigationController.h"
#import<objc/runtime.h>
#import "xw_LaunchAdHelper.h"


#import "HomeViewController.h"
#import "OfficeViewController.h"
#import "MsgViewController.h"
#import "MyViewController.h"

#import "xw_LoginViewController.h"
#import "xw_WelcomeViewController.h"
#import "IQKeyboardManager.h"

#define STOREAPPID @"1500549596"

@interface AppDelegate (XW)


@end
@implementation AppDelegate (XW)



////////////////////////////////////////////////////////////////////////////////////////////////
- (void)registerRoutes{
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    //监测版本
//
    [PPNetworkHelper setResponseSerializer:PPResponseSerializerJSON];
    
    RegisterNotice(kLoginNotification, @selector(showMainViewController));
    RegisterNotice(kLogoutNotification, @selector(showLoginViewController));
    
    // navigation Push规则
    [[JLRoutes globalRoutes] addRoute:@"/NaviPush/:controller" handler:^BOOL(NSDictionary<NSString *,NSString *> * _Nonnull parameters) {
        
        NSLog(@"parameters==%@",parameters);
        UIViewController *v = [[NSClassFromString(parameters[@"controller"]) alloc] init];
        [self paramToVc:v param:parameters];
        [[WMZDialogUntils getCurrentVC].navigationController pushViewController:v animated:YES];
        return YES;
    }];

    
    // 模态窗口规则
    [[JLRoutes globalRoutes] addRoute:@"/PresentModal/:controller" handler:^BOOL(NSDictionary<NSString *,NSString *> * _Nonnull parameters) {
        
        NSLog(@"parameters==%@",parameters);
        UIViewController *v = [[NSClassFromString(parameters[@"controller"]) alloc] init];
        [self paramToVc:v param:parameters];
        [[WMZDialogUntils getCurrentVC] presentViewController:v animated:YES completion:^{}];
        return YES;
    }];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
            
        [self showWelcomeViewController];
    }else {
            ////直接进入主界面
            
//        [self hsUpdateApp];
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
                //初始化开屏广告
//            [[xw_LaunchAdHelper shareManager] setupXHLaunchAd];
        }];
//        [self showMainViewController];
//        xw_UserInfoModel* model = [xw_UserInfoModel mj_objectWithKeyValues:[xw_ConfigHelper sharedInstance].sUserInfo];
//
//        GGLog(@"sUserInfo = %@",[xw_ConfigHelper sharedInstance].sUserInfo);
        if ([xw_ConfigHelper sharedInstance].isLogin) {
            [self showMainViewController];
        } else {
             [self showLoginViewController];
        }
//        [self showLoginViewController];
    }
    
}
    
-(void)paramToVc:(UIViewController *) v param:(NSDictionary<NSString *,NSString *> *)parameters{
    //        runtime将参数传递至需要跳转的控制器
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList(v.class , &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        NSString *param = parameters[key];
        if (param != nil) {
            [v setValue:param forKey:key];
        }
    }
}
    


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    NSLog(@"从哪个app跳转而来 Bundle ID: %@", options[UIApplicationOpenURLOptionsSourceApplicationKey]);
    NSLog(@"URL scheme:%@", [url scheme]);
    
#pragma mark - JLRoutes（默认的Scheme）
//    if ([[url scheme] isEqualToString: @"weixin"]) {
//        return   [[WeiXinPayTool shareTool] handleOpenURL:url];
//    } else {
//
//    }
    return [[JLRoutes globalRoutes] routeURL:url];
}
    
-(void)showLoginViewController{
    xw_LoginViewController *loginVC = [[xw_LoginViewController alloc] init];
    xw_NavigationController *nav = [[xw_NavigationController alloc] initWithRootViewController:loginVC];
    self.window.rootViewController = nav;
}
-(void)showMainViewController{
    xw_TabBarController *rootVC = [xw_TabBarController  tabBarControllerWithAddChildVCsBlock:^(xw_TabBarController *tabBarC) {
//
        [tabBarC addChildVC:[HomeViewController new] title:@"首页" normalImageName:@"tabbar_home_nor" selectedImageName:@"tabbar_home_sel" isRequiredNavController:YES];

        [tabBarC addChildVC:[OfficeViewController new] title:@"办事" normalImageName:@"tabbar_office_nor" selectedImageName:@"tabbar_office_sel" isRequiredNavController:YES];
        
        [tabBarC addChildVC:[MsgViewController new] title:@"消息" normalImageName:@"tabbar_msg_nor" selectedImageName:@"tabbar_msg_sel" isRequiredNavController:YES];
        
        [tabBarC addChildVC:[MyViewController new] title:@"我的" normalImageName:@"tabbar_my_nor" selectedImageName:@"tabbar_my_sel" isRequiredNavController:YES];
        
    }];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];

    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    
}
-(void)showWelcomeViewController{
    
    xw_WelcomeViewController *welcomeVC = [[xw_WelcomeViewController alloc] init];
    welcomeVC.skipClickBlock = ^{
//        [self showMainViewController];
        [self showLoginViewController];
    };
    xw_NavigationController *nav = [[xw_NavigationController alloc] initWithRootViewController:welcomeVC];
    self.window.rootViewController = nav;
}
/**
  *  天朝专用检测app更新
*/
-(void)hsUpdateApp
{
    //2先获取当前工程项目版本号
    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];

    //3从网络获取appStore版本号
    NSError *error;
    NSData *response = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",STOREAPPID]]] returningResponse:nil error:nil];
    if (response == nil) {
        NSLog(@"你没有连接网络哦");
        return;
    }
    NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    if (error) {
        NSLog(@"hsUpdateAppError:%@",error);
        return;
    }
//    NSLog(@"%@",appInfoDic);
    NSArray *array = appInfoDic[@"results"];
    NSDictionary *dic = array[0];
    NSString *appStoreVersion = dic[@"version"];
    //打印版本号
    NSLog(@"当前版本号:%@\n商店版本号:%@ \n 当前VC：%@",currentVersion,appStoreVersion,[WMZDialogUntils getCurrentVC]);
    //4当前版本号小于商店版本号,就更新
    if([NSString cmpNewVersion:appStoreVersion oldVersion:currentVersion])
    {

        UIAlertController *aleView=[UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"检测到新版本(%@),是否更新?",appStoreVersion] message:dic[@"releaseNotes"] preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *conform = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"点击了确认按钮");
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", STOREAPPID]];
           
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }];
        [aleView addAction:conform];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"点击了取消按钮");
        }];
        [aleView addAction:cancel];
        
        [[WMZDialogUntils getCurrentVC] presentViewController:aleView animated:YES completion:nil];

    }else{
        NSLog(@"版本号好像比商店大噢!检测到不需要更新");
    }
    
}

@end
