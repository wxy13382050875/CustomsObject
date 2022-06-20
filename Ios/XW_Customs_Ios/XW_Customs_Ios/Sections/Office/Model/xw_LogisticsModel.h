//
//  xw_LogisticsModel.h
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@class ResultModel,ListModel;
@interface xw_LogisticsModel : NSObject
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) ResultModel *result;
@end

NS_ASSUME_NONNULL_END
NS_ASSUME_NONNULL_BEGIN
@interface ResultModel : NSObject

@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *typename;
@property (nonatomic, assign) NSInteger deliverystatus;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, copy) NSString *issign;
@property (nonatomic, copy) NSString *courierPhone;
@property (nonatomic, strong) NSArray<NSString *> *citys;
@property (nonatomic, copy) NSString *courier;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSArray<ListModel *> *list;
@property (nonatomic, copy) NSString *logo;

@end
NS_ASSUME_NONNULL_END
NS_ASSUME_NONNULL_BEGIN
@interface ListModel : NSObject

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, strong) NSArray<NSString *> *cityLoeLae;

@end
NS_ASSUME_NONNULL_END
