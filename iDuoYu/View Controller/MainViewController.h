//
//  MainViewController.h
//  iDuoYu
//
//  Created by ky01 on 15/4/15.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

@interface MainViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>
- (IBAction)revealMenu:(id)sender;
@end
