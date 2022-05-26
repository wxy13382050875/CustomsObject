//
//Created by ESJsonFormatForMac on 20/09/11.
//

#import <Foundation/Foundation.h>

@class Protocols;
@interface xw_ClauseModel : NSObject

@property (nonatomic, assign) BOOL consent;

@property (nonatomic, copy) NSString *groupKey;

@property (nonatomic, copy) NSString *id;;

@property (nonatomic, strong) NSArray *protocols;

@property (nonatomic, copy) NSString *createDate;

@property (nonatomic, copy) NSString *outline;

@property (nonatomic, copy) NSString *name;

@end
@interface Protocols : NSObject

@property (nonatomic, copy) NSString *createDate;

@property (nonatomic, copy) NSString *id;;

@property (nonatomic, copy) NSString *name;

@end

