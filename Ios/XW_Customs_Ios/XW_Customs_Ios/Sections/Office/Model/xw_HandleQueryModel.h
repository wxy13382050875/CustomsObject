//
//  xw_HandleQueryModel.h
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface xw_HandleQueryModel : NSObject
@property (nonatomic, copy) NSString *entrustOrgId;
@property (nonatomic, copy) NSString *inspectOrgId;
@property (nonatomic, copy) NSString *inspectOrgName;
@property (nonatomic, copy) NSString *statusName;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *queryInspectStatus;
@property (nonatomic, copy) NSString *sampleName;
@property (nonatomic, copy) NSString *page;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy) NSString *entrustOrgName;
@property (nonatomic, copy) NSString *acceptUserName;
@property (nonatomic, copy) NSString * inspectResult;
@property (nonatomic, copy) NSString * inspectResultName;
@property (nonatomic, copy) NSString *sn;
@property (nonatomic, copy) NSString *from;
@property (nonatomic, copy) NSString *to;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *acceptTimeFrom;
@property (nonatomic, copy) NSString *acceptTimeTo;
@property (nonatomic, copy) NSString *acceptTime;
@property (nonatomic, copy) NSString *samplingTimeFrom;
@property (nonatomic, copy) NSString *samplingTimeTo;
@property (nonatomic, copy) NSString *samplingTime;

@end

NS_ASSUME_NONNULL_END
