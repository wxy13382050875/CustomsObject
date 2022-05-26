//
//  xw_HttpRequest.h
//  XW_Object
//
//  Created by Benc Mai on 2020/3/18.
//  Copyright © 2020 武新义. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface xw_HttpRequest : NSObject

+(NSString*)xw_LoginUrl;

+(NSString*)xw_RegisterUrl;

+(NSString*)xw_SendCodeUrl;

+(NSString*)xw_GetHome;

+(NSString*)xw_GetHomeV2;

+(NSString*)xw_GetHomeInfo;

+(NSString*)xw_ResetPasswordUrl;

+(NSString*)xw_GetCivilFaceStatusUrl;

+(NSString*)xw_GetFaceVerifyTokenUrl;

+(NSString*)xw_GetVerifyResultUrl;

+(NSString*)xw_WorkStationUrl;

+(NSString*)xw_WorkStationShowUrl;

+(NSString*)xw_GetNewsListUrl;

+(NSString*)xw_GetArticleShow;

+(NSString*)xw_GetMsgList;

+(NSString*)xw_SetMsgRead;

+(NSString*)xw_RefreshUserInfo;

+(NSString*)xw_UpdateUserInfo;

+(NSString*)xw_LoginOutUrl;

+(NSString*)xw_ChangePwdUrl;

+(NSString*)xw_BindDeviceTokenUrl;

+(NSString*)xw_PostPayOrder;

+(NSString*)xw_GetPayOrderState;

+(NSString*)xw_GetAccountInfo;

+(NSString*)xw_GetProtocolGroup;

+(NSString*)xw_GetProtocolDetail;

+(NSString*)xw_GetProtocolDetailONAuth;

+(NSString*)xw_ConsentProtocol;

+(NSString*)xw_UserMenuCount;

+(NSString*)xw_GetAmcAccountVip;

+(NSString*)xw_GetRealPersonOrAgentDeclare;

+(NSString*)xw_GetGuideInfo:(NSString*)Location;

+(NSString*)xw_PostCompleteGuide;

+(NSString*)xw_GetAdShow;

+(NSString*)xw_PostLoginOffCode;

+(NSString*)xw_PostVerifyLoginOff;

+(NSString*)xw_PostFaceAuthCode;

+(NSString*)xw_PostVerifyFaceAuth;



@end

NS_ASSUME_NONNULL_END
