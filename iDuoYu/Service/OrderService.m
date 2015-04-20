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

@implementation OrderService

+ (void)getEngineerList:(RequestParam *)requestParam
                       success:(void (^)(Engineers *engineers))success
                       failure:(void (^)(NSError *error))failure{
#if kIsSimulationData
    NSString *srcPath = [[NSBundle mainBundle] pathForResource:@"jsonEngineerListTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:srcPath];
    Engineers *engineerList = [[Engineers alloc] initWithJSONData:jsonData];
    
    if (success) {
        success(engineerList);
    }
#else
    
    NSString *requestContent = @"";
    
    [HttpRequestManager postWithURL:[NSURL URLWithString:HOST]
                         andContent:requestContent
                            success:^(NSString *responseString) {
                                NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
                                Engineers *engineerList = [[Engineers alloc] initWithJSONData:jsonData];
                                
                                if (success) {
                                    success(engineerList);
                                }
                                
                            } failure:^(NSError *error) {
                                NSLog(@"error = %@", error);
                            }];
    
#endif
}

//+ (ResultRespond *)getDeviceParamIds:(RequestParam *)requestParam{
//#if kIsSimulationData
//    //为模拟效果所做的处理 start
//    NSString *srcPath = [[NSBundle mainBundle] pathForResource:@"jsonRespondTest" ofType:@"json"];
//    NSData *jsonData = [NSData dataWithContentsOfFile:srcPath];
//    return [[ResultRespond alloc] initWithJSONData:jsonData];
//    //为模拟效果所做的处理 end
//#else
//    NSString *requestStr = [requestParam getRequestStrByEntity:requestParam action:kGetDeviceParamIds];
//#if DBG
//    NSLog(@"kGetEngineerList requestStr is %@",requestStr);
//#endif
//    //TODO
//    return nil;
//#endif
//}
//
//+ (DeviceParams *)getDeviceParamList:(RequestParam *)requestParam{
//}
//
//+ (ResultRespond *)submitOrder:(RequestParam *)requestParam{
//}
//
//+ (Orders *)getOrderList:(RequestParam *)requestParam{
//}

@end
