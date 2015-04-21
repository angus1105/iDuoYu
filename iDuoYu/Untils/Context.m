//
//  Context.m
//  UFC
//
//  Created by Roy on 10-12-30.
//  Copyright 2010 UFIDA. All rights reserved.
//

#import "Context.h"

@implementation Context

static Context* _sharedContext = nil;

+ (Context*)sharedContext
{
    static dispatch_once_t _onceToken;
    dispatch_once(&_onceToken, ^{
        _sharedContext = [[self alloc] init];
    });
    return _sharedContext;
}

- (id)init
{
	if (self = [super init])
	{
        if (iPhone5) {
            self.screenHeight = 568.0f;
        }else{
            self.screenHeight = 480.0f;
        }
        self.header = [[Header alloc] init];
	}
	
	return self;
}

- (void)clearParamWithInquireType:(NSString *)inquireType{
    if ([inquireType isEqualToString:@"Brand"]) {
        self.BrandId = @"";
        self.Brand = @"";
    }else if([inquireType isEqualToString:@"Version"]) {
        self.VersionId = @"";
        self.Version = @"";
    }else if([inquireType isEqualToString:@"Color"]) {
        self.ColorId = @"";
        self.Color = @"";
    }else if([inquireType isEqualToString:@"Fault"]) {
        self.FaultId = @"";
        self.Fault = @"";
    }else if([inquireType isEqualToString:@"FaultDetail"]) {
        self.FaultDetailId = @"";
        self.FaultDetail = @"";
    }else if([inquireType isEqualToString:@"Solution"]) {
        self.SolutionId = @"";
        self.Solution = @"";
        self.SolutionURL = @"";
        self.SolutionDescription = @"";
        self.Fee = @"";
    }else if([inquireType isEqualToString:@"Rom"]) {
        self.RomId = @"";
        self.Rom = @"";
    }else if([inquireType isEqualToString:@"BuyChannel"]) {
        self.BuyChannelId = @"";
        self.BuyChannel = @"";
    }else if([inquireType isEqualToString:@"All"]) {
        self.BusinessType = @"";
        self.BrandId = @"";
        self.Brand = @"";
        self.VersionId = @"";
        self.Version = @"";
        self.ColorId = @"";
        self.Color = @"";
        self.FaultId = @"";
        self.Fault = @"";
        self.FaultDetailId = @"";
        self.FaultDetail = @"";
        self.SolutionId = @"";
        self.Solution = @"";
        self.SolutionURL = @"";
        self.SolutionDescription = @"";
        self.Fee = @"";
        self.RomId = @"";
        self.Rom = @"";
        self.BuyChannelId = @"";
        self.BuyChannel = @"";
        self.CustomerName = @"";
        self.CustomerMobileNumber = @"";
        self.CustomerAddress = @"";
        self.ServiceType = @"";
    }
}

@end
