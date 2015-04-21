//
//  TopViewController.h
//  iDuoYu
//
//  Created by ChenAngus on 15/4/20.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "ChooseAlert.h"

@protocol ChooseAlertProtocol;
@interface TopViewController : UIViewController <ChooseAlertProtocol>

@end
