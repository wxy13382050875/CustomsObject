//
//  xw_ResultsDetailCell.h
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/15.
//

#import "xw_BaseTableViewCell.h"
#import "xw_EntrustInspectModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^scanQrBlock)();
@interface xw_ResultsDetailCell : xw_BaseTableViewCell
@property(nonatomic,strong)xw_EntrustInspectModel* model;
@property (nonatomic, copy) scanQrBlock scanDataBlock;
@end

NS_ASSUME_NONNULL_END
