//
//  xw_DictModel.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/6.
//

#import "xw_DictModel.h"


@implementation xw_DictModel

//+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
//    return @{@"roleList" : [Rolelist class]};
//}
+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"items" : @"ItemsModel"
             };
}

@end

@implementation ItemsModel

@end
