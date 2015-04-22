//
//  Context.h
//  UFC singletom 全局上下文对象，用于保存会话信息等
//
//  Created by Roy on 10-12-30.
//  Copyright 2010 UFIDA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Common.h"
#import "Header.h"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@interface Context : NSObject
@property (nonatomic, assign) CGFloat screenWitch;
@property (nonatomic, assign) CGFloat screenHeight;
@property (nonatomic, strong) Header *header;
+ (Context*)sharedContext;
@property (nonatomic, strong) NSString *BusinessType;
@property (nonatomic, strong) NSString *BrandId;
@property (nonatomic, strong) NSString *Brand;
@property (nonatomic, strong) NSString *VersionId;
@property (nonatomic, strong) NSString *Version;
@property (nonatomic, strong) NSString *ColorId;
@property (nonatomic, strong) NSString *Color;
@property (nonatomic, strong) NSString *FaultId;
@property (nonatomic, strong) NSString *Fault;
@property (nonatomic, strong) NSString *FaultDetailId;
@property (nonatomic, strong) NSString *FaultDetail;
@property (nonatomic, strong) NSString *SolutionId;
@property (nonatomic, strong) NSString *Solution;
@property (nonatomic, strong) NSString *SolutionURL;
@property (nonatomic, strong) NSString *SolutionDescription;
@property (nonatomic, strong) NSString *Fee;
@property (nonatomic, strong) NSString *RomId;
@property (nonatomic, strong) NSString *Rom;
@property (nonatomic, strong) NSString *BuyChannelId;
@property (nonatomic, strong) NSString *BuyChannel;
@property (nonatomic, strong) NSString *CustomerName;
@property (nonatomic, strong) NSString *CustomerMobileNumber;
@property (nonatomic, strong) NSString *CustomerAddress;
@property (nonatomic, strong) NSString *ServiceType;
@property (nonatomic, strong) NSString *OrderSN;

- (void)clearParamWithInquireType:(NSString *)inquireType;

@end
