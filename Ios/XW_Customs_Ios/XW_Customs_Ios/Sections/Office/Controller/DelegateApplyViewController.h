//
//  DelegateApplyViewController.h
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/2.
//

#import "xw_BaseViewController.h"
#import "xw_EntrustInspectModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DelegateApplyViewController : xw_BaseViewController
@property(nonatomic,strong)xw_EntrustInspectModel* model;
@property(nonatomic,strong)NSString* type;
@end

NS_ASSUME_NONNULL_END
