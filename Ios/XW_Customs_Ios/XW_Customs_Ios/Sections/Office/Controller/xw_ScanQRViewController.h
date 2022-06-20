//
//  xw_ScanQRViewController.h
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/15.
//

#import "xw_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^ScanDataBlack)( NSString *qrCode);
@interface xw_ScanQRViewController : xw_BaseViewController
@property (nonatomic, copy) ScanDataBlack scanDataBlock;
@end

NS_ASSUME_NONNULL_END
