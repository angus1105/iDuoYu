//
//  MainTableHeaderView.m
//  iDuoYu
//
//  Created by ChenAngus on 15/4/18.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import "MainTableHeaderView.h"


@implementation MainTableHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)headerViewWithGIF:(NSString *)gifName {
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"MainTableHeaderView"
                                                  owner:nil
                                                options:nil];
    if (nibs.count > 0) {
        
        MainTableHeaderView *view = [nibs objectAtIndex:0];
        NSData *gifData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:gifName ofType:nil]];
        
        view.gifImageView.gifData = gifData;
        view.locationBackgroundView.layer.cornerRadius = 10.0f;
        
        return view;
    }
    
    return nil;
}

@end
