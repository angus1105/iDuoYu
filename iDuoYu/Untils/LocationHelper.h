//
//  LocationHelper.h
//  iDuoYu
//
//  Created by ChenAngus on 15/4/17.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <INTULocationManager.h>
#import <UIKit/UIKit.h>

/**
 `LocationHelper` 获取当前城市名的简单封装
 */

@interface LocationHelper : NSObject

+ (void)locateCurrentCity: (void (^)(NSDictionary *addressInfo, NSError *error))locatedCity;


@end
