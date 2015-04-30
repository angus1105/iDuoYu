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
    self.menuItems = [NSArray arrayWithObjects:NSLocalizedString(@"首页", @"首页"), NSLocalizedString(@"服务流程", @"服务流程"), NSLocalizedString(@"常见问题", @"常见问题"), NSLocalizedString(@"服务支持", @"服务支持"), NSLocalizedString(@"服务条款", @"服务条款"), NSLocalizedString(@"订单查询", @"订单查询"), nil];
    self.menuSubItems = [NSArray arrayWithObjects:NSLocalizedString(@"Home", @"Home"), NSLocalizedString(@"Step by Step Explained", @"Step by Step Explained"), NSLocalizedString(@"Common Questions", @"Common Questions"),NSLocalizedString(@"Iduoyu Support", @"Iduoyu Support"),NSLocalizedString(@"Terms of Service", @"Terms of Service"),  NSLocalizedString(@"Order Inquiry", @"Order Inquiry"), nil];
    self.menuImageItems = [NSArray arrayWithObjects:@"lanuchLogo.png", @"lanuchLogo.png", @"lanuchLogo.png", @"lanuchLogo.png", @"lanuchLogo.png", @"lanuchLogo.png", nil];
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
    cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, kScreenWitch, cell.frame.size.height);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight = (kScreenHeight-kStatusBarHeight-kNavigationBar-20)/6;
    return cellHeight>80?80:cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = (int)indexPath.row;
    UIStoryboard *storyboard;
    UIViewController *newTopViewController = [self.viewControllersForIndexPath objectForKey:indexPath];
    
    if (newTopViewController == nil) {
        switch (row) {
            case 0:
                //首页
                storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                newTopViewController = [storyboard instantiateViewControllerWithIdentifier:@"NavFirst"];
                break;
            case 1:{
                //业务流程
                storyboard = [UIStoryboard storyboardWithName:@"WebRelated" bundle:nil];
                newTopViewController = [storyboard instantiateInitialViewController];
                WebRelatedViewController *viewController = [[(UINavigationController *)newTopViewController viewControllers] firstObject];
                viewController.title = [self.menuItems objectAtIndex:indexPath.row];
                //            [viewController setWebPageFileName:@"faq" ofType:@"html"];
                [viewController setWebPageURL:[NSURL URLWithString:@"http://mp.weixin.qq.com/s?__biz=MjM5ODQ2MDIyMA==&mid=205203051&idx=1&sn=6af0098e16f8c0b8b567bd44ddeeae32#rd"]];
            }
                break;
            case 2:{
                //常见问题
                storyboard = [UIStoryboard storyboardWithName:@"WebRelated" bundle:nil];
                newTopViewController = [storyboard instantiateInitialViewController];
                WebRelatedViewController *viewController = [[(UINavigationController *)newTopViewController viewControllers] firstObject];
                viewController.title = [self.menuItems objectAtIndex:indexPath.row];
                //            [viewController setWebPageFileName:@"faq" ofType:@"html"];
                [viewController setWebPageURL:[NSURL URLWithString:@"http://mp.weixin.qq.com/s?__biz=MjM5ODQ2MDIyMA==&mid=205203051&idx=1&sn=6af0098e16f8c0b8b567bd44ddeeae32#rd"]];
            }
                break;
            case 3:{
                //服务支持
                storyboard = [UIStoryboard storyboardWithName:@"WebRelated" bundle:nil];
                newTopViewController = [storyboard instantiateInitialViewController];
                WebRelatedViewController *viewController = [[(UINavigationController *)newTopViewController viewControllers] firstObject];
                viewController.title = [self.menuItems objectAtIndex:indexPath.row];
                [viewController setWebPageFileName:@"faq" ofType:@"html"];
            }
                break;
            case 4:{
                //服务条款
                storyboard = [UIStoryboard storyboardWithName:@"WebRelated" bundle:nil];
                newTopViewController = [storyboard instantiateInitialViewController];
                WebRelatedViewController *viewController = [[(UINavigationController *)newTopViewController viewControllers] firstObject];
                viewController.title = [self.menuItems objectAtIndex:indexPath.row];
                [viewController setWebPageFileName:@"faq" ofType:@"html"];
            }
                break;
            case 5:
                //订单查询
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
