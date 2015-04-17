//
//  HttpRequestManager.h
//  iDuoYu
//
//  Created by ChenAngus on 15/4/16.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

/**
 `HttpRequestManager` 网络请求工具类
 */

#import <Foundation/Foundation.h>

@interface HttpRequestManager : NSObject


/**
 发送普通POST请求，主要用于post json请求
 @param urlString 请求地址
 @param parmas 参数字典
 @param success 请求成功返回后调用的block，responseString为返回的字符串
 @param failure 请求失败后调用的block，error为错误信息
 */
+ (void)postWithURL:(NSString *)urlString
      andParameters:(NSDictionary *)params
            success:(void (^)(NSString *responseString))success
            failure:(void (^)(NSError *error))failure;
/**
 发送普通POST请求，主要用于post 纯文本 信息
 @param 同上
 */
+ (void)postWithURL:(NSURL *)url
         andContent:(NSString *)content
            success:(void (^)(NSString *responseString))success
            failure:(void (^)(NSError *error))failure;


/**
 发送post NSData类型数据请求
 */
+ (void)postWithURL:(NSURL *)url
            andData:(NSData *)data
            success:(void (^)(NSString *responseString))success
            failure:(void (^)(NSError *error))failure;


+ (void)requestWithMethod:(NSString *)method
                   andURL:(NSURL *)url
                     data:(NSData *)data
                  success:(void (^)(NSString *responseString))success
                  failure:(void (^)(NSError *error))failure;

@end
