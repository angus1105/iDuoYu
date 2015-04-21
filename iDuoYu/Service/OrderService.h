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
