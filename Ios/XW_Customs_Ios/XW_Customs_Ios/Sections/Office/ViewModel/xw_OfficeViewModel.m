//
//  xw_OfficeViewModel.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/7.
//

#import "xw_OfficeViewModel.h"

@implementation xw_OfficeViewModel
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
-(RACCommand*)getInspectCommand{
    if (!_getInspectCommand) {
        _getInspectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {



                [PPNetworkHelper GET:[xw_HttpRequest xw_GetEntrustInspectUrl] parameters:input responseCache:^(id responseCache) {
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
    return _getInspectCommand;
}
-(RACCommand*)expressCommand{
    if (!_expressCommand) {
        _expressCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {


                [PPNetworkHelper GET:[xw_HttpRequest xw_GetExpressDetailUrl:input] parameters:@{} responseCache:^(id responseCache) {
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
    return _expressCommand;
}
//
-(RACCommand*)acceptStatiCommand{
    if (!_acceptStatiCommand) {
        _acceptStatiCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {


                [PPNetworkHelper GET:[xw_HttpRequest xw_GetAcceptStatiByOrgIdUrl] parameters:input success:^(id responseObject) {
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
    return _acceptStatiCommand;
}
-(RACCommand*)entrustStatiCommand{
    if (!_entrustStatiCommand) {
        _entrustStatiCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {


                [PPNetworkHelper GET:[xw_HttpRequest xw_GetEntrustStatiByEntIdUrl] parameters:input success:^(id responseObject) {
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
    return _entrustStatiCommand;
}
-(RACCommand*)putEntrustOrgCommand{
    if (!_putEntrustOrgCommand) {
        _putEntrustOrgCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {


                [PPNetworkHelper PUT:[xw_HttpRequest xw_PutEntrustOrgUrl:input[@"id"]] parameters:input success:^(id responseObject) {
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
    return _putEntrustOrgCommand;
}
-(RACCommand*)postEntrustOrgCommand{
    if (!_postEntrustOrgCommand) {
        _postEntrustOrgCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {


                [PPNetworkHelper POST:[xw_HttpRequest xw_PostEntrustOrgUrl] parameters:input success:^(id responseObject) {
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
    return _postEntrustOrgCommand;
}
-(RACCommand*)postApplyCommand{
    if (!_postApplyCommand) {
        _postApplyCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {


                [PPNetworkHelper POST:[xw_HttpRequest xw_PostApplyEntrustInspectUrl] parameters:input success:^(id responseObject) {
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
    return _postApplyCommand;
}
-(RACCommand*)postCacheCommand{
    if (!_postCacheCommand) {
        _postCacheCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {


                [PPNetworkHelper POST:[xw_HttpRequest xw_PostCacheUrl] parameters:input success:^(id responseObject) {
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
    return _postCacheCommand;
}
-(RACCommand*)getOneCacheCommand{
    if (!_getOneCacheCommand) {
        _getOneCacheCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {


                [PPNetworkHelper GET:[xw_HttpRequest xw_GetOneCacheUrl] parameters:input success:^(id responseObject) {
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
    return _getOneCacheCommand;
}
-(RACCommand*)getQrCodeCommand{
    if (!_getQrCodeCommand) {
        _getQrCodeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {


                [PPNetworkHelper GET:[xw_HttpRequest xw_GetQrCodeUrl:input] parameters:@{} success:^(id responseObject) {
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
    return _getQrCodeCommand;
}
-(RACCommand*)getCertByQrCodeCommand{
    if (!_getCertByQrCodeCommand) {
        _getCertByQrCodeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {


                [PPNetworkHelper GET:[xw_HttpRequest xw_GetCertByQrCodeUrl] parameters:input success:^(id responseObject) {
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
    return _getCertByQrCodeCommand;
}
-(RACCommand*)postEntrustInspectCommand{
    if (!_postEntrustInspectCommand) {
        _postEntrustInspectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {


                [PPNetworkHelper POST:[xw_HttpRequest xw_PostEntrustInspectUrl:input[@"id"] type:input[@"subType"]] parameters:input success:^(id responseObject) {
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
    return _postEntrustInspectCommand;
}
-(RACCommand*)getVerifyExpressSnCommand{
    if (!_getVerifyExpressSnCommand) {
        _getVerifyExpressSnCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {


                [PPNetworkHelper GET:[xw_HttpRequest xw_GetVerifyExpressSnUrl] parameters:input success:^(id responseObject) {
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
    return _getVerifyExpressSnCommand;
}
-(RACCommand*)putEntrustInspectCommand{
    if (!_putEntrustInspectCommand) {
        _putEntrustInspectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {


                [PPNetworkHelper PUT:[xw_HttpRequest xw_PutEntrustInspectUrl:input[@"id"]] parameters:input success:^(id responseObject) {
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
    return _putEntrustInspectCommand;
}

@end
