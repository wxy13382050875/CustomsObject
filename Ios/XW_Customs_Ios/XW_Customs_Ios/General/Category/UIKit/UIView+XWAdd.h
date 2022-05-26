//
//  UIView+Awesome.h
//  ChatDemo-UI3.0
//
//  Created by Davis on 16/12/26.
//  Copyright © 2016年 Davis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XWAdd)
/// 添加四边阴影效果
- (void)addShadowToView:(UIColor *)theColor ;

//显示自定义错误页面
+ (void)showErrorPage:(UIScrollView *)scrollView ImgName:(NSString*)imgName title:(NSString *)title des:(NSString *)des block:(void (^)(void))block;
//隐藏错误页面
+ (void)hideErrorPage:(UIScrollView*_Nullable)scrollView;
@end
