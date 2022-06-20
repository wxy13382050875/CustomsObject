//
//  xw_ScreenViewController.h
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/10.
//

#import "xw_BaseViewController.h"
#import "xw_HandleQueryModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^refreshHandleBlock)( xw_HandleQueryModel *model);
@interface xw_ScreenViewController : xw_BaseViewController
@property(nonatomic,strong)NSString* handleType;
@property (nonatomic, copy) refreshHandleBlock refreshBlock;
@property (nonatomic, strong) xw_HandleQueryModel *model;
@end

NS_ASSUME_NONNULL_END
