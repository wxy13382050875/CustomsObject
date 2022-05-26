//
//  xw_ClausePopAlert.h
//  XW_Object
//
//  Created by Benc Mai on 2020/9/10.
//  Copyright © 2020 武新义. All rights reserved.
//

#import "xw_BaseView.h"
#import "xw_ClauseModel.h"

/// 请求失败的Block
typedef void(^didChickEventBlock)(Protocols* model,NSInteger type);

NS_ASSUME_NONNULL_BEGIN

@interface xw_ClausePopAlert : xw_BaseView

-(void)initPotAlert:(xw_ClauseModel*)model clickBlock:(didChickEventBlock) clickBlock;

@end

NS_ASSUME_NONNULL_END
