//
//  xw_DictModel.h
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/6.
//

#import <Foundation/Foundation.h>



@class ItemsModel;
@interface xw_DictModel : NSObject
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, strong) NSArray<ItemsModel *> *items;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *note;

@end

@interface ItemsModel : NSObject

@property (nonatomic, copy) NSString *dictId;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *note;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *attrValue;
@property (nonatomic, copy) NSString *name;

@end
