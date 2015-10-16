//
//  LoadMoreViewInTopVC.h
//  iDuoYu
//
//  Created by ChenAngus on 15/4/22.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadMoreViewInTopVC : UIView
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UIImageView *rightIndicatorImageView;
+ (instancetype)newLoadMoreView;
@property (strong) void(^buttonTouchedBlock)(id sender);

@end
