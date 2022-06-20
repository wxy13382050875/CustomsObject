//
//Created by ESJsonFormatForMac on 20/05/07.
//

#import "xw_UserInfoModel.h"
@implementation xw_UserInfoModel

//+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
//    return @{@"roleList" : [Rolelist class]};
//}
+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"mobilePermissionTree" : @"MobilepermissiontreeModel",
             @"roles" : @"RolesModel",
             @"orgs" : @"xw_canSelectOrgModel"
             };
}

@end


@implementation RolesModel

@end

@implementation MobilepermissiontreeModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"children" : @"SubTreeModel"
             };
}


@end

@implementation SubTreeModel

@end
