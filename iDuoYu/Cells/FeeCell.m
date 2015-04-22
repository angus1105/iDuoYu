//
//  FeeCell.m
//  iDuoYu
//
//  Created by ky01 on 15/4/21.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import "FeeCell.h"
#import "ShowFeeTableViewController.h"

@implementation FeeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)submitAction:(id)sender{

}

- (IBAction)cancelAction:(id)sender{
    [self.showFeeCtl gotoHome];
}

@end
