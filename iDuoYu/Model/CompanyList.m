//
//  CompanyList.m
//  iDuoYu
//
//  Created by ChenAngus on 15/4/14.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import "CompanyList.h"

@implementation CompanyList

- (id)init {
    self = [super init];
    
    if (self) {
        [self setValue:@"Company" forKeyPath:@"propertyArrayMap.Companys"];
    }
    
    return self;
}

@end
