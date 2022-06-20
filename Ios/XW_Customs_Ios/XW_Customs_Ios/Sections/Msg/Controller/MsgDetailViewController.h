//
//  xw_MsgDetailViewController.h
//  XW_Object
//
//  Created by Benc Mai on 2020/5/9.
//  Copyright © 2020 武新义. All rights reserved.
//

#import "xw_BaseViewController.h"
#import "xw_MsgModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MsgDetailViewController : xw_BaseViewController
@property(nonatomic,strong)xw_MsgModel* model;
@end

NS_ASSUME_NONNULL_END
