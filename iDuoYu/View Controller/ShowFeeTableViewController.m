//
//  ShowFeeTableViewController.m
//  iDuoYu
//
//  Created by ky01 on 15/4/21.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import "ShowFeeTableViewController.h"
#import "FeeCell.h"
#import "Context.h"
#import "Constants.h"
#import "FeeHeaderView.h"

@interface ShowFeeTableViewController ()

@end

@implementation ShowFeeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"FeeHeaderView"
                                                  owner:nil
                                                options:nil];
    FeeHeaderView *headerSubView = [nibs objectAtIndex:0];
//    headerSubView.headerSubtitleTextView.frame = CGRectMake(headerSubView.headerSubtitleTextView.frame.origin.x,
//                                                            headerSubView.headerSubtitleTextView.frame.origin.y,
//                                                            headerSubView.headerSubtitleTextView.frame.size.width, 20);
    headerSubView.frame = CGRectMake(0, 0, self.view.frame.size.width, headerSubView.headerImageView.frame.origin.y+headerSubView.headerImageView.frame.size.height);
    headerSubView.backgroundColor = UIColorMake255(247, 247, 247, 1.0);
    self.tableView.tableHeaderView = headerSubView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"feeCell";
    FeeCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier
                                                    forIndexPath:indexPath];
    cell.submitButton.backgroundColor = UIColorMake255(118, 201, 106, 1.0);
    cell.cancelButton.layer.borderWidth = 3;
    cell.cancelButton.layer.borderColor = [UIColorMake255(118, 201, 106, 1.0) CGColor];
    cell.cancelButton.layer.cornerRadius = 5;
    cell.titleLabel.text = [[Context sharedContext] Solution];
    cell.feeLabel.text = [[Context sharedContext] Fee];
    cell.descriptionView.text = [[Context sharedContext] SolutionDescription];
    return cell;
}


@end
