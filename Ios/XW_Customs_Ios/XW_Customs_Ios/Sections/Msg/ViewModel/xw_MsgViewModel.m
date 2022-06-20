//
//  xw_MsgViewModel.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/6.
//

#import "xw_MsgViewModel.h"

@implementation xw_MsgViewModel
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
    
}
-(RACCommand*)msgGroupCommand{
    if (!_msgGroupCommand) {
        _msgGroupCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                
                
                [PPNetworkHelper GET:[xw_HttpRequest xw_GetMsgGroupUrl] parameters:input responseCache:^(id responseCache) {
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
    return _msgGroupCommand;
}
-(RACCommand*)msgListCommand{
    if (!_msgListCommand) {
        _msgListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                
//                [params setValue:self.openid forKey:@"openid"];
                [PPNetworkHelper GET:[xw_HttpRequest xw_GetMsgListUrl] parameters:input responseCache:^(id responseCache) {
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
    return _msgListCommand;
}

-(RACCommand*)msgClickCommand{
    if (!_msgClickCommand) {
        _msgClickCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                
                [PPNetworkHelper POST:[xw_HttpRequest xw_PostMsgDetailClickUrl:input] parameters:@{} success:^(id responseObject) {
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
    return _msgClickCommand;
}


@end
