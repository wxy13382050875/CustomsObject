//
//  SubCenterTabViewController.h
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/15.
//

#import "xw_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SubCenterTabViewController : xw_BaseViewController<JXCategoryListContentViewDelegate>
@property (nonatomic, strong) UINavigationController *naviController;
@property (nonatomic, copy) void(^didScrollCallback)(UIScrollView *scrollView);
@end

NS_ASSUME_NONNULL_END
