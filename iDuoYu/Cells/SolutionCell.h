//
//  SolutionCell.h
//  iDuoYu
//
//  Created by ky01 on 15/4/21.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StepsSelectTableViewController.h"

@interface SolutionCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *leftImageView;
@property (strong, nonatomic) IBOutlet UITextView *descriptionView;
@property (strong, nonatomic) IBOutlet UIButton *selectButton;
@property (strong, nonatomic) StepsSelectTableViewController *ssCtl;
@property (assign, nonatomic) NSInteger indexInt;
- (IBAction)selectAction:(id)sender;
@end
