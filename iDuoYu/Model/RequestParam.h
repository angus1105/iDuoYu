//
//  RequestParam.h
//  Life
//
//  Created by  on 11-12-2.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface RequestParam : NSObject

@property (nonatomic, strong) NSString *City;

@property (nonatomic, strong) NSString *BusinessType;
@property (nonatomic, strong) NSString *Brand;
@property (nonatomic, strong) NSString *Version;
@property (nonatomic, strong) NSString *Rom;

@property (nonatomic, strong) NSString *InquireType;
@property (nonatomic, strong) NSString *BrandId;
@property (nonatomic, strong) NSString *VersionId;
@property (nonatomic, strong) NSString *ColorId;
@property (nonatomic, strong) NSString *FaultId;
@property (nonatomic, strong) NSString *FaultDetailId;
@property (nonatomic, strong) NSString *SolutionId;
@property (nonatomic, strong) NSString *RomId;
@property (nonatomic, strong) NSString *BuyChannelId;

@property (nonatomic, strong) NSString *Color;
@property (nonatomic, strong) NSString *Fault;
@property (nonatomic, strong) NSString *FaultDetail;
@property (nonatomic, strong) NSString *Solution;
@property (nonatomic, strong) NSString *BuyChannel;
@property (nonatomic, strong) NSString *Fee;
@property (nonatomic, strong) NSString *CustomerName;
@property (nonatomic, strong) NSString *CustomerMobileNumber;
@property (nonatomic, strong) NSString *CustomerAddress;
@property (nonatomic, strong) NSString *ServiceType;

- (NSString *)getRequestStrByEntity:(RequestParam *)requestParam action:(NSString *)action;

@end
