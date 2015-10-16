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
#import "OrderService.h"
#import "CustomerViewController.h"

@interface ShowFeeTableViewController ()

@end

@implementation ShowFeeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"FeeHeaderView"
                                                  owner:nil
                                                options:nil];
    FeeHeaderView *headerSubView = [nibs objectAtIndex:0];
    headerSubView.backgroundColor = UIColorMake255(247, 247, 247, 1.0);
    headerSubView.headerTitleLabel.textColor = UIColorMake255(108, 112, 116, 1);
    headerSubView.headerSubtitleTextView.textColor = UIColorMake255(108, 112, 116, 1);
    if ([[[Context sharedContext] BusinessType] isEqualToString:BusinessTypeRepair]) {
        headerSubView.headerTitleLabel.text = NSLocalizedString(@"我们的维修方案", @"我们的维修方案");
        headerSubView.headerSubtitleTextView.text = NSLocalizedString(@"我们支持的服务方式有上门维修、邮寄维修、到店送修和取回维修。", @"");
        headerSubView.headerImageView.image = [UIImage imageNamed:@"iconRepair.png"];
    }else{
        headerSubView.headerTitleLabel.text = NSLocalizedString(@"设备回收报价", @"设备回收报价");
        headerSubView.headerSubtitleTextView.text = NSLocalizedString(@"根据您提供的信息，我们希望通过以下的价格来购买您的设备。", @"");
        headerSubView.headerImageView.image = [UIImage imageNamed:@"iconSell.png"];
    }
    CGSize size = [headerSubView.headerSubtitleTextView.text sizeWithFont:headerSubView.headerSubtitleTextView.font constrainedToSize:CGSizeMake(headerSubView.headerSubtitleTextView.frame.size.width, 2000.0f) lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat headerSubTitleHeight = size.height+40;
    headerSubView.frame = CGRectMake(0, 0, self.view.frame.size.width, headerSubView.headerTitleLabel.frame.size.height+headerSubView.headerImageView.frame.size.height+headerSubTitleHeight+10);
    self.tableView.tableHeaderView = headerSubView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    FeeHeaderView *headerSubView = (FeeHeaderView *)self.tableView.tableHeaderView;
    
    CGSize size = [headerSubView.headerSubtitleTextView.text sizeWithFont:headerSubView.headerSubtitleTextView.font constrainedToSize:CGSizeMake(headerSubView.headerSubtitleTextView.frame.size.width, 2000.0f) lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat headerSubTitleHeight = size.height+40;
    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, self.view.frame.size.width, headerSubView.headerTitleLabel.frame.size.height+headerSubView.headerImageView.frame.size.height+headerSubTitleHeight+10);
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
    cell.showFeeCtl = self;
    cell.submitButton.backgroundColor = UIColorMake255(118, 201, 106, 1.0);
    cell.cancelButton.layer.borderWidth = 3;
    cell.cancelButton.layer.borderColor = [UIColorMake255(118, 201, 106, 1.0) CGColor];
    cell.cancelButton.layer.cornerRadius = 5;
    cell.titleLabel.text = [[Context sharedContext] Solution];
    cell.feeLabel.text = [[Context sharedContext] Fee];
    cell.descriptionView.text = [[Context sharedContext] SolutionDescription];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}


- (void)gotoHome{
    UIActionSheet *goBackToHomeSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"您确定不接受服务并返回首页？", @"您确定不接受服务并返回首页？")
                                                                   delegate:self
                                                          cancelButtonTitle:NSLocalizedString(@"取消", @"取消")
                                                     destructiveButtonTitle:nil
                                                          otherButtonTitles:NSLocalizedString(@"确定", @"确定"),nil];
    goBackToHomeSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [goBackToHomeSheet showInView:[[UIApplication sharedApplication] keyWindow]];
}

#pragma mark UIActionSheetDelegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)gotoCustomer{
    //进入填写联系人信息页面
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CustomerViewController *customerViewController = [storyboard instantiateViewControllerWithIdentifier:@"customer"];
    [self.navigationController pushViewController:customerViewController
                                               animated:YES];
}


@end
