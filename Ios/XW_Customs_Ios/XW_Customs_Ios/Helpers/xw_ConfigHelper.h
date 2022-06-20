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

//用户信息
@property(nonatomic,assign) NSString * userId;

//推送token
@property(nonatomic,assign) NSString *deviceToken;

//登陆状态
@property(nonatomic,assign) BOOL isLogin;

//推送token
@property(nonatomic,assign) BOOL isUMPush;

//账号信息
@property(nonatomic,strong) NSString *accountInfo;

//是否打开震动
@property(nonatomic,assign) BOOL isOpenVibration;

//登陆token
@property(nonatomic,assign) NSString *token;

//字典缓存
@property(nonatomic,assign) NSString *dict;

//可选机构列表
@property(nonatomic,assign) NSString *Orgs;

//委托单位信息
@property(nonatomic,assign) NSString *entrustOrg;

//当前所属机构ID
@property(nonatomic,assign) NSString *orgsId;
@end

NS_ASSUME_NONNULL_END
