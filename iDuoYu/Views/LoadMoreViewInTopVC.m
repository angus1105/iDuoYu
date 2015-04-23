//
//  LoadMoreViewInTopVC.m
//  iDuoYu
//
//  Created by ChenAngus on 15/4/22.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import "LoadMoreViewInTopVC.h"
#import "Constants.h"

@implementation LoadMoreViewInTopVC

+ (instancetype)newLoadMoreView {
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"LoadMoreViewInTopVC"
                                                  owner:nil
                                                options:nil];
    if (nibs.count > 0) {
        
        LoadMoreViewInTopVC *view = [nibs objectAtIndex:0];
        
        return view;
    }
    
    return nil;
}

- (IBAction)buttonTouch:(id)sender {
    __weak typeof(self) weakSelf = self;
    
    if (weakSelf.buttonTouchedBlock) {
        weakSelf.buttonTouchedBlock(sender);
    }
}

- (IBAction)engineerNearByTouchDown:(id)sender {
    self.backgroundColor = [UIColor lightGrayColor];
}

- (IBAction)engineerNearByTouchCancel:(id)sender {
    [self setBackgroundColor: UIColorMake255(230, 230, 230, 1.f)];
}

@end
