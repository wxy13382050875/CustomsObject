//
//  xw_WebViewModel.h
//  XW_Object
//
//  Created by Benc Mai on 2020/4/28.
//  Copyright © 2020 武新义. All rights reserved.
//

#import "xw_BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface xw_WebViewModel : xw_BaseViewModel
@property(nonatomic,strong)NSString* contentId;
@property(nonatomic,strong)NSString* type;
@property (nonatomic,strong) RACCommand * requestCommand;
@property (nonatomic,strong) RACCommand * requestProtocolsCommand;
@property (nonatomic,strong) RACCommand * requestProtocolsCommandNoAuth;

@end

NS_ASSUME_NONNULL_END
