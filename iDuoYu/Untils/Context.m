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
	if (_sharedContext == nil)
	{
		@synchronized([Context class])
		{
			if (_sharedContext == nil)
				[[self alloc] init];
		}
	}
	
	return _sharedContext;
}

+ (id)alloc
{
	@synchronized([Context class])
	{
		NSAssert(_sharedContext == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedContext = [super alloc];
		return _sharedContext;
	}
	
	return nil;
}

- (id)init
{
	if (self = [super init])
	{
        if (iPhone5) {
            screenHeight = 568.0f;
        }else{
            screenHeight = 480.0f;
        }
	}
	
	return self;
}
@end
