//
//  UIButton+XWAdd.m
//  XW_Object
//
//  Created by Benc Mai on 2019/12/6.
//  Copyright © 2019 武新义. All rights reserved.
//

#import "UIButton+XWAdd.h"
static dispatch_source_t _timer;
@implementation UIButton (XWAdd)
- (void)layoutWithStatus:(XWLayoutStatus)status andMargin:(CGFloat)margin{
    CGFloat imgWidth = self.imageView.bounds.size.width;
    CGFloat imgHeight = self.imageView.bounds.size.height;
    CGFloat labWidth = self.titleLabel.bounds.size.width;
    CGFloat labHeight = self.titleLabel.bounds.size.height;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (labWidth < frameSize.width) {
        labWidth = frameSize.width;
    }
    CGFloat kMargin = margin/2.0;
    switch (status) {
        case XWLayoutStatusNormal://图左字右
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, -kMargin, 0, kMargin)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, kMargin, 0, -kMargin)];
            break;
        case XWLayoutStatusImageRight://图右字左
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, labWidth + kMargin, 0, -labWidth - kMargin)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imgWidth - kMargin, 0, imgWidth + kMargin)];
            break;
        case XWLayoutStatusImageTop://图上字下
            [self setImageEdgeInsets:UIEdgeInsetsMake(0,0, labHeight + margin, -labWidth)];
            
            [self setTitleEdgeInsets:UIEdgeInsetsMake(imgHeight + margin, -imgWidth, 0, 0)];
            break;
        case XWLayoutStatusImageBottom://图下字上
            [self setImageEdgeInsets:UIEdgeInsetsMake(labHeight + margin,0, 0, -labWidth)];
            
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imgWidth, imgHeight + margin, 0)];
            
            break;
        default:
            break;
    }
}
- (UIButton *)gradientButtonWithSize:(CGSize)btnSize colorArray:(NSArray *)clrs  gradientType:(XWGradientType)type {
    
    UIImage *backImage = [UIImage createImageWithSize:btnSize gradientColors:clrs  gradientType:type];
    
    [self setBackgroundImage:backImage forState:UIControlStateNormal];
    
    return self;
}
+ (UIButton*)buttonWithTitie:(NSString*)title
               WithtextColor:(UIColor*)color
               WithBackColor:(UIColor*)backColor
               WithBackImage:(UIImage*)backImage
                   WithImage:(UIImage*)Image
                    WithFont:(CGFloat)font
                  EventBlock:(void(^)(id params))eventBlock
{
    UIButton* XWBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (title) {
        [XWBtn setTitle:title forState:UIControlStateNormal];
    }
    if (color) {
        [XWBtn setTitleColor:color forState:UIControlStateNormal];
    }
    if (Image) {
        [XWBtn setImage:Image forState:UIControlStateNormal];
    }
    if (backColor) {
        XWBtn.backgroundColor = backColor;
    }
    if (backImage) {
        [XWBtn setBackgroundImage:backImage forState:UIControlStateNormal];
    }
    if (font!=0) {
        XWBtn.titleLabel.font=[UIFont systemFontOfSize:font];
    }
    
    [[XWBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (eventBlock) {
            eventBlock(x);
        }
    }];
    return XWBtn;
    
}
- (void)setCountdown:(NSTimeInterval )timeOut{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    //每秒执行
    //得到当前时间
    NSTimeInterval startTime = time(NULL);
    NSTimeInterval endTime = startTime + timeOut;
//    self.backgroundColor = [UIColor grayColor];
    dispatch_source_set_event_handler(_timer, ^{
        NSTimeInterval curtime = time(NULL);
        if(curtime>=endTime){ //倒计时结束，关闭
            [self cancelCountdown];
            
        }else{
            
            int seconds = endTime-curtime;
            NSLog(@"--%d",seconds);
            NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:[NSString stringWithFormat:@"%@(%@)",COUNTDOWNTITLE,strTime] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
                
            });
            
        }
    });
    dispatch_resume(_timer);
    
}
- (void)cancelCountdown
{
    if(_timer)
    {
        
        dispatch_source_cancel(_timer);
        dispatch_async(dispatch_get_main_queue(), ^{
            //设置界面的按钮显示 根据自己需求设置（倒计时结束后调用）
             [self setTitle:GETCODETITLE forState:UIControlStateNormal];
             self.userInteractionEnabled = YES;
            
        });
    }
}
@end
