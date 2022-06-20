//
//  xw_MyViewModel.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/9.
//

#import "xw_MyViewModel.h"

@implementation xw_MyViewModel
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
-(RACCommand*)changePwdCommand{
    if (!_changePwdCommand) {
        _changePwdCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSMutableDictionary* params = [NSMutableDictionary dictionary];
                if (self.password.length > 0) {
                    [params setValue:self.password forKey:@"password"];
                } else {
                    GGLog(@"原始密码不能为空");
                    Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"原始密码不能为空").wDisappelSecondSet(1).wStart();
                    self.password = @"";
                    [subscriber sendCompleted];
                    return nil;
                }
                [params setObject:[xw_ConfigHelper sharedInstance].userId forKey:@"id"];
                
                [PPNetworkHelper PUT:[xw_HttpRequest xw_UpdatePasswordUrl] parameters:params responseCache:^(id responseCache) {
                    
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
    return _changePwdCommand;
}
@end
