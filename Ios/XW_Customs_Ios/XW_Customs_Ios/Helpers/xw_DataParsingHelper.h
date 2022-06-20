//
//  xw_DataParsingHelper.h
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/10.
//

#import <Foundation/Foundation.h>
#import "xw_canSelectOrgModel.h"
#import "xw_DictModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface xw_DataParsingHelper : NSObject
/**
     * 获取字典
*/
+(NSArray*) getDictItemByCode:(NSString*)code;
/**
     *  获取字典Pack显示数据
     */
+(NSArray*) getDictPickList:(NSString*)code;
/**
     * 根据CODE和子CODE获取字典中所选字符串
     */
+(NSString*)GetDictNameBySubCode:(NSString*)code subCode:(NSString*)subCode;

/**
     * 获取海关技术中心列表
     */
+(NSArray*) getOrgsSingleList;

/**
     * 获取海关技术中心 Pack显示数据
     */
+(NSArray*) getOrgsSinglePickList;

/**
     * 根据机构ID获取机构名称
     */
+(NSString*) getSingleOrgsNameById:(NSString*)OrgId;
@end

NS_ASSUME_NONNULL_END
