//
//  xw_BaseViewController.m
//  XW_Object
//
//  Created by 武新义 on 2019/11/19.
//  Copyright © 2019年 武新义. All rights reserved.
//

#import "xw_BaseViewController.h"

@interface xw_BaseViewController ()
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;
@property (nonatomic, assign) BOOL statusBarHidden;
@property (nonatomic, assign) BOOL changeStatusBarAnimated;
@end

@implementation xw_BaseViewController
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    xw_BaseViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        
        @strongify(viewController)
        [viewController xw_setupUI];
        [viewController xw_bindViewModel];
    }];
    
    [[viewController rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        
        @strongify(viewController)
        [viewController xw_layoutNavigation];
        [viewController xw_loadDataSource];
    }];
    
    return viewController;
}

- (instancetype)initWithViewModel:(id<xw_ViewModelProtocol>)viewModel {
    
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setIsExtendLayout:NO];
    
    [self yd_removeNavgationBarLine];
    
//    [self layoutNavigationBar:ImageNamed(@"navigationBarBG@2x.png") titleColor:black_color titleFont:YC_YAHEI_FONT(18) leftBarButtonItem:nil rightBarButtonItem:nil];
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    
    self.view.backgroundColor = COLOR(@"#eeeeee");
}

#pragma mark - system

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if (self.statusBarStyle) {
        
        return self.statusBarStyle;
    } else {
        
        return UIStatusBarStyleLightContent;
    }
}

- (BOOL)prefersStatusBarHidden {
    
    return self.statusBarHidden;
}

- (void)dealloc {
    
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}

#pragma mark - private
/**
 *  去除nav 上的line
 */
- (void)yd_removeNavgationBarLine {
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        
        NSArray *list=self.navigationController.navigationBar.subviews;
        
        for (id obj in list) {
            
            if ([obj isKindOfClass:[UIImageView class]]) {
                
                UIImageView *imageView=(UIImageView *)obj;
                
                NSArray *list2=imageView.subviews;
                
                for (id obj2 in list2) {
                    
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        
                        UIImageView *imageView2=(UIImageView *)obj2;
                        
                        imageView2.hidden=YES;
                        
                    }
                }
            }
        }
    }
}

- (void)setIsExtendLayout:(BOOL)isExtendLayout {
    
    if (!isExtendLayout) {
        [self initializeSelfVCSetting];
    }
}

- (void)initializeSelfVCSetting {
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}

- (void)changeStatusBarStyle:(UIStatusBarStyle)statusBarStyle
             statusBarHidden:(BOOL)statusBarHidden
     changeStatusBarAnimated:(BOOL)animated {
    
    self.statusBarStyle=statusBarStyle;
    self.statusBarHidden=statusBarHidden;
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
        }];
    }
    else{
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)hideNavigationBar:(BOOL)isHide
                 animated:(BOOL)animated{
    
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.navigationController.navigationBarHidden=isHide;
        }];
    }
    else{
        self.navigationController.navigationBarHidden=isHide;
    }
}

- (void)layoutNavigationBar:(UIImage*)backGroundImage
                 titleColor:(UIColor*)titleColor
                  titleFont:(UIFont*)titleFont
          leftBarButtonItem:(UIBarButtonItem*)leftItem
         rightBarButtonItem:(UIBarButtonItem*)rightItem {
    
    if (backGroundImage) {
        [self.navigationController.navigationBar setBackgroundImage:backGroundImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    if (titleColor&&titleFont) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor,NSFontAttributeName:titleFont}];
    }
    else if (titleFont) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:titleFont}];
    }
    else if (titleColor){
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor}];
    }
    if (leftItem) {
        self.navigationItem.leftBarButtonItem=leftItem;
    }
    if (rightItem) {
        self.navigationItem.rightBarButtonItem=rightItem;
    }
}

#pragma mark - 屏幕旋转
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate {
    
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return UIInterfaceOrientationPortrait;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)xw_setupUI{
    
}
-(void)xw_loadDataSource{
    
}
-(void)xw_layoutNavigation{
    if (@available(iOS 13.0, *)) {
        self.statusBarStyle = UIStatusBarStyleDarkContent;
    } else {
        // Fallback on earlier versions
    }
}
-(void)xw_loadNewData{

    
}
-(void)xw_loadMoreData{
    
}
#pragma mark - MobClickLinkDelegate

- (void)getLinkPath:(NSString *)path params:(NSDictionary *)params
{
    //处理U_Link 超链接跳转
//    DeeplinkViewController *dlvc = [[DeeplinkViewController alloc] initWithNibName:nil bundle:nil];
//    dlvc.path = path;
//    dlvc.params = params;
//    if (self.install_params) {
//        dlvc.install_params = self.install_params;
//    }
//    [self.navigationController pushViewController:dlvc animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
