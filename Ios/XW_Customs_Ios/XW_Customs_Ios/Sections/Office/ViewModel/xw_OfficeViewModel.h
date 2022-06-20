//
//  xw_OfficeViewModel.h
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/7.
//

#import "xw_BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface xw_OfficeViewModel : xw_BaseViewModel
@property (nonatomic,strong) RACCommand * getInspectCommand;
@property (nonatomic,strong) RACCommand * expressCommand;
@property (nonatomic,strong) RACCommand * acceptStatiCommand;
@property (nonatomic,strong) RACCommand * entrustStatiCommand;
@property (nonatomic,strong) RACCommand * putEntrustOrgCommand;
@property (nonatomic,strong) RACCommand * postEntrustOrgCommand;

@property (nonatomic,strong) RACCommand * postApplyCommand;
@property (nonatomic,strong) RACCommand * postCacheCommand;
@property (nonatomic,strong) RACCommand * getOneCacheCommand;

@property (nonatomic,strong) RACCommand * getQrCodeCommand;

@property (nonatomic,strong) RACCommand * getCertByQrCodeCommand;

@property (nonatomic,strong) RACCommand * postEntrustInspectCommand;

@property (nonatomic,strong) RACCommand * putEntrustInspectCommand;

@property (nonatomic,strong) RACCommand * getVerifyExpressSnCommand;

@end

NS_ASSUME_NONNULL_END
