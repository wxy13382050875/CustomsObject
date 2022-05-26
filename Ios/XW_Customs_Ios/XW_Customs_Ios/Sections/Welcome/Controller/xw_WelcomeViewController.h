//
//  XWWelcomeViewController.h
//  PlayFC
//
//  Created by 武新义 on 2019/5/27.
//  Copyright © 2019 Davis. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xw_WelcomeViewController : UIViewController
/** The block about skip button */
@property (nonatomic, copy) void(^skipClickBlock)(void);

@end

NS_ASSUME_NONNULL_END
