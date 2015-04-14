//
//  Company.h
//  iDuoYu
//
//  Created by ChenAngus on 15/4/14.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Company : NSObject
@property (nonatomic, strong) NSString *CompanyId;
@property (nonatomic, strong) NSString *CompanyName;
@property (nonatomic, strong) NSString *CompanyType;
@property (nonatomic, strong) NSString *CompanyAddress;
@property (nonatomic, strong) NSString *CompanyContactPhone;
@property (nonatomic, strong) NSString *CompanyArea;
@property (nonatomic, strong) NSString *IsLocation;
@property (nonatomic, strong) NSString *Longitude;
@property (nonatomic, strong) NSString *Latitude;
@property (nonatomic, strong) NSString *Distance;
@property (nonatomic, strong) NSString *CompanyTypeId;

@end
