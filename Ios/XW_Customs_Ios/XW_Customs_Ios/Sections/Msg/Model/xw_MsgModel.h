//
//  xw_MsgModel.h
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface xw_MsgModel : NSObject
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *targetUserId;
@property (nonatomic, copy) NSString *entrustId;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) BOOL readFlag;
@property (nonatomic, copy) NSString *createTime;
@end

NS_ASSUME_NONNULL_END

