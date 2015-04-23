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
#import "WebRelatedViewController.h"

@interface MenuViewController ()
@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, strong) NSArray *menuSubItems;
@property (nonatomic, strong) NSArray *menuImageItems;
@property (nonatomic, strong) NSMutableDictionary *viewControllersForIndexPath;
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
    self.viewControllersForIndexPath = [NSMutableDictionary dictionary];
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
    UIViewController *newTopViewController = [self.viewControllersForIndexPath objectForKey:indexPath];
    
    if (newTopViewController == nil) {
        switch (row) {
            case 0:
                //业务流程
                storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                newTopViewController = [storyboard instantiateViewControllerWithIdentifier:@"NavFirst"];
                break;
                
            case 1:{
                //F.A.Q
                storyboard = [UIStoryboard storyboardWithName:@"WebRelated" bundle:nil];
                newTopViewController = [storyboard instantiateInitialViewController];
                WebRelatedViewController *viewController = [[(UINavigationController *)newTopViewController viewControllers] firstObject];
                viewController.title = NSLocalizedString(@"F.A.Q", @"F.A.Q");
                //            [viewController setWebPageFileName:@"faq" ofType:@"html"];
                [viewController setWebPageURL:[NSURL URLWithString:@"http://mp.weixin.qq.com/s?__biz=MjM5ODQ2MDIyMA==&mid=205203051&idx=1&sn=6af0098e16f8c0b8b567bd44ddeeae32#rd"]];
            }
                break;
            case 2:{
                //招募
                storyboard = [UIStoryboard storyboardWithName:@"WebRelated" bundle:nil];
                newTopViewController = [storyboard instantiateInitialViewController];
                WebRelatedViewController *viewController = [[(UINavigationController *)newTopViewController viewControllers] firstObject];
                viewController.title = NSLocalizedString(@"工程师招募", @"工程师招募");
                [viewController setWebPageFileName:@"faq" ofType:@"html"];
            }
                break;
                
            case 3:
                //订单查询与邮寄
                storyboard = [UIStoryboard storyboardWithName:@"OrderSearch" bundle:nil];
                newTopViewController = [storyboard instantiateInitialViewController];
            default:
                break;
        }
        
        [self.viewControllersForIndexPath setObject:newTopViewController
                                             forKey:indexPath];
    }
    
//    if (row == 0 || row == 3) {
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            CGRect frame = self.slidingViewController.topViewController.view.frame;
            self.slidingViewController.topViewController = newTopViewController;
            self.slidingViewController.topViewController.view.frame = frame;
            [self.slidingViewController resetTopView];
        }];
//    }
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
