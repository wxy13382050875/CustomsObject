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
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kRegister];
}
+(NSString*)xw_SendCodeUrl{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kSendCode];
}
+(NSString*)xw_ResetPasswordUrl{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kResetPassword];
}
+(NSString*)xw_GetCivilFaceStatusUrl{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kGetCivilFaceStatus];
}
+(NSString*)xw_GetFaceVerifyTokenUrl{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kGetFaceVerifyToken];
}
+(NSString*)xw_GetVerifyResultUrl{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kGetVerifyResult];
}
+(NSString*)xw_WorkStationUrl{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kGetWorkStation];
}
+(NSString*)xw_WorkStationShowUrl{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kGetWorkStationShow];
}
+(NSString*)xw_GetHome{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kGetHome];
}
+(NSString*)xw_GetHomeV2{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kGetHomeV2];
}
+(NSString*)xw_GetHomeInfo{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kGetHomeInfo];
}
+(NSString*)xw_GetNewsListUrl{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kGetNewsList];
}
+(NSString*)xw_GetArticleShow{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kGetArticleShow];
}
+(NSString*)xw_GetMsgList{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kGetMsgList];
}
+(NSString*)xw_SetMsgRead{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kSetMsgRead];
}
+(NSString*)xw_RefreshUserInfo{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kRefreshUserInfo];
}
+(NSString*)xw_UpdateUserInfo{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kUpdateUserInfo];
}
+(NSString*)xw_LoginOutUrl{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kLoginOut];
}
+(NSString*)xw_ChangePwdUrl{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kChangePwd];
}
+(NSString*)xw_BindDeviceTokenUrl{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kBindDeviceToken];
}
+(NSString*)xw_PostPayOrder{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kPostPayOrder];
}
+(NSString*)xw_GetPayOrderState{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kGetPayOrderState];
}
+(NSString*)xw_GetAccountInfo{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kGetAccountInfo];
}

+(NSString*)xw_GetProtocolGroup{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kGetProtocolGroup];
}

+(NSString*)xw_GetProtocolDetail{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kGetProtocolDetail];
}
+(NSString*)xw_GetProtocolDetailONAuth{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kGetProtocolDetailNoAuth];
}
+(NSString*)xw_ConsentProtocol{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kConsentProtocol];
}
+(NSString*)xw_UserMenuCount{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kUserMenuCount];
}
+(NSString*)xw_GetAmcAccountVip{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kGetAmcAccountVip];
}
+(NSString*)xw_GetRealPersonOrAgentDeclare{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kGetRealPersonOrAgentDeclare];
}
+(NSString*)xw_GetGuideInfo:(NSString*)Location{
    return [NSString stringWithFormat:@"%@%@%@",kApiPrefix,kGetGuideInfo,Location];
}
+(NSString*)xw_PostCompleteGuide{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kPostCompleteGuide];
}
+(NSString*)xw_GetAdShow{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kGetAdShow];
}

+(NSString*)xw_PostLoginOffCode{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kPostLoginOffCode];
}
+(NSString*)xw_PostVerifyLoginOff{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kPostVerifyLoginOff];
}
+(NSString*)xw_PostFaceAuthCode{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kPostFaceAuthCode];
}
+(NSString*)xw_PostVerifyFaceAuth{
    return [NSString stringWithFormat:@"%@%@",kApiPrefix,kPostVerifyFaceAuth];
}
@end
