//
//  Orders.m
//  iDuoYu
//
//  Created by ky01 on 15/4/19.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import "Orders.h"

@implementation Orders

- (id)init {
    self = [super init];
    
    if (self) {
        [self setValue:@"Orders" forKeyPath:@"propertyArrayMap.Orders"];
    }
    
    return self;
}

@end
