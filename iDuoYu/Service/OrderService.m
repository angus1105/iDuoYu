//
//  OrderService.m
//  iDuoYu
//
//  Created by ky01 on 15/4/19.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import "OrderService.h"
#import "Constants.h"
#import "HttpRequestManager.h"
#import <NSObject+ObjectMap.h>
#import "RequestParam.h"
#import "LocationHelper.h"

NSString *const InquireTypeBrand = @"Brand";
NSString *const InquireTypeVersion = @"Version";
NSString *const InquireTypeColor = @"Color";
NSString *const InquireTypeFault = @"Fault";
NSString *const InquireTypeFaultDetail = @"FaultDetail";
NSString *const InquireTypeSolution = @"Solution";
NSString *const InquireTypeRom = @"Rom";
NSString *const InquireTypeBuyChannel = @"BuyChannel";
NSString *const InquireTypeFee = @"Fee";

NSString *const BusinessTypeRepair = @"Repair";
NSString *const BusinessTypeSell = @"Sell";

NSString *const GetEngineerList = @"getEngineerList";
NSString *const GetDeviceParamIds = @"getDeviceParamIds";
NSString *const GetDeviceParamList = @"getDeviceParamList";
NSString *const SubmitOrder = @"submitOrder";
NSString *const GetOrderList = @"getOrderList";


@implementation OrderService

+ (void)getCurrentCityEngineerList:(void (^)(Engineers *engineers))success
                           failure:(void (^)(NSError *error))failure {
    RequestParam *requestParam = [RequestParam new];
    [LocationHelper locateCurrentCity:^(NSDictionary *addressInfo, NSError *error) {
        if (error) {
            if (failure) {
                failure(error);
                requestParam.City = NSLocalizedString(@"北京市", @"北京市");
            }
        }else {
            requestParam.City = [addressInfo objectForKey:@"State"];
        }
    }];
    if(isStringEmpty(requestParam.City)){
        requestParam.City = NSLocalizedString(@"北京市", @"北京市");
    }
    [OrderService getEngineerList:requestParam
                          success:^(Engineers *engineers) {
                              if (success) {
                                  success(engineers);
                              }
                              
                          } failure:^(NSError *error) {
                              if (failure) {
                                  failure(error);
                              }
                          }];
}

+ (void)getEngineerList:(RequestParam *)requestParam
                       success:(void (^)(Engineers *engineers))success
                       failure:(void (^)(NSError *error))failure{
//#if kIsSimulationData
//    NSString *srcPath = [[NSBundle mainBundle] pathForResource:@"jsonEngineerListTest" ofType:@"json"];
//    NSData *jsonData = [NSData dataWithContentsOfFile:srcPath];
//    Engineers *engineerList = [[Engineers alloc] initWithJSONData:jsonData];
//    
//    if (success) {
//        success(engineerList);
//    }
//#else
    NSString *requestContent = [requestParam getRequestStrByEntity:requestParam action:GetEngineerList];
#if DBG
    NSLog(@"kGetEngineerList requestStr is %@",requestContent);
#endif
    [HttpRequestManager postWithURL:[NSURL URLWithString:HOST]
                         andContent:requestContent
                            success:^(NSString *responseString) {
#if DBG
                                NSLog(@"kGetEngineerList responseStr is %@",responseString);
#endif
                                NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
                                Engineers *engineerList = [[Engineers alloc] initWithJSONData:jsonData];
                                if (success) {
                                    success(engineerList);
                                }
                            } failure:^(NSError *error) {
                                NSLog(@"error = %@", error);
                                if (failure) {
                                    failure(error);
                                }
                            }];
    
//#endif
}

+ (void)getDeviceParamIds:(RequestParam *)requestParam
                             success:(void (^)(ResultRespond *resultRespond))success
                             failure:(void (^)(NSError *error))failure{
#if kIsSimulationData
    NSString *srcPath = [[NSBundle mainBundle] pathForResource:@"jsonRespondTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:srcPath];
    ResultRespond *resultRespond = [[ResultRespond alloc] initWithJSONData:jsonData];
    
    if (success) {
        success(resultRespond);
    }
#else
    NSString *requestContent = [requestParam getRequestStrByEntity:requestParam action:GetDeviceParamIds];
#if DBG
    NSLog(@"kGetDeviceParamIds requestStr is %@",requestContent);
#endif
    [HttpRequestManager postWithURL:[NSURL URLWithString:HOST]
                         andContent:requestContent
                            success:^(NSString *responseString) {
#if DBG
                                NSLog(@"kGetDeviceParamIds responseStr is %@",responseString);
#endif
                                NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
                                ResultRespond *resultRespond = [[ResultRespond alloc] initWithJSONData:jsonData];
                                if (success) {
                                    success(resultRespond);
                                }
                            } failure:^(NSError *error) {
                                NSLog(@"error = %@", error);
                                if (failure) {
                                    failure(error);
                                }
                            }];
    
#endif
}

+ (void)getDeviceParamList:(RequestParam *)requestParam
                   success:(void (^)(DeviceParams *deviceParams))success
                   failure:(void (^)(NSError *error))failure{
    
#if kIsSimulationData
    NSString *srcPath = [[NSBundle mainBundle] pathForResource:@"jsonBrandListTest" ofType:@"json"];
    if ([requestParam.InquireType isEqualToString:InquireTypeBrand]) {
        srcPath = [[NSBundle mainBundle] pathForResource:@"jsonBrandListTest" ofType:@"json"];
    }else if([requestParam.InquireType isEqualToString:InquireTypeVersion]) {
        srcPath = [[NSBundle mainBundle] pathForResource:@"jsonVersionListTest" ofType:@"json"];
    }else if([requestParam.InquireType isEqualToString:InquireTypeColor]) {
        srcPath = [[NSBundle mainBundle] pathForResource:@"jsonColorListTest" ofType:@"json"];
    }else if([requestParam.InquireType isEqualToString:InquireTypeFault]) {
        srcPath = [[NSBundle mainBundle] pathForResource:@"jsonFaultListTest" ofType:@"json"];
    }else if([requestParam.InquireType isEqualToString:InquireTypeFaultDetail]) {
        srcPath = [[NSBundle mainBundle] pathForResource:@"jsonFaultDetailListTest" ofType:@"json"];
    }else if([requestParam.InquireType isEqualToString:InquireTypeSolution]) {
        if ([requestParam.BusinessType isEqualToString:@"Repair"]) {
            srcPath = [[NSBundle mainBundle] pathForResource:@"jsonSolutionRepairListTest" ofType:@"json"];
        }else{
            srcPath = [[NSBundle mainBundle] pathForResource:@"jsonSolutionSellListTest" ofType:@"json"];
        }
    }else if([requestParam.InquireType isEqualToString:InquireTypeRom]) {
        srcPath = [[NSBundle mainBundle] pathForResource:@"jsonRomListTest" ofType:@"json"];
    }else if([requestParam.InquireType isEqualToString:InquireTypeBuyChannel]) {
        srcPath = [[NSBundle mainBundle] pathForResource:@"jsonBuyChannelListTest" ofType:@"json"];
    }
    NSData *jsonData = [NSData dataWithContentsOfFile:srcPath];
    DeviceParams *deviceParamList = [[DeviceParams alloc] initWithJSONData:jsonData];
    
    if (success) {
        success(deviceParamList);
    }
#else
    NSString *requestContent = [requestParam getRequestStrByEntity:requestParam action:GetDeviceParamList];
#if DBG
    NSLog(@"kGetDeviceParamList requestStr is %@",requestContent);
#endif
    [HttpRequestManager postWithURL:[NSURL URLWithString:HOST]
                         andContent:requestContent
                            success:^(NSString *responseString) {
#if DBG
                                NSLog(@"kGetDeviceParamList responseStr is %@",responseString);
#endif
                                NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
                                DeviceParams *deviceParamsList = [[DeviceParams alloc] initWithJSONData:jsonData];
                                if (success) {
                                    success(deviceParamsList);
                                }
                            } failure:^(NSError *error) {
                                NSLog(@"error = %@", error);
                                if (failure) {
                                    failure(error);
                                }
                            }];
#endif
}

+ (void)submitOrder:(RequestParam *)requestParam
                       success:(void (^)(ResultRespond *resultRespond))success
                       failure:(void (^)(NSError *error))failure{
#if kIsSimulationData
    NSString *srcPath = [[NSBundle mainBundle] pathForResource:@"jsonRespondTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:srcPath];
    ResultRespond *resultRespond = [[ResultRespond alloc] initWithJSONData:jsonData];
    
    if (success) {
        success(resultRespond);
    }
#else
    NSString *requestContent = [requestParam getRequestStrByEntity:requestParam action:SubmitOrder];
#if DBG
    NSLog(@"kSubmitOrder requestStr is %@",requestContent);
#endif
    [HttpRequestManager postWithURL:[NSURL URLWithString:HOST]
                         andContent:requestContent
                            success:^(NSString *responseString) {
#if DBG
                                NSLog(@"kSubmitOrder responseStr is %@",responseString);
#endif
                                NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
                                ResultRespond *resultRespond = [[ResultRespond alloc] initWithJSONData:jsonData];
                                if (success) {
                                    success(resultRespond);
                                }
                            } failure:^(NSError *error) {
                                NSLog(@"error = %@", error);
                                if (failure) {
                                    failure(error);
                                }
                            }];
    
#endif
}

+ (void)getOrderList:(RequestParam *)requestParam
             success:(void (^)(Orders *orders))success
             failure:(void (^)(NSError *error))failure{
#if kIsSimulationData
    NSString *srcPath = [[NSBundle mainBundle] pathForResource:@"jsonOrderListTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:srcPath];
    Orders *orderList = [[Orders alloc] initWithJSONData:jsonData];
    
    if (success) {
        success(orderList);
    }
#else
    NSString *requestContent = [requestParam getRequestStrByEntity:requestParam action:GetOrderList];
#if DBG
    NSLog(@"kGetOrderList requestStr is %@",requestContent);
#endif
    [HttpRequestManager postWithURL:[NSURL URLWithString:HOST]
                         andContent:requestContent
                            success:^(NSString *responseString) {
#if DBG
                                NSLog(@"kGetOrderList responseStr is %@",responseString);
#endif
                                NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
                                Orders *orderList = [[Orders alloc] initWithJSONData:jsonData];
                                if (success) {
                                    success(orderList);
                                }
                            } failure:^(NSError *error) {
                                NSLog(@"error = %@", error);
                                if (failure) {
                                    failure(error);
                                }
                            }];
    
#endif
}

@end
