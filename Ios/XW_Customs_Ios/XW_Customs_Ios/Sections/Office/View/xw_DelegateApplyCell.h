//
//  xw_DelegateApplyCell.h
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/14.
//

#import "xw_BaseTableViewCell.h"
#import "xw_EntrustInspectModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface xw_DelegateApplyCell : xw_BaseTableViewCell
@property(nonatomic,strong)xw_EntrustInspectModel* model;
@property(nonatomic,strong)xw_EntrustInspectModel* detailModel;
@end

NS_ASSUME_NONNULL_END
