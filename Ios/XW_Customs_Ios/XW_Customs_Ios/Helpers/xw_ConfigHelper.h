//
//  xw_ConfigHelper.h
//  XW_Object
//
//  Created by Benc Mai on 2019/12/3.
//  Copyright © 2019 武新义. All rights reserved.
//

#import <PAPreferences/PAPreferences.h>

NS_ASSUME_NONNULL_BEGIN

@interface xw_ConfigHelper : PAPreferences
//用户信息
@property(nonatomic,assign) NSString * sUserInfo;
//推送token
@property(nonatomic,assign) NSString *deviceToken;

//推送token
@property(nonatomic,assign) BOOL isUMPush;

//账号信息
@property(nonatomic,strong) NSString *accountInfo;

//是否打开震动
@property(nonatomic,assign) BOOL isOpenVibration;
@end

NS_ASSUME_NONNULL_END
