//
//  OrderService.h
//  iDuoYu
//
//  Created by ky01 on 15/4/19.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestParam.h"
#import "ResultRespond.h"
#import "Engineers.h"
#import "DeviceParams.h"
#import "Orders.h"

/**
 `OrderService` 与服务器交互类
 */

/**
 业务查询条件字符串
 */
extern NSString *const InquireTypeBrand;
extern NSString *const InquireTypeVersion;
extern NSString *const InquireTypeColor;
extern NSString *const InquireTypeFault;
extern NSString *const InquireTypeFaultDetail;
extern NSString *const InquireTypeSolution;
extern NSString *const InquireTypeRom;
extern NSString *const InquireTypeBuyChannel;
extern NSString *const InquireTypeFee;

/**
 业务类型字符串
 */
extern NSString *const BusinessTypeRepair;
extern NSString *const BusinessTypeSell;

/**
 业务类型action字符串
 */
extern NSString *const GetEngineerList;
extern NSString *const GetDeviceParamIds;
extern NSString *const GetDeviceParamList;
extern NSString *const SubmitOrder;
extern NSString *const GetOrderList;

@interface OrderService : NSObject

/**
 获取当前城市的所有工程师信息列表，此方法首先通过定位获取城市信息，然后向服务端发出请求获取到工程师列表
 @param success 成功获取后调用的block
 @param failure 获取失败后调用的block
 */
+ (void)getCurrentCityEngineerList:(void (^)(Engineers *engineers))success
                           failure:(void (^)(NSError *error))failure;


/**
 根据城市名获取此城市的所有工程师的列表，需要一个配置了City属性的RequestParma实体
 @param success 成功获取后调用的block
 @param failure 获取失败后调用的block
 */
+ (void)getEngineerList:(RequestParam *)requestParam
                success:(void (^)(Engineers *engineers))success
                failure:(void (^)(NSError *error))failure;

+ (void)getDeviceParamIds:(RequestParam *)requestParam
                  success:(void (^)(ResultRespond *resultRespond))success
                  failure:(void (^)(NSError *error))failure;

+ (void)getDeviceParamList:(RequestParam *)requestParam
                             success:(void (^)(DeviceParams *deviceParams))success
                             failure:(void (^)(NSError *error))failure;

+ (void)submitOrder:(RequestParam *)requestParam
                       success:(void (^)(ResultRespond *resultRespond))success
                       failure:(void (^)(NSError *error))failure;

+ (void)getOrderList:(RequestParam *)requestParam
                 success:(void (^)(Orders *orders))success
                 failure:(void (^)(NSError *error))failure;

@end
