//
//  xw_FaceAuthViewModel.m
//  XW_Object
//
//  Created by Benc Mai on 2020/3/22.
//  Copyright © 2020 武新义. All rights reserved.
//

#import "xw_FaceAuthViewModel.h"

@implementation xw_FaceAuthViewModel
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
-(RACCommand*)getFaceStatusCommand{
    if (!_getFaceStatusCommand) {
        _getFaceStatusCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSMutableDictionary* params = [NSMutableDictionary dictionary];
//                if (self.idCode.length == 18) {
//                    
//                } else {
//                    GGLog(@"身份证号输入不正确");
//                    Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"身份证号输入不正确").wDisappelSecondSet(1).wStart();
//                    [subscriber sendCompleted];
//                    return nil;
//                }
                
                [params setValue:self.idCode forKey:@"idCode"];
                if (self.phone.length == 11) {
                    [params setValue:self.phone forKey:@"phone"];
                } else {
                    GGLog(@"手机号输入不正确");
                    Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"手机号输入不正确").wDisappelSecondSet(1).wStart();
                    [subscriber sendCompleted];
                    return nil;
                }
               
                
                [PPNetworkHelper POST:[xw_HttpRequest xw_GetCivilFaceStatusUrl] parameters:params responseCache:^(id responseCache) {
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
    return _getFaceStatusCommand;
}
-(RACCommand*)getFaceTokenCommand{
    if (!_getFaceTokenCommand) {
        _getFaceTokenCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSMutableDictionary* params = [NSMutableDictionary dictionary];
//                if (self.idCode.length == 18) {
//
//                } else {
//                    GGLog(@"身份证号输入不正确");
//                    Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"身份证号输入不正确").wDisappelSecondSet(1).wStart();
//                    [subscriber sendCompleted];
//                    return nil;
//                }
                [params setValue:self.idCode forKey:@"idCode"];
                self.bizId = [NSString randomStr];
                
                [params setValue:self.bizId forKey:@"bizId"];
                [params setValue:self.bizType forKey:@"bizType"];
                
               
                [PPNetworkHelper GET:[xw_HttpRequest xw_GetFaceVerifyTokenUrl] parameters:params responseCache:^(id responseCache) {
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
    return _getFaceTokenCommand;
}
-(RACCommand*)getVerifyResultCommand{
    if (!_getVerifyResultCommand) {
        _getVerifyResultCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSMutableDictionary* params = [NSMutableDictionary dictionary];
               
                
                [params setValue:self.bizId forKey:@"bizId"];
                [params setValue:self.bizType forKey:@"bizType"];
                
               
                [PPNetworkHelper GET:[xw_HttpRequest xw_GetVerifyResultUrl] parameters:params responseCache:^(id responseCache) {
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
    return _getVerifyResultCommand;
}
@end
