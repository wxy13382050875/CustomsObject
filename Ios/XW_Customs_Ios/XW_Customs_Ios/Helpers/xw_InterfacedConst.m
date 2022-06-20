//
//  PPInterfacedConst.m
//  PPNetworkHelper
//
//  Created by YiAi on 2017/7/6.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import "xw_InterfacedConst.h"

#if DevelopSever
#elif TestSever
/** 接口前缀-测试服务器*/
NSString *const kApiPrefix = @"http://api.bt-dev.yndth.cn/bt_cus_tc";
//NSString *const kApiPrefix = @"http://eport.bt-market.yndth.cn";
#elif ProductSever
/** 接口前缀-生产服务器*/
//NSString *const kApiPrefix = @"http://ds.bt-dev.yndth.cn";

NSString *const kApiPrefix = @"http://api.bt-dev.yndth.cn/bt_cus_tc";
//NSString *const kApiPrefix = @"http://eport.bt-market.yndth.cn";
#endif

/** 登录*/
NSString *const kLogin = @"/sso/login";
//
///** 用户注册接口*/
//NSString *const kRegister = @"/sso/user/register";
//
///** 修改密码*/
//NSString *const kUpdatePassword = @"/sso/user/updatePassword";
//
///** 当前登陆用户信息*/
//NSString *const kGetCurrentUserInfo = @"/sso/user/current";



/** 用户可选和已分配组织机构树形列表（渲染）
 当前登陆用户信息
 修改密码
 用户注册*/
NSString *const kUser = @"/sso/user";


/** 获取全部字典数据*/
NSString *const kGetAllDict = @"/dict/all";

/** 委托申请分页查询
 委托申请-编辑
 海关端（检测机构）处理
 委托申请
 用户可选和已分配组织机构树形列表（渲染)
 查询物流信息
 当前委托单位的暂存委托
 委托申请-暂存
 证书查询
 获取(生成）二维码
 
 */
NSString *const kEntrustInspect = @"/entrustInspect";


/** 委托申请-详情
 委托申请-修改
 委托申请-登记
 通过委托用户ID委托单位
 */
NSString *const kEntrustOrg = @"/entrustOrg";

/** 用户未读消息分组求和
 消息分页查询
 消息点击
 */
NSString *const kMessage = @"/message";

/** 通过机构ID获取附加信息
 消息分页查询
 消息点击
 */
NSString *const kInspectOrg = @"/inspectOrg";

/** 委托检验统计（检验机构分组）
 委托检验申请统计（按委托单位分组）
 */
NSString *const kEntrustInspectStat = @"/stat/entrustInspect";
