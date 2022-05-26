//
//  xw_LoginViewModel.h
//  XW_Object
//
//  Created by Benc Mai on 2019/11/28.
//  Copyright © 2019 武新义. All rights reserved.
//

#import "xw_BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface xw_LoginViewModel : xw_BaseViewModel
@property(nonatomic,strong)NSString* idCode;
@property(nonatomic,strong)NSString* account;
@property(nonatomic,strong)NSString* password;
@property(nonatomic,strong)NSString* roleId;
@property(nonatomic,strong)NSString* phone;
@property(nonatomic,strong)NSString* openid;
@property(nonatomic,strong)NSString* smsCode;


/**  请求命令  */
@property (nonatomic,strong) RACCommand * loginCommand;
@property (nonatomic,strong) RACCommand * registerCommand;
@property (nonatomic,strong) RACCommand * resetPwdCommand;
@property (nonatomic,strong) RACCommand * validationCommand;
@property (nonatomic,strong) RACCommand * bindDeviceTokenCommand;

@end

NS_ASSUME_NONNULL_END
