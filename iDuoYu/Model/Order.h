//
//  Order.h
//  iDuoYu
//
//  Created by ky01 on 15/4/19.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Order : NSObject
@property (nonatomic, strong) NSString *OrderSN;
@property (nonatomic, strong) NSString *Content;
@property (nonatomic, strong) NSString *BusinessType;
@property (nonatomic, strong) NSString *Fee;
@property (nonatomic, strong) NSString *CreateTime;
@property (nonatomic, strong) NSString *OrderStatus;
@end
