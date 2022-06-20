//
//  xw_HttpRequest.m
//  XW_Object
//
//  Created by Benc Mai on 2020/3/18.
//  Copyright © 2020 武新义. All rights reserved.
//

#import "xw_HttpRequest.h"
#import "xw_InterfacedConst.h"
@implementation xw_HttpRequest


+(NSString*)xw_LoginUrl{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kLogin];
}


+(NSString*)xw_RegisterUrl{
    return [NSString stringWithFormat:@"%@%@/register",kApiPrefix,kUser];
}


+(NSString*)xw_UpdatePasswordUrl{
    return [NSString stringWithFormat:@"%@%@/updatePassword",kApiPrefix,kUser];
}


+(NSString*)xw_GetCurrentUserInfoUrl{
    return [NSString stringWithFormat:@"%@%@/current",kApiPrefix,kUser];
}


+(NSString*)xw_GetAllDictUrl{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kGetAllDict];
}


+(NSString*)xw_GetEntrustInspectUrl{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kEntrustInspect];
}


+(NSString*)xw_PutEntrustInspectUrl:(NSString*) id{
    return [NSString stringWithFormat:@"%@%@/%@",kApiPrefix,kEntrustInspect,id];
}


+(NSString*)xw_PostApplyEntrustInspectUrl{
    return [NSString stringWithFormat:@"%@%@/submit",kApiPrefix,kEntrustInspect];
}


+(NSString*)xw_PostEntrustInspectUrl:(NSString*) id type:(NSString*) type{
    return [NSString stringWithFormat:@"%@%@/%@/handle/%@",kApiPrefix,kEntrustInspect,id,type];
}


+(NSString*)xw_GetCanSelectOrgsUrl:(NSString*) id{
    return [NSString stringWithFormat:@"%@%@/%@/canSelectOrgs",kApiPrefix,kUser,id];
}




+(NSString*)xw_GetVerifyExpressSnUrl{
    return [NSString stringWithFormat:@"%@%@/verifyExpressSn",kApiPrefix,kEntrustInspect];
}


+(NSString*)xw_GetEntrustOrgUrl:(NSString*) id{
    return [NSString stringWithFormat:@"%@%@/%@",kApiPrefix,kEntrustInspect,id];
}


+(NSString*)xw_PutEntrustOrgUrl:(NSString*) id{
    return [NSString stringWithFormat:@"%@%@/%@",kApiPrefix,kEntrustOrg,id];
}


+(NSString*)xw_PostEntrustOrgUrl{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kEntrustOrg];
}
+(NSString*)xw_getEntrustOrgByUserIdUrl{
    return [NSString stringWithFormat:@"%@%@/getByUserId",kApiPrefix,kEntrustOrg];
}
+(NSString*)xw_GetExpressDetailUrl:(NSString*) id{
    return [NSString stringWithFormat:@"%@%@/%@/express",kApiPrefix,kEntrustInspect,id];
}


+(NSString*)xw_GetOneCacheUrl{
    return [NSString stringWithFormat:@"%@%@/getOneCache",kApiPrefix,kEntrustInspect];
}


+(NSString*)xw_PostCacheUrl{
    return [NSString stringWithFormat:@"%@%@/cache",kApiPrefix,kEntrustInspect];
}


+(NSString*)xw_GetCertByQrCodeUrl{
    return [NSString stringWithFormat:@"%@%@/cert",kApiPrefix,kEntrustInspect];
}


+(NSString*)xw_GetQrCodeUrl:(NSString*) id{
    return [NSString stringWithFormat:@"%@%@/%@/qrCode",kApiPrefix,kEntrustInspect,id];
}


+(NSString*)xw_GetMsgGroupUrl{
    return [NSString stringWithFormat:@"%@%@/statGroupByType",kApiPrefix,kMessage];
}


+(NSString*)xw_GetMsgListUrl{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kMessage];
}


+(NSString*)xw_PostMsgDetailClickUrl:(NSString*) id{
    return [NSString stringWithFormat:@"%@%@/%@/click",kApiPrefix,kMessage,id];
}


+(NSString*)xw_GetOrgDetailByIdUrl{
    return [NSString stringWithFormat:@"%@%@/getByOrgId",kApiPrefix,kInspectOrg];
}


+(NSString*)xw_GetAcceptStatiByOrgIdUrl{
    return [NSString stringWithFormat:@"%@%@/groupByInspectOrg",kApiPrefix,kEntrustInspectStat];
}


+(NSString*)xw_GetEntrustStatiByEntIdUrl{
    return [NSString stringWithFormat:@"%@%@/groupByEntrustOrg",kApiPrefix,kEntrustInspectStat];
}




@end
