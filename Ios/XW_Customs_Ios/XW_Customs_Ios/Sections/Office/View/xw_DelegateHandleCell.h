//
//  xw_DelegateHandleCell.h
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/9.
//

#import "xw_BaseTableViewCell.h"
#import "xw_EntrustInspectModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^refreshHandleBlock)( xw_EntrustInspectModel *model,NSString* type);
@interface xw_DelegateHandleCell : xw_BaseTableViewCell
@property (nonatomic, strong) xw_EntrustInspectModel *model;
@property (nonatomic, copy) refreshHandleBlock refreshBlock;
@end

NS_ASSUME_NONNULL_END
