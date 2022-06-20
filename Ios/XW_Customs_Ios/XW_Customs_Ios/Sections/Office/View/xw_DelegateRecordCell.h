//
//  xw_DelegateRecordCell.h
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/8.
//

#import "xw_BaseTableViewCell.h"
#import "xw_EntrustInspectModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface xw_DelegateRecordCell : xw_BaseTableViewCell
@property (nonatomic, strong) xw_EntrustInspectModel *model;
@end

NS_ASSUME_NONNULL_END
