//
//  xw_HomeViewModel.h
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/16.
//

#import "xw_BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface xw_HomeViewModel : xw_BaseViewModel
@property (nonatomic,strong) RACCommand * getOrgDetailByIdCommand;
@end

NS_ASSUME_NONNULL_END
