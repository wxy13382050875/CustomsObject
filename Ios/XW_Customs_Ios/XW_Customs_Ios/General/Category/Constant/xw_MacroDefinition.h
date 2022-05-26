//
//  xw_MacroDefinition.h
//  XW_Object
//
//  Created by 武新义 on 2019/11/20.
//  Copyright © 2019年 武新义. All rights reserved.
//

#ifndef xw_MacroDefinition_h
#define xw_MacroDefinition_h

//获取系统对象
#define KApplication        [UIApplication sharedApplication]
#define KAppWindow          [UIApplication sharedApplication].delegate.window
#define KAppDelegate        [AppDelegate shareAppDelegate]
#define KRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define KUserDefaults       [NSUserDefaults standardUserDefaults]

#define KNotificationCenter [NSNotificationCenter defaultCenter]

#define RegisterNotice(_name, _selector)                    \
[KNotificationCenter addObserver:self  \
selector:_selector name:_name object:nil];

#define kLoginNotification            @"kLoginNotification"
#define kLogoutNotification           @"kLogoutNotification"
//获取当前语言
#define KCURRENT_LANGUAGE ([[NSLocale preferredLanguages] objectAtIndex:0])
//判断是否为iPhone
#define KIS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//判断是否为iPad
#define KIS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


// 操作系统版本号
#define IOS_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])
#define IS_LANDSCAPE UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])
// 屏幕宽度，会根据横竖屏的变化而变化
#define SCREEN_WIDTH (IOS_VERSION >= 8.0 ? [[UIScreen mainScreen] bounds].size.width : (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width))

#define SCREEN_HEIGHT (IOS_VERSION >= 8.0 ? [[UIScreen mainScreen] bounds].size.height : (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height))
// 屏幕宽度，跟横竖屏无关
#define DEVICE_WIDTH (IOS_VERSION >= 8.0 ? (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width) : [[UIScreen mainScreen] bounds].size.width)
static inline CGFloat xwValue(CGFloat value) {
    return (value / 375.0f * DEVICE_WIDTH);
}

#define kIs_iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kIs_iPhoneX SCREEN_WIDTH >=375.0f && SCREEN_HEIGHT >=812.0f&& kIs_iphone

/*状态栏高度*/
#define kStatusBarHeight (CGFloat)(kIs_iPhoneX?(44.0):(20.0))
/*导航栏高度*/
#define kNavBarHeight (44)
/*状态栏和导航栏总高度*/
#define kNavBarAndStatusBarHeight (CGFloat)(kIs_iPhoneX?(88.0):(64.0))
/*TabBar高度*/
#define kTabBarHeight (CGFloat)(kIs_iPhoneX?(49.0 + 34.0):(49.0))
/*顶部安全区域远离高度*/
#define kTopBarSafeHeight (CGFloat)(kIs_iPhoneX?(44.0):(0))
/*底部安全区域远离高度*/
#define kBottomSafeHeight (CGFloat)(kIs_iPhoneX?(34.0):(0))
/*iPhoneX的状态栏高度差值*/
#define kTopBarDifHeight (CGFloat)(kIs_iPhoneX?(24.0):(0))
/*导航条和Tabbar总高度*/
#define kNavAndTabHeight (kNavBarAndStatusBarHeight + kTabBarHeight)



#define IMG(name) [UIImage imageNamed:name]

#define MUID    [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]

/* regist cell(xib) */
#define kRegistCell(tableView, cellName, identifier) [tableView registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellReuseIdentifier:identifier];

#define kRegistClassCell(tableView, cellName, identifier) [tableView registerClass:cellName forCellReuseIdentifier:identifier]

#define kRegistCollection(collectionView, cellName, identifier)  [collectionView registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellWithReuseIdentifier:identifier];

#define kSetMJRefresh(view) MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(xw_loadNewData)];\
header.lastUpdatedTimeLabel.hidden = YES;\
view.mj_header = header;\
MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(xw_loadMoreData)];\
view.mj_footer = footer;\
[view.mj_header beginRefreshing];

// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]



//获取temp
#define KPathTemp NSTemporaryDirectory()

//获取沙盒 Document
#define KPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

//获取沙盒 Cache
#define KPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

// RGB颜色
#define KColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define COLOR(a) [UIColor colorWithHexString:a]


#define FONT(a) [UIFont systemFontOfSize:a]
//字符串是否为空
#define KString_Is_Empty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define KArray_Is_Empty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define KDict_Is_Empty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define KObject_Is_Empty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))



//将对象转换成弱引用类型，有block时使用
#define WeakObj(obj) __block __weak typeof(obj) weak_##obj = obj
#define StrongObj(type) __strong typeof(type) type = weak##type;


//DEBUG模式下,打印日志(包括函数名、行号)
#ifdef DEBUG
# define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
# define NLog(...)




#endif






#endif /* xw_MacroDefinition_h */
