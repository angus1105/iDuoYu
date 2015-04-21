//
//  StepsSelectTableViewController.h
//  iDuoYu
//
//  Created by ChenAngus on 15/4/19.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestParam.h"
#import "DeviceParams.h"

@interface StepsSelectTableViewController : UITableViewController <UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *subTitle;
@property (nonatomic, strong) RequestParam *requestParam;
@property (nonatomic, strong) DeviceParams *deviceParams;
@property (nonatomic, strong) UIViewController *parentController;
@end
