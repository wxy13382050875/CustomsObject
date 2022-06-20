//
//  xw_WebViewModel.m
//  XW_Object
//
//  Created by Benc Mai on 2020/4/28.
//  Copyright © 2020 武新义. All rights reserved.
//

#import "xw_WebViewModel.h"

@implementation xw_WebViewModel
- (instancetype)init
{
    if(self = [super init])
    {
    }
    return self;
}
-(void)xw_initialize
{
    
}
-(RACCommand*)requestCommand{
    if (!_requestCommand) {
        _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSDictionary* param = @{
                    @"id":self.contentId,
                    @"type":self.type
                };

//                [PPNetworkHelper GET:[xw_HttpRequest xw_GetArticleShow] parameters:param responseCache:^(id responseCache) {
////                    self.model = [xw_DataStatisticsModel mj_objectWithKeyValues:dict];
////                    [subscriber sendNext:responseCache];
//                } success:^(id responseObject) {
//
////                    self.model = [xw_DataStatisticsModel mj_objectWithKeyValues:dict];
//
//                    [subscriber sendNext:responseObject];
//                    [subscriber sendCompleted];
//
//                } failure:^(NSError *error) {
//                    [subscriber sendError:error];
//                    [subscriber sendCompleted];
//                }];
                return nil;
            }];
        }];
    }
    return _requestCommand;
}
-(RACCommand*)requestProtocolsCommand{
    if (!_requestProtocolsCommand) {
        _requestProtocolsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSDictionary* param = @{
                    @"id":self.contentId,
                };

//                [PPNetworkHelper GET:[xw_HttpRequest xw_GetProtocolDetail] parameters:param responseCache:^(id responseCache) {
////                    self.model = [xw_DataStatisticsModel mj_objectWithKeyValues:dict];
////                    [subscriber sendNext:responseCache];
//                } success:^(id responseObject) {
//
////                    self.model = [xw_DataStatisticsModel mj_objectWithKeyValues:dict];
//
//                    [subscriber sendNext:responseObject];
//                    [subscriber sendCompleted];
//
//                } failure:^(NSError *error) {
//                    [subscriber sendError:error];
//                    [subscriber sendCompleted];
//                }];
                return nil;
            }];
        }];
    }
    return _requestProtocolsCommand;
}
-(RACCommand*)requestProtocolsCommandNoAuth{
    if (!_requestProtocolsCommandNoAuth) {
        _requestProtocolsCommandNoAuth = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSDictionary* param = @{
                    @"id":self.contentId,
                };

//                [PPNetworkHelper GET:[xw_HttpRequest xw_GetProtocolDetailONAuth] parameters:param responseCache:^(id responseCache) {
////                    self.model = [xw_DataStatisticsModel mj_objectWithKeyValues:dict];
////                    [subscriber sendNext:responseCache];
//                } success:^(id responseObject) {
//
////                    self.model = [xw_DataStatisticsModel mj_objectWithKeyValues:dict];
//
//                    [subscriber sendNext:responseObject];
//                    [subscriber sendCompleted];
//
//                } failure:^(NSError *error) {
//                    [subscriber sendError:error];
//                    [subscriber sendCompleted];
//                }];
                return nil;
            }];
        }];
    }
    return _requestProtocolsCommandNoAuth;
}
@end
