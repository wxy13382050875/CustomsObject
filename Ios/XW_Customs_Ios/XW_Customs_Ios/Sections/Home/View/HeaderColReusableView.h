//
//  HeaderColReusableView.h
//  XW_Customs_Ios
//
//  Created by wuxinyi on 2022/5/7.
//

#import "xw_BaseCollectionReusableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeaderColReusableView : xw_BaseCollectionReusableView
@property (nonatomic, copy) void(^didChickEventBlock)(id params);
@end

NS_ASSUME_NONNULL_END
