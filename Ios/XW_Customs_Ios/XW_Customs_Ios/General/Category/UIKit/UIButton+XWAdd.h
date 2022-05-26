//
//  UIButton+XWAdd.h
//  XW_Object
//
//  Created by Benc Mai on 2019/12/6.
//  Copyright © 2019 武新义. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+XWAdd.h"

#define COUNTDOWNTITLE @"重新获取"
#define GETCODETITLE @"获取验证码"

typedef NS_ENUM(NSUInteger, XWLayoutStatus){
    /** 正常位置，图左字右 */
    XWLayoutStatusNormal,
    /** 图右字左 */
    XWLayoutStatusImageRight,
    /** 图上字下 */
    XWLayoutStatusImageTop,
    /** 图下字上 */
    XWLayoutStatusImageBottom,
};
NS_ASSUME_NONNULL_BEGIN

@interface UIButton (XWAdd)

- (void)layoutWithStatus:(XWLayoutStatus)status andMargin:(CGFloat)margin;

/**
 *  根据给定的颜色，设置按钮的颜色
 *  @param btnSize  这里要求手动设置下生成图片的大小，防止coder使用第三方layout,没有设置大小
 *  @param clrs     渐变颜色的数组
 */
- (UIButton *)gradientButtonWithSize:(CGSize)btnSize
                          colorArray:(NSArray *)clrs
                        gradientType:(XWGradientType)type;


+ (UIButton*)buttonWithTitie:(NSString*)title
               WithtextColor:(UIColor*  __nullable)color
               WithBackColor:(UIColor*  __nullable)backColor
               WithBackImage:(UIImage*  __nullable)backImage
                   WithImage:(UIImage*  __nullable)Image
                    WithFont:(CGFloat)font
                  EventBlock:(void(^)(id params))eventBlock;

///设置倒计时
- (void)setCountdown:(NSTimeInterval )timeOut;
///手动结束倒计时 离开页面之前 请务必调用
- (void)cancelCountdown;
@end

NS_ASSUME_NONNULL_END
