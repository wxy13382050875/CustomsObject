//
//  xw_LogisticsCell.h
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/8.
//

#import "xw_BaseTableViewCell.h"
#import "xw_LogisticsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface xw_LogisticsCell : xw_BaseTableViewCell
@property (nonatomic, strong) xw_LogisticsModel *model;
@property (nonatomic,assign)NSInteger row;
@end

NS_ASSUME_NONNULL_END
