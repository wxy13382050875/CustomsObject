//
//  LaunchAdViewModel.m
//  XW_Object
//
//  Created by wuxinyi on 2021/5/19.
//  Copyright © 2021 武新义. All rights reserved.
//

#import "LaunchAdViewModel.h"

@implementation LaunchAdViewModel
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
                
               
                
//                [PPNetworkHelper GET:[xw_HttpRequest xw_GetAdShow]  parameters:input success:^(id responseObject) {
//                
//                          if ([responseObject[@"code"] intValue] == 200) {
//                              [subscriber sendNext:responseObject];
//                          }
//                          
//                          [subscriber sendCompleted];
//                      } failure:^(NSError *error) {
//                          [subscriber sendError:error];
//                          [subscriber sendCompleted];
//                      }];
                return nil;
            }];
        }];
    }
    return _requestCommand;
}
@end
