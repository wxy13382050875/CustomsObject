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

+(NSString*)xw_UpdatePasswordUrl;

+(NSString*)xw_GetCurrentUserInfoUrl;

+(NSString*)xw_GetAllDictUrl;

+(NSString*)xw_GetEntrustInspectUrl;

+(NSString*)xw_PutEntrustInspectUrl:(NSString*) id;

+(NSString*)xw_PostApplyEntrustInspectUrl;

+(NSString*)xw_PostEntrustInspectUrl:(NSString*) id type:(NSString*) type;

+(NSString*)xw_GetCanSelectOrgsUrl:(NSString*) id;



+(NSString*)xw_GetVerifyExpressSnUrl;

+(NSString*)xw_GetEntrustOrgUrl:(NSString*) id;

+(NSString*)xw_PutEntrustOrgUrl:(NSString*) id;

+(NSString*)xw_PostEntrustOrgUrl;

+(NSString*)xw_getEntrustOrgByUserIdUrl;

+(NSString*)xw_GetExpressDetailUrl:(NSString*) id;

+(NSString*)xw_GetOneCacheUrl;

+(NSString*)xw_PostCacheUrl;

+(NSString*)xw_GetCertByQrCodeUrl;

+(NSString*)xw_GetQrCodeUrl:(NSString*) id;

+(NSString*)xw_GetMsgGroupUrl;

+(NSString*)xw_GetMsgListUrl;

+(NSString*)xw_PostMsgDetailClickUrl:(NSString*) id;

+(NSString*)xw_GetOrgDetailByIdUrl;

+(NSString*)xw_GetAcceptStatiByOrgIdUrl;

+(NSString*)xw_GetEntrustStatiByEntIdUrl;

@end

NS_ASSUME_NONNULL_END
