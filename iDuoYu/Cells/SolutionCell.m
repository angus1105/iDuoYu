//
//  SolutionCell.m
//  iDuoYu
//
//  Created by ky01 on 15/4/21.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import "SolutionCell.h"
#import "DeviceParam.h"
#import "Context.h"
#import "ShowFeeTableViewController.h"

@implementation SolutionCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)selectAction:(id)sender{
    DeviceParam *deviceParam = [self.ssCtl.deviceParams.DeviceParams objectAtIndex:self.indexInt];
    [[Context sharedContext] setSolutionId:deviceParam.ParamId];
    [[Context sharedContext] setSolution:deviceParam.ParamName];
    [[Context sharedContext] setSolutionURL:deviceParam.ParamUrl];
    [[Context sharedContext] setSolutionDescription:deviceParam.Description];
    [[Context sharedContext] setFee:deviceParam.Fee];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ShowFeeTableViewController *showFeeViewController = [storyboard instantiateViewControllerWithIdentifier:@"showFee"];
    [self.ssCtl.navigationController pushViewController:showFeeViewController
                                         animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
