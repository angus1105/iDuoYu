//
//  HttpRequestManager.m
//  iDuoYu
//
//  Created by ChenAngus on 15/4/16.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import "HttpRequestManager.h"
#import <AFNetworking.h>

@implementation HttpRequestManager

+ (void)postWithURL:(NSString *)urlString
      andDictionary:(NSDictionary *)params
            success:(void (^)(NSString *responseString))success
            failure:(void (^)(NSError *error))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST: urlString
       parameters: params
          success:^(AFHTTPRequestOperation *operation, id responseObject){
              NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
              
              NSLog(@"JSON: %@", string);
              if (success) {
                  success(string);
              }
          }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];

}

+ (void)postWithURL:(NSURL *)url
         andContent:(NSString *)content
            success:(void (^)(NSString *responseString))success
            failure:(void (^)(NSError *error))failure {
    return [HttpRequestManager postWithURL:url
                                   andData:[content dataUsingEncoding:NSUTF8StringEncoding]
                                   success:success
                                   failure:failure];
}

+ (void)postWithURL:(NSURL *)url
            andData:(NSData *)data
            success:(void (^)(NSString *responseString))success
            failure:(void (^)(NSError *error))failure{
    NSMutableURLRequest *request =
    [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded"
   forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:data];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSOperation *operation =
    [manager HTTPRequestOperationWithRequest:request
                                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                         NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                                         NSLog(@"JSON: %@", string);
                                         
                                         if (success) {
                                             success(string);
                                         }
                                         
                                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         NSLog(@"Error: %@", error);
                                         
                                         if (failure) {
                                             failure(error);
                                         }
                                     }];
    [manager.operationQueue addOperation:operation];
}

@end
