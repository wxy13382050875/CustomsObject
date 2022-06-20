//
//Created by ESJsonFormatForMac on 20/05/07.
//

#import <Foundation/Foundation.h>
#import "xw_canSelectOrgModel.h"


@class RolesModel,MobilepermissiontreeModel,SubTreeModel,xw_canSelectOrgModel;
@interface xw_UserInfoModel : NSObject
@property (nonatomic, copy) NSString *papersNo;
@property (nonatomic, copy) NSString *papersType;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *lastOptUser;
@property (nonatomic, strong) NSArray *webPermissionTree;
@property (nonatomic, strong) NSArray<MobilepermissiontreeModel *> *mobilePermissionTree;
@property (nonatomic, copy) NSString *trueName;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, copy) NSString *alias;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, strong) NSArray<RolesModel *> *roles;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, strong) NSArray<xw_canSelectOrgModel *> *orgs;
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *username;

@end



@interface RolesModel : NSObject

@property (nonatomic, copy) NSString *note;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, copy) NSString *orgId;
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *lastOptUser;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *createTime;

@end

@interface MobilepermissiontreeModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *actions;
@property (nonatomic, copy) NSString *parentId;
@property (nonatomic, copy) NSString *note;
@property (nonatomic, copy) NSString *iosPath;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *wgtUrl;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, strong) NSArray<SubTreeModel *> *children;
@property (nonatomic, copy) NSString *mobileAppId;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *androidPath;
@property (nonatomic, assign) BOOL checked;

@end

@interface SubTreeModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *actions;
@property (nonatomic, copy) NSString *parentId;
@property (nonatomic, copy) NSString *note;
@property (nonatomic, copy) NSString *iosPath;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *wgtUrl;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, strong) NSArray *children;
@property (nonatomic, copy) NSString *mobileAppId;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *androidPath;
@property (nonatomic, assign) BOOL checked;
@property (nonatomic, copy) NSString *localIcon;
@end

