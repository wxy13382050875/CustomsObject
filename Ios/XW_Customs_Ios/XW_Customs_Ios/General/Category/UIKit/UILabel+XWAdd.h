//
//  UILabel+NXAdd.h
//  NCube
//
//  Created by kepuna on 2016/12/16.
//  Copyright © 2016年 junjie.liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XWAttributeTapActionDelegate <NSObject>
@optional
/**
 *  YBAttributeTapActionDelegate
 *
 *  @param string  点击的字符串
 *  @param range   点击的字符串range
 *  @param index 点击的字符在数组中的index
 */
- (void)xw_tapAttributeInLabel:(UILabel *)label
                        string:(NSString *)string
                         range:(NSRange)range
                         index:(NSInteger)index;
@end

@interface UILabel (XWAdd)
/**
 *  是否打开点击效果，默认是打开
 */
@property (nonatomic, assign) BOOL enabledTapEffect;

/**
 *  点击高亮色 默认是[UIColor lightGrayColor] 需打开enabledTapEffect才有效
 */
@property (nonatomic, strong) UIColor * tapHighlightedColor;

/**
 *  是否扩大点击范围，默认是打开
 */
@property (nonatomic, assign) BOOL enlargeTapArea;

/**
 *  给文本添加点击事件Block回调
 *
 *  @param strings  需要添加的字符串数组
 *  @param tapClick 点击事件回调
 */
- (void)xw_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                 tapClicked:(void (^) (UILabel * label, NSString *string, NSRange range, NSInteger index))tapClick;

/**
 *  给文本添加点击事件delegate回调
 *
 *  @param strings  需要添加的字符串数组
 *  @param delegate delegate
 */
- (void)xw_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                   delegate:(id <XWAttributeTapActionDelegate> )delegate;

/**
 *  根据range给文本添加点击事件Block回调
 *
 *  @param ranges  需要添加的Range字符串数组
 *  @param tapClick 点击事件回调
 */
- (void)xw_addAttributeTapActionWithRanges:(NSArray <NSString *> *)ranges
                                 tapClicked:(void (^) (UILabel * label, NSString *string, NSRange range, NSInteger index))tapClick;

/**
 *  根据range给文本添加点击事件delegate回调
 *
 *  @param ranges  需要添加的Range字符串数组
 *  @param delegate delegate
 */
- (void)xw_addAttributeTapActionWithRanges:(NSArray <NSString *> *)ranges
                                   delegate:(id <XWAttributeTapActionDelegate> )delegate;

/**
 *  删除label上的点击事件
 */
- (void)xw_removeAttributeTapActions;

/**
 设置文本,并指定行间距
 
 @param text 文本内容
 @param lineSpacing 行间距
 */
-(void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;

#pragma -mark UILabel常用全部属性
+ (UILabel*)labelWithText:(NSString*)text
            WithTextColor:(UIColor*)textColor
            WithNumOfLine:(NSInteger)numline
            WithBackColor:(UIColor*)backColor
        WithTextAlignment:(NSTextAlignment)TextAlignment
                 WithFont:(CGFloat)Font;
#pragma -mark 线
+ (UILabel*)labelWithLine:(UIColor*)backColor;

- (void)alignTop;
- (void)alignBottom;
@end
