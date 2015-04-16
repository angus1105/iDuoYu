//
//  ViewController.h
//  iDuoYu
//
//  Created by ChenAngus on 15/4/13.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseAlert.h"

@interface ViewController : UIViewController <ChooseAlertProtocol>
@property (strong, nonatomic) IBOutlet UIButton *alertViewTest;

@property (strong, nonatomic) IBOutlet UILabel *carrierLabel;

@end

