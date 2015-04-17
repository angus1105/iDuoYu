//
//  HttpRequestManager.h
//  iDuoYu
//
//  Created by ChenAngus on 15/4/16.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequestManager : NSObject

+ (void)postWithURL:(NSString *)urlString
      andDictionary:(NSDictionary *)params
            success:(void (^)(NSString *responseString))success
            failure:(void (^)(NSError *error))failure;

+ (void)postWithURL:(NSURL *)url
         andContent:(NSString *)content
            success:(void (^)(NSString *responseString))success
            failure:(void (^)(NSError *error))failure;

+ (void)postWithURL:(NSURL *)url
            andData:(NSData *)data
            success:(void (^)(NSString *responseString))success
            failure:(void (^)(NSError *error))failure;

;

@end
