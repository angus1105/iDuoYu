//
//  MainTableHeaderView.h
//  iDuoYu
//
//  Created by ChenAngus on 15/4/18.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YFGIFImageView.h>

IB_DESIGNABLE
@interface MainTableHeaderView : UIView
@property (strong, nonatomic) IBOutlet YFGIFImageView *gifImageView;
@property (strong, nonatomic) IBOutlet UIView *locationBackgroundView;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *amoutOfEngineerLabel;

+ (instancetype)headerViewWithGIF:(NSString *)gifName;

@end
