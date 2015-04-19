//
//  MainViewController.m
//  iDuoYu
//
//  Created by ky01 on 15/4/15.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import "MainViewController.h"
#import "YFGIFImageView.h"
#import "UIImageView+PlayGIF.h"
#import "Constants.h"
#import "LocationHelper.h"
#import "MainCell.h"
#import "EngineerCell.h"
#import <MJRefresh.h>
#import <MJRefresh/UIView+MJExtension.h>
#import "MainTableHeaderView.h"
#import "ChooseAlert.h"
#import "StepsSelectTableViewController.h"

/**
 `MainItem` 首页主要业务的内部类bean
 */
@interface MainItem : NSObject
@property (nonatomic, strong) NSString *itemTitle;
@property (nonatomic, strong) NSString *itemImageTitle;
+ (instancetype)itemWithTitle:(NSString *)title andImage:(NSString *)imageTitle;
@end

@implementation MainItem

+ (instancetype)itemWithTitle:(NSString *)title andImage:(NSString *)imageTitle {
    MainItem *item = [MainItem new];
    if (item) {
        item.itemTitle = title;
        item.itemImageTitle = imageTitle;
    }
    
    return item;
}

@end


@interface MainViewController () <ChooseAlertProtocol>
@property (nonatomic, strong) NSMutableArray *mainItems;
@end

@implementation MainViewController

- (void)awakeFromNib
{
    MainItem *itemRepair = [MainItem itemWithTitle:NSLocalizedString(@"设备维修", @"Repair")
                                          andImage:@"iconRepair.png"];
    MainItem *itemSell = [MainItem itemWithTitle:NSLocalizedString(@"设备换钱", @"Sell")
                                        andImage:@"iconSell.png"];
    self.mainItems = [NSMutableArray arrayWithObjects:itemRepair, itemSell, nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat gifHeight = self.view.frame.size.width*215/320;
    MainTableHeaderView *headerView = [MainTableHeaderView headerViewWithGIF:@"banner.gif"];
    [headerView.gifImageView startGIF];
    headerView.bounds = CGRectMake(0, 0, self.view.bounds.size.width, gifHeight);
    self.tableView.tableHeaderView = headerView;
    NSLog(@"corner = %f", headerView.locationBackgroundView.layer.cornerRadius);
    __weak typeof(self) weakSelf = self;
    
    //为tableView添加上拉加载功能
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
    [self.tableView.footer setTitle:NSLocalizedString(@"附近的工程师", @"附近的工程师") forState:MJRefreshFooterStateIdle];
    [self.tableView.footer setBackgroundColor:[UIColor clearColor]];
    
    //底部蓝条
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"MainFooterSubView"
                                                  owner:nil
                                                options:nil];
    UIView *footerSubView = [nibs objectAtIndex:0];
    footerSubView.frame = CGRectMake(5, 0, self.tableView.footer.frame.size.width-10, self.tableView.footer.frame.size.height);
    [self.tableView.footer addSubview:footerSubView];
    //去掉多余空cell
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [LocationHelper locateCurrentCity:^(NSDictionary *addressInfo, NSError *error) {
        if (error) {
            headerView.locationLabel.text = NSLocalizedString(@"北京", @"北京");
        }else {
            headerView.locationLabel.text = [addressInfo objectForKey:@"State"];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (void)loadMoreData
{
    // 1.添加假数据
//    for (int i = 0; i<5; i++) {
//        [self.data addObject:MJRandomData];
//    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // 拿到当前的上拉刷新控件，结束刷新状态
        [self.tableView.footer endRefreshing];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.mainItems.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ChooseAlert *alert = [ChooseAlert newChooseAlert];
    alert.tag = [indexPath row];
    alert.chooseAlertDelegate = self;
    [alert show];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.mainItems objectAtIndex:[indexPath row]] isKindOfClass:[MainItem class]]) {
        static NSString *cellIdentifier = @"MainCell";
        MainCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                         forIndexPath:indexPath];
        MainItem *item = [self.mainItems objectAtIndex:[indexPath row]];
        cell.mainTitle.text = item.itemTitle;
        cell.leftImageView.image = [UIImage imageNamed:item.itemImageTitle];
        return cell;
    }else {
        static NSString *cellEngineer = @"engineerCell";
        EngineerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellEngineer
                                                             forIndexPath:indexPath];
        //TODO: 配置工程师cell各项属性
        
        return cell;
    }
    
}

#pragma mark - Choose Alert Delegate
- (void)chooseAlert:(ChooseAlert *)alert didSelectAtIndex:(NSInteger)index {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    StepsSelectTableViewController *stepsViewController = [storyboard instantiateViewControllerWithIdentifier:@"stepsSelect"];
    
    if (alert.tag == 0) {
        //配置stepsViewController
        
    }else {
        
    }
    
    [self.navigationController pushViewController:stepsViewController
                                         animated:YES];
}

- (void)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
