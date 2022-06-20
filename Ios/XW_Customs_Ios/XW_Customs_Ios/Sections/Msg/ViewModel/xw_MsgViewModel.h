//
//  xw_MsgViewModel.h
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/6.
//

#import "xw_BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface xw_MsgViewModel : xw_BaseViewModel
@property (nonatomic,strong) RACCommand * msgGroupCommand;
@property (nonatomic,strong) RACCommand * msgListCommand;
@property (nonatomic,strong) RACCommand * msgClickCommand;
@end

NS_ASSUME_NONNULL_END
