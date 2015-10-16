//
//  Utils.h
//  iDuoYu
//
//  Created by ChenAngus on 15/4/19.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 `Utils` 工具类
 */

@interface Utils : NSObject

+ (NSString *)currentDeviceTotalDiskSpace;
+ (NSString *)carrierName;
@end


@interface NSString (Trim)
- (NSString *)trim;
- (BOOL)isEmpty;
@end