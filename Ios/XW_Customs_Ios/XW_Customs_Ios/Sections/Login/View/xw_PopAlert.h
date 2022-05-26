//
//  xw_PopAlert.h
//  XW_Object
//
//  Created by Benc Mai on 2021/2/1.
//  Copyright © 2021 武新义. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "xw_BaseView.h"
#import "xw_PopAlertModel.h"
NS_ASSUME_NONNULL_BEGIN
/// 请求失败的Block

typedef void(^didChickBlock)(xw_PopAlertModel* model);
@interface xw_PopAlert : xw_BaseView

-(void)initPopAlert:(xw_PopAlertModel*)model clickBlock:(didChickBlock) clickBlock;
@end

NS_ASSUME_NONNULL_END
