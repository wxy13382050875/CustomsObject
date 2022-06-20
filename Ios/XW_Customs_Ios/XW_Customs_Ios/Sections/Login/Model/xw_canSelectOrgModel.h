//
//  xw_canSelectOrgModel.h
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@class ChildrenModel;
@interface xw_canSelectOrgModel : NSObject
@property (nonatomic, copy) NSString *parentId;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *note;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, assign) BOOL checked;
@property (nonatomic, strong) NSArray<ChildrenModel *> *children;
@property (nonatomic, copy) NSString *name;
@end

NS_ASSUME_NONNULL_END

@interface ChildrenModel : NSObject

@property (nonatomic, copy) NSString *parentId;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *note;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, assign) BOOL checked;
@property (nonatomic, strong) NSArray *children;
@property (nonatomic, copy) NSString *name;

@end

