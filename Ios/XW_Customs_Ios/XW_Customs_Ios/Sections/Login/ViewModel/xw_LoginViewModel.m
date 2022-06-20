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

-(RACCommand*)currentInfoCommand{
    if (!_currentInfoCommand) {
        _currentInfoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                
                [PPNetworkHelper GET:[xw_HttpRequest xw_GetCurrentUserInfoUrl] parameters:input success:^(id responseObject) {
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
    return _currentInfoCommand;
}

-(RACCommand*)allDictCommand{
    if (!_allDictCommand) {
        _allDictCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                
                
                [PPNetworkHelper GET:[xw_HttpRequest xw_GetAllDictUrl] parameters:input responseCache:^(id responseCache) {
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
    return _allDictCommand;
}
-(RACCommand*)canSelectOrgsCommand{
    if (!_canSelectOrgsCommand) {
        _canSelectOrgsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
       
                
                
                [PPNetworkHelper GET:[xw_HttpRequest xw_GetCanSelectOrgsUrl:[xw_ConfigHelper sharedInstance].userId] parameters:input responseCache:^(id responseCache) {
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
    return _canSelectOrgsCommand;
}
-(RACCommand*)entrustOrgByIdCommand{
    if (!_entrustOrgByIdCommand) {
        _entrustOrgByIdCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
       
                
                
                [PPNetworkHelper GET:[xw_HttpRequest xw_getEntrustOrgByUserIdUrl] parameters:input responseCache:^(id responseCache) {
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
    return _entrustOrgByIdCommand;
}
@end
