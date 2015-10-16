//
//  Header.m
//  Life
//
//  Created by  on 11-11-28.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "Header.h"

@implementation Header
-(Header *)init{
    self = [super init];
    if (self) {
        self.DeviceId = @"";
        self.ClientType = @"";
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        //获取软件的版本号
        NSString *version = [infoDict objectForKey:@"CFBundleVersion"];
        self.ClientVersion = version;
        self.ClientId = @"";
    }
    return self;
}
@end
