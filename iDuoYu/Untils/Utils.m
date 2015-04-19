//
//  Utils.m
//  iDuoYu
//
//  Created by ChenAngus on 15/4/19.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import "Utils.h"
@import CoreTelephony;

@implementation Utils

+ (NSString *)currentDeviceTotalDiskSpace {
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSNumber *totalSpace = [fattributes objectForKey:NSFileSystemSize];
    float totalSpaceFloat = [totalSpace floatValue]/1000/1000/1000;
    
    if (totalSpaceFloat> 5.0 && totalSpaceFloat < 10.f) {
        return @"8 GB";
    }else if (totalSpaceFloat > 12.0 && totalSpaceFloat < 18.0) {
        return @"16 GB";
    }else if (totalSpaceFloat > 25.0 && totalSpaceFloat < 35.0) {
        return @"32 GB";
    }else if (totalSpaceFloat > 55.0 && totalSpaceFloat < 65.0) {
        return @"64 GB";
    }else if (totalSpaceFloat > 120.0 && totalSpaceFloat < 130.0) {
        return @"128 GB";
    }else if (totalSpaceFloat > 250.0 && totalSpaceFloat < 260.0) {
        return @"256 GB";
    }else {
        return [NSString stringWithFormat:@"%3.0f GB", totalSpaceFloat];
    }
}

+ (NSString *)carrierName {
    CTTelephonyNetworkInfo *netinfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [netinfo subscriberCellularProvider];
#if TARGET_IPHONE_SIMULATOR
    return @"Simulator";
#else
    if (carrier.carrierName == nil || carrier.carrierName.length <= 0)
        return @"N/A";
#endif
    return [carrier carrierName];
}


@end
