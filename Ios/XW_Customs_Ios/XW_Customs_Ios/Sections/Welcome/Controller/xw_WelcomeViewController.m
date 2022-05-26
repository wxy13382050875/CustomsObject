//
//  XWWelcomeViewController.m
//  PlayFC
//
//  Created by 武新义 on 2019/5/27.
//  Copyright © 2019 Davis. All rights reserved.
//

#import "xw_WelcomeViewController.h"
#import "DHGuidePageHUD.h"
@interface xw_WelcomeViewController ()

@end

@implementation xw_WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"欢迎页";
    [self setStaticGuidePage];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - 设置APP静态图片引导页
- (void)setStaticGuidePage {
    
    
    NSString* ratio;
    if (kIs_iPhoneX) {
        ratio = @"1242_2688_";
    } else {
        ratio = @"1242_2208_";
    }
    
    NSArray *imageNameArray = @[[NSString stringWithFormat:@"%@0.png",ratio],
                                [NSString stringWithFormat:@"%@1.png",ratio],
                                [NSString stringWithFormat:@"%@2.png",ratio]];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.view.frame imageNameArray:imageNameArray buttonIsHidden:NO];
    guidePage.slideInto = YES;
    @weakify(self);
    guidePage.skipButtonClickedBlock = ^{
        @strongify(self);
        self.skipClickBlock();
    };
    [self.navigationController.view addSubview:guidePage];
}

#pragma mark - 设置APP动态图片引导页
- (void)setDynamicGuidePage {
    @weakify(self);
    NSArray *imageNameArray = @[@"guideImage6.gif",@"guideImage7.gif",@"guideImage8.gif"];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.view.frame imageNameArray:imageNameArray buttonIsHidden:YES];
    guidePage.slideInto = YES;
    guidePage.skipButtonClickedBlock = ^{
        @strongify(self);
        [self.view removeFromSuperview];
        self.skipClickBlock();
    };
    [self.navigationController.view addSubview:guidePage];
}

#pragma mark - 设置APP视频引导页
- (void)setVideoGuidePage {
    @weakify(self);
    NSURL *videoURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"guideMovie1" ofType:@"mov"]];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.view.bounds videoURL:videoURL];
    guidePage.skipButtonClickedBlock = ^{
        @strongify(self);
        self.skipClickBlock();
    };
    [self.navigationController.view addSubview:guidePage];
}
@end
