//
//  xw_FaceAuthViewModel.h
//  XW_Object
//
//  Created by Benc Mai on 2020/3/22.
//  Copyright © 2020 武新义. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface xw_FaceAuthViewModel : NSObject
@property(nonatomic,strong)NSString* idCode;
@property(nonatomic,strong)NSString* phone;
@property (nonatomic,strong)NSString* bizId;
@property (nonatomic,strong)NSString* bizType;

@property (nonatomic,strong) RACCommand * getFaceStatusCommand;

@property (nonatomic,strong) RACCommand * getFaceTokenCommand;
@property (nonatomic,strong) RACCommand * getVerifyResultCommand;
@end

NS_ASSUME_NONNULL_END
