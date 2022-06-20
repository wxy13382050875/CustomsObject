//
//  xw_LogisticsModel.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/8.
//

#import "xw_LogisticsModel.h"

@implementation xw_LogisticsModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"result" : @"ResultModel"
             };
}
@end
@implementation ResultModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"list" : @"ListModel"
             };
}

@end
@implementation ListModel

@end
