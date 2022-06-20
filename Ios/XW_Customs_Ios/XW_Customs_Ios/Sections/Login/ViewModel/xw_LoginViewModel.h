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
@property(nonatomic,strong)NSString* username;
@property(nonatomic,strong)NSString* password;


/**  请求命令  */
@property (nonatomic,strong) RACCommand * loginCommand;
@property (nonatomic,strong) RACCommand * registerCommand;
@property (nonatomic,strong) RACCommand * currentInfoCommand;
@property (nonatomic,strong) RACCommand * allDictCommand;
@property (nonatomic,strong) RACCommand * canSelectOrgsCommand;
@property (nonatomic,strong) RACCommand * entrustOrgByIdCommand;

@end

NS_ASSUME_NONNULL_END
