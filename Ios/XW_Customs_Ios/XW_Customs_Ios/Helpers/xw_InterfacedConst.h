//
//  PPInterfacedConst.h
//  PPNetworkHelper
//
//  Created by AndyPang on 2017/4/10.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */

#define DevelopSever 0
#define TestSever    1
#define ProductSever 0

/** 接口前缀-开发服务器*/
UIKIT_EXTERN NSString *const kApiPrefix;

#pragma mark - 详细接口地址

/** 登录*/
UIKIT_EXTERN NSString *const kLogin;
/** 用户可选和已分配组织机构树形列表（渲染）
 当前登陆用户信息
 修改密码
 用户注册*/
UIKIT_EXTERN NSString *const kUser ;


/** 获取全部字典数据*/
UIKIT_EXTERN NSString *const kGetAllDict ;

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
UIKIT_EXTERN NSString *const kEntrustInspect;


/** 委托申请-详情
 委托申请-修改
 委托申请-登记
 通过委托用户ID委托单位
 */
UIKIT_EXTERN NSString *const kEntrustOrg;

/** 用户未读消息分组求和
 消息分页查询
 消息点击
 */
UIKIT_EXTERN NSString *const kMessage;

/** 通过机构ID获取附加信息
 消息分页查询
 消息点击
 */
UIKIT_EXTERN NSString *const kInspectOrg ;

/** 委托检验统计（检验机构分组）
 委托检验申请统计（按委托单位分组）
 */
UIKIT_EXTERN NSString *const kEntrustInspectStat;
