//
//  xw_LoginViewModel.m
//  XW_Object
//
//  Created by Benc Mai on 2019/11/28.
//  Copyright © 2019 武新义. All rights reserved.
//

#import "xw_LoginViewModel.h"
//#import "xw_UserInfoModel.h"
@implementation xw_LoginViewModel
- (instancetype)init
{
    if(self = [super init])
    {
//        [self initViewModel];
    }
    return self;
}
-(void)xw_initialize
{
//    @weakify(self);
//    [self loginViewModel];
//    [self registerViewModel];
//    [self resetPwdViewModel];
    
}
-(RACCommand*)loginCommand{
    if (!_loginCommand) {
        _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                
                
                [PPNetworkHelper POST:[xw_HttpRequest xw_LoginUrl] parameters:input responseCache:^(id responseCache) {
//                    [subscriber sendNext:responseCache];
                } success:^(id responseObject) {
                    if ([responseObject[@"code"] integerValue] == 200) {
                        GGLog(@"-----%@",[NSString DataTOjsonString:responseObject[@"data"]]);
//                        xw_UserInfoModel* model = [xw_UserInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
//                        GGLog(@"-----%@",[NSString DataTOjsonString:responseObject[@"data"]]);
                        [xw_ConfigHelper sharedInstance].sUserInfo = @"";
                        [subscriber sendNext:responseObject];
                        
                    } else {
//                        [subscriber sendError:responseObject[@"msg"]];
                        Dialog().wTypeSet(DialogTypeAuto).wMessageSet(responseObject[@"msg"]).wDisappelSecondSet(1).wStart();
                    }
                    [subscriber sendCompleted];
                               
                } failure:^(NSError *error) {
                    [subscriber sendError:error];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _loginCommand;
}
-(RACCommand*)registerCommand{
    if (!_registerCommand) {
        _registerCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                
//                [params setValue:self.openid forKey:@"openid"];
                [PPNetworkHelper POST:[xw_HttpRequest xw_RegisterUrl] parameters:input responseCache:^(id responseCache) {
//                   [subscriber sendNext:responseCache];
                } success:^(id responseObject) {
                    if ([responseObject[@"code"] integerValue] == 200) {
                        
                        [subscriber sendNext:responseObject];
                    } else {
//                        [subscriber sendError:responseObject[@"msg"]];
                        Dialog().wTypeSet(DialogTypeAuto).wMessageSet(responseObject[@"msg"]).wDisappelSecondSet(1).wStart();
                    }
                    
                    [subscriber sendCompleted];
                               
                } failure:^(NSError *error) {
                    [subscriber sendError:error];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];

    }
    return _registerCommand;
}

-(RACCommand*)resetPwdCommand{
    if (!_resetPwdCommand) {
        _resetPwdCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                
                [PPNetworkHelper POST:[xw_HttpRequest xw_ResetPasswordUrl] parameters:input responseCache:^(id responseCache) {
//                    [subscriber sendNext:responseCache];
                } success:^(id responseObject) {
                    if ([responseObject[@"code"] integerValue] == 200) {
                        [subscriber sendNext:responseObject];
                    } else {
//                        [subscriber sendError:responseObject[@"msg"]];
                        Dialog().wTypeSet(DialogTypeAuto).wMessageSet(responseObject[@"msg"]).wDisappelSecondSet(1).wStart();
                    }
                    [subscriber sendCompleted];
                               
                } failure:^(NSError *error) {
                    [subscriber sendError:error];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _resetPwdCommand;
}

-(RACCommand*)validationCommand{
    if (!_validationCommand) {
        _validationCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                
                
                [PPNetworkHelper POST:[xw_HttpRequest xw_SendCodeUrl] parameters:input responseCache:^(id responseCache) {
//                    [subscriber sendNext:responseCache];
                } success:^(id responseObject) {
                    
                   
                    [subscriber sendNext:responseObject];
                    [subscriber sendCompleted];
                               
                } failure:^(NSError *error) {
                    [subscriber sendError:error];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _validationCommand;
}
-(RACCommand*)bindDeviceTokenCommand{
    if (!_bindDeviceTokenCommand) {
        _bindDeviceTokenCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
       
                if ([xw_ConfigHelper sharedInstance].deviceToken.length == 0) {
                    [xw_ConfigHelper sharedInstance].sUserInfo = @"";
                    Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"未获取到手机deviceToken").wDisappelSecondSet(1).wStart();
                    [subscriber sendCompleted];
                    return nil;
                }
                NSMutableDictionary* params = [NSMutableDictionary dictionary];
                [params setValue:[xw_ConfigHelper sharedInstance].deviceToken forKey:@"deviceToken"];
                
                [PPNetworkHelper POST:[xw_HttpRequest xw_BindDeviceTokenUrl] parameters:params responseCache:^(id responseCache) {
//                    [subscriber sendNext:responseCache];
                } success:^(id responseObject) {
                    
                    
                    [subscriber sendNext:responseObject];
                    [subscriber sendCompleted];
                               
                } failure:^(NSError *error) {
                    [subscriber sendError:error];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _bindDeviceTokenCommand;
}
@end
