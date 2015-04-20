//
//  Request.h
//  Life
//
//  Created by  on 11-12-2.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@class Header;
@class Body;

@interface Request : NSObject 
@property (nonatomic, strong) Header *Header;
@property (nonatomic, strong) Body *Body;
@end
