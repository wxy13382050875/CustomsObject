//
//Created by ESJsonFormatForMac on 21/05/19.
//

#import <Foundation/Foundation.h>

@class Adcreativeform;
@interface LaunchAdModel : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *description;

@property (nonatomic, copy) NSString *jumpType;

@property (nonatomic, copy) NSString *adSpace;

@property (nonatomic, strong) Adcreativeform *adCreativeForm;

@property (nonatomic, copy) NSString *wgtUrl;

@property (nonatomic, copy) NSString *wgtAppId;

@property (nonatomic, copy) NSString *jumpTargetPage;

@property (nonatomic, copy) NSString *resourcesUrl;

@property (nonatomic, copy) NSString *adConfig;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *wgtVersion;

@end
@interface Adcreativeform : NSObject

@property (nonatomic, copy) NSString *resourcesType;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *description;

@end

