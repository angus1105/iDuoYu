//
//  MenuViewController.m
//  iDuoYu
//
//  Created by ky01 on 15/4/15.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import "MenuViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "MenuCell.h"
#import "Constants.h"

@interface MenuViewController ()
@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, strong) NSArray *menuSubItems;
@property (nonatomic, strong) NSArray *menuImageItems;
@end

@implementation MenuViewController

- (void)awakeFromNib
{
    self.menuItems = [NSArray arrayWithObjects:NSLocalizedString(@"服务流程", @"服务流程"), NSLocalizedString(@"F.A.Q", @"F.A.Q"), NSLocalizedString(@"工程师招募", @"工程师招募"), NSLocalizedString(@"订单查询与邮寄", @"订单查询与邮寄"), nil];
    self.menuSubItems = [NSArray arrayWithObjects:NSLocalizedString(@"Step by Step Explained", @"Step by Step Explained"), NSLocalizedString(@"Common Questions", @"Common Questions"), NSLocalizedString(@"Engineer Recruitment", @"Engineer Recruitment"), NSLocalizedString(@"Order inquiry", @"Order inquiry"), nil];
    self.menuImageItems = [NSArray arrayWithObjects:@"lanuchLogo.png", @"lanuchLogo.png", @"lanuchLogo.png", @"lanuchLogo.png", nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat witch = self.view.frame.size.width*7/8;
    
    [self.slidingViewController setAnchorRightRevealAmount:witch];
    self.slidingViewController.underLeftWidthLayout = ECFullWidth;
    self.view.backgroundColor = UIColorMake255(38, 107, 161, 1.0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"MenuItemCell";
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.titleLabel.text = [self.menuItems objectAtIndex:indexPath.row];
    cell.subTitleLabel.text = [self.menuSubItems objectAtIndex:indexPath.row];
    cell.leftImageView.image = [UIImage imageNamed:[self.menuImageItems objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = (int)indexPath.row;
    UIStoryboard *storyboard;
    UIViewController *newTopViewController;
    switch (row) {
        case 0:
            storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            newTopViewController = [storyboard instantiateViewControllerWithIdentifier:@"NavFirst"];
            break;
        default:
            break;
    }
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newTopViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
