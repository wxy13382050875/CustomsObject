//
//Created by ESJsonFormatForMac on 20/05/07.
//

#import <Foundation/Foundation.h>

@class Civilinfo,Rolelist;
@interface xw_UserInfoModel : NSObject

@property (nonatomic, assign) BOOL civil;

@property (nonatomic, assign) BOOL realPersonAuth;

@property (nonatomic, copy) NSString *realName;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *idCode;

@property (nonatomic, assign) NSInteger customs;

@property (nonatomic, assign) BOOL isCompleteInfo;

@property (nonatomic, strong) Civilinfo *civilInfo;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, strong) NSArray *roleList;

@property (nonatomic, copy) NSString *idCodeQr;

@property (nonatomic, copy) NSString *token;

@property (nonatomic, assign) NSInteger region;

@property (nonatomic, assign) BOOL placeSubmit;

@property (nonatomic, copy) NSString *validateStatus;

@property (nonatomic, copy) NSString *regionName;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *remark;
@end
@interface Civilinfo : NSObject

@property (nonatomic, copy) NSString *civilName;

@property (nonatomic, copy) NSString *regNo;

@property (nonatomic, copy) NSString *lshg;

@property (nonatomic, copy) NSString *frontierTrader;

@property (nonatomic, copy) NSString *faceStatus;

@end

@interface Rolelist : NSObject

@property (nonatomic, copy) NSString *roleName;

@property (nonatomic, assign) NSInteger roleId;

@property (nonatomic, copy) NSString *roleDesc;

@property (nonatomic, copy) NSString *role;

@property (nonatomic, copy) NSString *statusCd;

@end

