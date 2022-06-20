//
//  xw_MyViewModel.h
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/9.
//

#import "xw_BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface xw_MyViewModel : xw_BaseViewModel
@property(nonatomic,strong)NSString* password;
@property (nonatomic,strong) RACCommand * changePwdCommand;
@end

NS_ASSUME_NONNULL_END
