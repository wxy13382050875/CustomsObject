//
//  LaunchAdViewModel.h
//  XW_Object
//
//  Created by wuxinyi on 2021/5/19.
//  Copyright © 2021 武新义. All rights reserved.
//


#import "xw_BaseViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LaunchAdViewModel : xw_BaseViewModel
@property (nonatomic,strong) RACCommand * requestCommand;
@end

NS_ASSUME_NONNULL_END
