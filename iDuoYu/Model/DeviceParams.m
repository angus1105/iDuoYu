//
//  DeviceParams.m
//  iDuoYu
//
//  Created by ky01 on 15/4/19.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import "DeviceParams.h"

@implementation DeviceParams

- (id)init {
    self = [super init];
    
    if (self) {
        [self setValue:@"DeviceParam" forKeyPath:@"propertyArrayMap.DeviceParams"];
    }
    
    return self;
}

@end
