//
//  Engineers.m
//  iDuoYu
//
//  Created by ky01 on 15/4/19.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import "Engineers.h"

@implementation Engineers

- (id)init {
    self = [super init];
    
    if (self) {
        [self setValue:@"Engineer" forKeyPath:@"propertyArrayMap.Engineers"];
    }
    
    return self;
}

@end
