//
//  ResultRespond.h
//  iDuoYu
//
//  Created by ky01 on 15/4/19.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultRespond : NSObject
@property (nonatomic, strong) NSString *Result;
@property (nonatomic, strong) NSString *BrandId;
@property (nonatomic, strong) NSString *VersionId;
@property (nonatomic, strong) NSString *RomId;
@property (nonatomic, strong) NSString *ErrorCode;
@property (nonatomic, strong) NSString *ErrorMessage;

@property (nonatomic, strong) NSString *OrderSN;
@end
