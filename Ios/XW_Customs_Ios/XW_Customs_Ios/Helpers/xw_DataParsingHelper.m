//
//  xw_DataParsingHelper.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/10.
//

#import "xw_DataParsingHelper.h"

@implementation xw_DataParsingHelper
/**
     * 获取字典
*/
+(NSArray*) getDictItemByCode:(NSString*)code{
    NSArray* array = [xw_DictModel mj_objectArrayWithKeyValuesArray:[xw_ConfigHelper sharedInstance].dict.mj_JSONObject[@"data"]];
    
    NSArray* currentItems = @[];
    for (int i = 0; i < array.count; i ++) {
        xw_DictModel* tm = array[i];
        if([tm.code isEqualToString:code]){
            currentItems = tm.items;
            break;
        }
    }
    return currentItems;
}

+(NSArray*) getDictPickList:(NSString*)code{
    NSArray *array = [self getDictItemByCode:code];
    NSMutableArray* picks = [NSMutableArray array];
    for (int i = 0; i < array.count; i ++ ) {
        NSMutableDictionary* dict = [NSMutableDictionary dictionary];
        xw_DictModel* tm = array[i];
        [dict setObject:tm.name forKey:@"name"];
        [dict setObject:tm forKey:@"item"];
        [picks addObject:dict];
    }
    return picks;
}
/**
     * 根据CODE和子CODE获取字典中所选字符串
     */
+(NSString*)GetDictNameBySubCode:(NSString*)code subCode:(NSString*)subCode{
    NSArray* array = [self getDictItemByCode:code];
    NSString* name = @"";
    for (int i = 0; i < array.count; i ++) {
        ItemsModel* tm = array[i];
        if([tm.code isEqualToString:subCode]){
            name = tm.name;
            return name;
        }
    }
    return name;
}


/**
     * 获取海关技术中心列表
     */
+(NSArray*) getOrgsSingleList{
    NSArray* array = [xw_canSelectOrgModel mj_objectArrayWithKeyValuesArray:[xw_ConfigHelper sharedInstance].Orgs.mj_JSONObject[@"data"]];
    NSMutableArray* singles = [NSMutableArray array];
    for (int i = 0; i < array.count; i++) {
        xw_canSelectOrgModel* tm = array[i];
        
        ChildrenModel* model = [ChildrenModel new];
        model.name = tm.name;
        model.id = tm.id;
        model.code = tm.code;
        [singles addObject:model];
        if(tm.children.count > 0){
            
            for (int j = 0; j < tm.children.count; j++) {
                ChildrenModel* subModel = tm.children[j];
                [singles addObject:subModel];
                if(subModel.children.count > 0){
                    
                    for (int k = 0; k < tm.children.count; k++) {
                        ChildrenModel* subsubModel = tm.children[k];
                        [singles addObject:subsubModel];
                        
                    }
                }
            }
        }
        
    }
    return singles;
}
+(NSArray*) getOrgsSinglePickList{
    NSArray *array = [self getOrgsSingleList];
    NSMutableArray* picks = [NSMutableArray array];
    for (int i = 0; i < array.count; i ++ ) {
        NSMutableDictionary* dict = [NSMutableDictionary dictionary];
        ChildrenModel* tm = array[i];
        [dict setObject:tm.name forKey:@"name"];
        [dict setObject:tm forKey:@"item"];
        [picks addObject:dict];
    }
    return picks;
}
/**
     * 根据机构ID获取机构名称
     */
+(NSString*) getSingleOrgsNameById:(NSString*)OrgId{
    NSString* orgName = @"";
    NSArray *array = [self getOrgsSingleList];
    
    for (int i = 0; i < array.count; i ++ ) {
        ChildrenModel* tm = array[i];
        if([tm.id isEqualToString:OrgId]){
            orgName = tm.name;
            return orgName;
        }
    }
    return orgName;
}

@end
