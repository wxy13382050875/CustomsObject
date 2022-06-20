//
//  xw_EntrustInspectModel.h
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/7.
//

#import <Foundation/Foundation.h>
#import "xw_EntrustModel.h"
NS_ASSUME_NONNULL_BEGIN


@class xw_EntrustModel;
@interface xw_EntrustInspectModel : NSObject
@property (nonatomic, copy) NSString *registerUserPhone;
@property (nonatomic, strong) xw_EntrustModel *entrustOrg;
@property (nonatomic, copy) NSString *entrustOrgName;
@property (nonatomic, copy) NSString *samplingTime;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *registerTime;
@property (nonatomic, copy) NSString *sampleWeight;
@property (nonatomic, copy) NSString *registerUserId;
@property (nonatomic, copy) NSString *expressNo;
@property (nonatomic, copy) NSString *acceptTime;
@property (nonatomic, copy) NSString *samplingUserId;
@property (nonatomic, copy) NSString *producer;
@property (nonatomic, copy) NSString *inspectStatus;
@property (nonatomic, copy) NSString *acceptUserName;
@property (nonatomic, copy) NSString *samplingUserPhone;
@property (nonatomic, copy) NSString *producerAddress;
@property (nonatomic, copy) NSString *sampleMark;
@property (nonatomic, copy) NSString *acceptUserPhone;
@property (nonatomic, copy) NSString *sampleQuantity;
@property (nonatomic, copy) NSString *sampleWay;
@property (nonatomic, copy) NSString *takeWay;
@property (nonatomic, copy) NSString *sampleNum;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *acceptUserId;
@property (nonatomic, copy) NSString *samplingUserName;
@property (nonatomic, copy) NSString *excStandard;
@property (nonatomic, copy) NSString *project;
@property (nonatomic, copy) NSString *busCategory;
@property (nonatomic, copy) NSString *registerUserName;
@property (nonatomic, copy) NSString *projectBasis;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *sampleName;
@property (nonatomic, strong) NSString *entrustOrgId;
@property (nonatomic, copy) NSString *sn;
@property (nonatomic, copy) NSString *inspectOrgId;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *productionDate;
@property (nonatomic, copy) NSString *samplingNote;
@property (nonatomic, copy) NSString *spec;
@property (nonatomic, copy) NSString *inspectResult;
//自定义数据
//用于区分WAIT_ACCEPT ACCEPTED WAIT_SAMPLE SAMPLED WAIT_REGISTER REGISTERED
@property (nonatomic, copy) NSString *queryStatus;
//用于展开/折叠状态
@property (nonatomic, assign) BOOL isFold;
//与isFold配合处理哪一条数据显示
@property (nonatomic, assign) NSIndexPath * indexPath;
@end

NS_ASSUME_NONNULL_END

