//
//  RequestParam.m
//  Life
//
//  Created by  on 11-12-2.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "RequestParam.h"
#import <NSObject+ObjectMap.h>
#import "Constants.h"

#import "Body.h"
#import "Request.h"
#import "Context.h"

@implementation RequestParam

- (NSString *)getRequestStrByEntity:(RequestParam *)requestParam action:(NSString *)action{
    Body *body = [[Body alloc] init];
    body.Action = action;
    body.RequestParam = requestParam;
    
    Request *request = [[Request alloc] init];
    request.Header = [[Context sharedContext] header];
    request.Body = body;
    
    NSString *requestStr = [request JSONString];
    return requestStr;
}

@end
