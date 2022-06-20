//
//  DelegateHandleTabViewController.h
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/9.
//

#import "xw_BaseViewController.h"
#import "xw_HandleQueryModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DelegateHandleTabViewController : xw_BaseViewController<JXCategoryListContentViewDelegate>
@property (nonatomic, strong) UINavigationController *naviController;
@property (nonatomic, copy) void(^didScrollCallback)(UIScrollView *scrollView);
@property (nonatomic, strong) NSString *queryStatus;

@end

NS_ASSUME_NONNULL_END
