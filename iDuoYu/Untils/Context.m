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
@end
