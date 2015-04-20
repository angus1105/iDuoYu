//
//  Body.h
//  Life
//
//  Created by  on 11-12-4.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RequestParam;

@interface Body:NSObject
@property (nonatomic, strong) NSString *Action;
@property (nonatomic, strong) RequestParam *RequestParam;

@end
