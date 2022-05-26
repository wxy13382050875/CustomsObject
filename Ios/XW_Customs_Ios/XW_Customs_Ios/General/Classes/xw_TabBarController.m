//
//  xw_TabBarController.m
//  XW_Object
//
//  Created by 武新义 on 2019/11/19.
//  Copyright © 2019年 武新义. All rights reserved.
//

#import "xw_TabBarController.h"
#import "xw_NavigationController.h"
#import "UIImage+XWAdd.h"
//#import <Lottie/Lottie.h>

#import <AudioToolbox/AudioToolbox.h>
@interface XWTabBar : UITabBar

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation XWTabBar
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        //设置tabbar背景
//        self.backgroundImage = ;
//        [self setBackgroundImage:[UIImage imageNamed:@"tabbar_icon_bg"]];
        [self setBackgroundImage:[UIImage imageWithColor:COLOR(@"#F8F8F8")]];
//        [self setBackgroundColor:COLOR(@"#E7E8EB")];
        
        [self setShadowImage:[UIImage new]];
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
     
//    Class class = NSClassFromString(@"UITabBarButton");
//    int index = 0;
//    for (UIView *subView in self.subviews){
//        if ([subView isKindOfClass:class]) {
//
//            if (index == 2) {
//                //index=2时为中间按钮，添加
//                self.imageView.frame = CGRectMake(0, -12.5, subView.frame.size.width, 50);
//                NSLog(@" frame = %@",NSStringFromCGRect(self.imageView.frame));
//                [subView insertSubview:self.imageView atIndex:0];
//            }
//            index ++;
//        }
//    }
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar_workbench_nor"]];
        
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

@end

@interface xw_TabBarController ()<UITabBarControllerDelegate>
@property(nonatomic, assign) NSInteger indexFlag;
/// 关联到 controller 原因：解决快速点击两个不一样的 tabbar 后，需要关闭第一次点击的动画
//@property(nonatomic, strong) LOTAnimationView *animationView;
@end

@implementation xw_TabBarController

-(void)viewDidLoad{
    [super viewDidLoad];
    if (@available(iOS 15.0, *)) {
            
            self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance;
        }
    
}
+ (instancetype)shareInstance {
    
    static xw_TabBarController *tabbarC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tabbarC = [[xw_TabBarController alloc] init];
        [self setValue:[[XWTabBar alloc] init] forKey:@"tabBar"];
    });
    return tabbarC;
}

+ (instancetype)tabBarControllerWithAddChildVCsBlock: (void(^)(xw_TabBarController *tabBarC))addVCBlock {
    
    xw_TabBarController *tabbarVC = [[xw_TabBarController alloc] init];
   
    [tabbarVC setValue:[[XWTabBar alloc] init] forKey:@"tabBar"];
    
    if (addVCBlock) {
        addVCBlock(tabbarVC);
    }
    
    return tabbarVC;
}


/**
 *  根据参数, 创建并添加对应的子控制器
 *
 *  @param vc                需要添加的控制器(会自动包装导航控制器)
 *  @param isRequired             标题
 *  @param normalImageName   一般图片名称
 *  @param selectedImageName 选中图片名称
 */
- (void)addChildVC: (UIViewController *)vc title: (NSString *)title normalImageName: (NSString *)normalImageName selectedImageName:(NSString *)selectedImageName isRequiredNavController: (BOOL)isRequired {
    
    self.tabBar.backgroundColor =COLOR(@"#E7E8EB");
    
    xw_NavigationController *nvc = [[xw_NavigationController alloc] initWithRootViewController:vc];
    nvc.tabBarItem.title = title;
    
    nvc.tabBarItem.image = [[UIImage imageNamed:normalImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nvc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    [self addChildViewController:nvc];
    
    
//    if (isRequired) {
//        xw_NavigationController *nav = [[xw_NavigationController alloc] initWithRootViewController:vc];
//        vc.title = title;
//        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage originImageWithName:normalImageName] selectedImage:[UIImage originImageWithName:selectedImageName]];
//        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:COLOR(@"#1F7EFE")} forState:UIControlStateSelected];
//        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:COLOR(@"#868686")} forState:UIControlStateNormal];
//        [self addChildViewController:nav];
//    }else {
//        [self addChildViewController:vc];
//    }
    
}
-(void)setSelectItem:(NSInteger)index{
//    self.tabBar.selectedItem = self.tabBar.items[index];
    self.selectedIndex = index;
    [self tabBar:self.tabBar didSelectItem:self.tabBar.items[index]];
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    NSInteger index = [self.tabBar.items indexOfObject:item];
    NSLog(@"%d",[xw_ConfigHelper sharedInstance].isOpenVibration);
    if ([xw_ConfigHelper sharedInstance].isOpenVibration) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//默认震动效果
        
    }
    
//    if (self.animationView ) {
//        [self.animationView stop];
//        [self.animationView removeFromSuperview];
//        self.animationView = nil;
//    }
//
//
//    for (UITabBarItem* item in self.tabBar.items) {
//        item.imageInsets = UIEdgeInsetsMake(0, 0, 0,0);
//    }
////    self.tabBar.items[index].imageInsets = UIEdgeInsetsMake(-6, 0, 6, 0);
//
//    NSMutableArray <UIImageView *>*tabBarSwappableImageViews = [NSMutableArray array];
//    CGFloat width = 0;
//    //2.
//    for (UIView *tempView in self.tabBar.subviews) {
//
//        if ([tempView isKindOfClass:NSClassFromString(@"UITabBarButton")])
//        {
////            tempView.backgroundColor =
//            width = tempView.frame.size.width;
//            //2.1
//            for (UIImageView *tempImageView in tempView.subviews) {
//                if ([tempImageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
//                    NSLog(@"index = %ld frame = %@",(long)index,NSStringFromCGRect(tempImageView.frame));
//                    tempImageView.hidden = NO;
//                    if(index== 2){
//                        tempImageView.frame = CGRectMake(0, -12.5, width, 50);
//                    }
//                    [tabBarSwappableImageViews addObject:tempImageView];
//                }
//            }
//        }
//    }
//
//
//
//
//
//    //设置图片的位置
//
//
//    //3.
//    __block UIImageView *currentTabBarSwappableImageView = tabBarSwappableImageViews[index];
//
//    NSLog(@"index = %ld frame = %@",(long)index,NSStringFromCGRect(currentTabBarSwappableImageView.frame));
//
//    __block LOTAnimationView *animationView = [self getAnimationViewAtTabbarIndex:index frame:currentTabBarSwappableImageView.frame];
//    self.animationView = animationView;
//
////    if (index !=2)
//    {
//        animationView.center = currentTabBarSwappableImageView.center;
//    }
//
////    animationView.center = currentTabBarSwappableImageView.center;
//    [currentTabBarSwappableImageView.superview addSubview:animationView];
//    [animationView bringSubviewToFront:currentTabBarSwappableImageView.superview];
//    currentTabBarSwappableImageView.hidden = YES;
//
//    //6.
//    [animationView playFromProgress:0 toProgress:1 withCompletion:^(BOOL animationFinished) {
//
//
//
//    }];
}

/**
 * 初始化子控制器
 */


#pragma mark - Animation

//- (LOTAnimationView *)getAnimationViewAtTabbarIndex:(NSInteger)index frame:(CGRect)frame {
//    
//    // tabbar1 。。。 tabbar3
//    LOTAnimationView *view = [LOTAnimationView animationNamed:[NSString stringWithFormat:@"tabbar_%ld",index]];
//    view.frame = frame;
//    view.contentMode = UIViewContentModeScaleAspectFill;
//    view.animationSpeed = 1;
//    return view;
//}


@end
