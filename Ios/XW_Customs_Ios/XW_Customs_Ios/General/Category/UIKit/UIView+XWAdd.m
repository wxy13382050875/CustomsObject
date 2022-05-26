//
//  UIView+Awesome.m
//  ChatDemo-UI3.0
//
//  Created by Davis on 16/12/26.
//  Copyright © 2016年 Davis. All rights reserved.
//

#import "UIView+XWAdd.h"
#import <objc/runtime.h>
#import "XKEmptyPlaceView.h"
@implementation UIView (XWAdd)

/// 添加四边阴影效果
- (void)addShadowToView:(UIColor *)theColor {
    // 阴影颜色
    self.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    self.layer.shadowOffset = CGSizeMake(0,0);
    // 阴影透明度，默认0
    self.layer.shadowOpacity = 0.5;
    // 阴影半径，默认3
    self.layer.shadowRadius = 5;
}

+(void)showErrorPage:(UIScrollView *)scrollView ImgName:(NSString*)imgName title:(NSString *)title des:(NSString *)des block:(void (^)(void))block{
    XMEmptyViewConfig *config = [XMEmptyViewConfig new];
    config.titleFont = [UIFont systemFontOfSize:18];
    config.titleColor = COLOR(@"#9E9E9E");
    config.btnBackImg = [UIColor orangeColor];
    config.btnColor = [UIColor yellowColor];
    config.btnFont = [UIFont systemFontOfSize:17];
    config.topMutiOffset = 0.2;
    config.btnMargin = 50;
    config.spaceImgBtmHeight = 25;
    config.spaceDesBtmHeight = 20;
    config.spaceTitleBtmHeight = 30;
    config.backgroundColor = [UIColor whiteColor];
    NSLog(@"frame = %@",NSStringFromCGRect(scrollView.frame));
    XKEmptyPlaceView *emptyView = [XKEmptyPlaceView configScrollView:scrollView config:config];
    [emptyView showWithImgName:imgName title:title des:des tapClick:^{
        if (block != nil) {
            [emptyView hide];
            block();
        }
        
    }];
}
+(void)hideErrorPage:(UIScrollView*_Nullable)scrollView{
    XMEmptyViewConfig *config = [XMEmptyViewConfig new];
    config.titleFont = [UIFont systemFontOfSize:12];
    config.titleColor = COLOR(@"##9E9E9E");
    config.btnBackImg = [UIColor orangeColor];
    config.btnColor = [UIColor whiteColor];
    config.btnFont = [UIFont systemFontOfSize:17];
    config.topMutiOffset = 0.2;
    config.btnMargin = 50;
    config.spaceImgBtmHeight = 25;
    config.spaceDesBtmHeight = 20;
    config.spaceTitleBtmHeight = 30;
    config.backgroundColor = [UIColor whiteColor];
    XKEmptyPlaceView *emptyView = [XKEmptyPlaceView configScrollView:scrollView config:config];
    [emptyView hide];
}
@end
