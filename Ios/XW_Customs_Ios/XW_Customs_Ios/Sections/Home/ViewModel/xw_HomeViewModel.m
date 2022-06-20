//
//  xw_HomeViewModel.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/16.
//

#import "xw_HomeViewModel.h"

@implementation xw_HomeViewModel
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
-(RACCommand*)getOrgDetailByIdCommand{
    if (!_getOrgDetailByIdCommand) {
        _getOrgDetailByIdCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {



                [PPNetworkHelper GET:[xw_HttpRequest xw_GetOrgDetailByIdUrl] parameters:input responseCache:^(id responseCache) {
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
    return _getOrgDetailByIdCommand;
}
@end
