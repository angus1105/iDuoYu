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
#import "Context.h"
#import "LocationHelper.h"
#import "MainCell.h"
#import "EngineerCell.h"
#import <MJRefresh.h>
#import <MJRefresh/UIView+MJExtension.h>
#import "MainTableHeaderView.h"
#import "ChooseAlert.h"
#import "StepsSelectTableViewController.h"
#import "OrderService.h"
#import "Engineer.h"
#import "RequestParam.h"
#import <AFNetworking/UIKit+AFNetworking.h>
#import "Utils.h"
#import <GBDeviceInfo.h>

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
@property (nonatomic, strong) RequestParam *requestParam;
@end

@implementation MainViewController

- (RequestParam *)requestParam {
    if (_requestParam == nil) {
        _requestParam = [[RequestParam alloc] init];
    }
    
    return _requestParam;
}

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
    //footerSubView加到footer的最下面，防止覆盖掉button
    [self.tableView.footer insertSubview:footerSubView atIndex:0];
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
    [self.navigationController.view addGestureRecognizer:self.slidingViewController.panGesture];
    [[Context sharedContext] clearParamWithInquireType:@"All"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.view removeGestureRecognizer:self.slidingViewController.panGesture];
}

- (void)loadMoreData
{
    
    [OrderService getEngineerList:nil
                          success:^(Engineers *engineers) {
                              [self.mainItems addObjectsFromArray:engineers.Engineers];
                              // 刷新表格
                              [self.tableView reloadData];
                              [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.mainItems.count-1 inSection:0]
                                                    atScrollPosition:UITableViewScrollPositionBottom
                                                            animated:YES];
                              
                              // 拿到当前的上拉刷新控件，结束刷新状态
                              [self.tableView.footer endRefreshing];
                              //仅加载一次然后删除上拉刷新控件
                              self.tableView.footer.hidden = YES;
                          } failure:^(NSError *error) {
                              NSLog(@"error = %@", error);
                          }];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (self.tableView.bounds.size.height-tableView.tableHeaderView.bounds.size.height-44)/2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.mainItems.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        [[Context sharedContext] setBusinessType:BusinessTypeRepair];
    }else if (indexPath.row == 1) {
        [[Context sharedContext] setBusinessType:BusinessTypeSell];
    }
    
    if (indexPath.row < 2) {
        ChooseAlert *alert = [ChooseAlert newChooseAlert];
        alert.tag = [indexPath row];
        alert.chooseAlertDelegate = self;
        [alert show];
    }
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
    }else if ([[self.mainItems objectAtIndex:[indexPath row]] isKindOfClass:[Engineer class]]){
        static NSString *cellEngineer = @"engineerCell";
        EngineerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellEngineer
                                                             forIndexPath:indexPath];
        //TODO: 配置工程师cell各项属性
        
        Engineer *engineer = [self.mainItems objectAtIndex:[indexPath row]];
        [cell.avatarImageView setImageWithURL:[NSURL URLWithString:engineer.EngineerUrl]
                             placeholderImage:nil];
        cell.nameLabel.text = engineer.EngineerName;
        cell.descLabel.text = engineer.EngineerDescription;
        cell.achievementLabel.text = engineer.RepairAmount;
        return cell;
    }else {
        return nil;
    }
    
}


- (void)configRequestParam:(RequestParam *)rp forDevice:(NSInteger)isOtherDevice {
    if (isOtherDevice) {
        rp.InquireType = InquireTypeBrand;
    }else {
        rp.Brand = [[UIDevice currentDevice] model];
        rp.Rom = [Utils currentDeviceTotalDiskSpace];
        rp.Version = [[GBDeviceInfo deviceInfo] modelString];
    }
}

#pragma mark - Choose Alert Delegate
- (void)chooseAlert:(ChooseAlert *)alert didSelectAtIndex:(NSInteger)index {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    StepsSelectTableViewController *stepsViewController = [storyboard instantiateViewControllerWithIdentifier:@"stepsSelect"];
    RequestParam *requestParam = [[RequestParam alloc] init];
    requestParam.BusinessType = [[Context sharedContext] BusinessType];
    if (index == 0) {
        //使用本设备的参数，调用通过参数获取对应参数id的接口
        requestParam.Brand = alert.BrandStr;
        requestParam.Version = alert.VersionStr;
        requestParam.Rom = alert.RomStr;
        [OrderService getDeviceParamIds:requestParam
                              success:^(ResultRespond *resultRespond) {
                                  if ([resultRespond.Result isEqualToString:kSuccess]) {
                                      //请求成功将这三项参数名和id写入单例中
                                      [[Context sharedContext] setBrandId:resultRespond.BrandId];
                                      [[Context sharedContext] setBrand:requestParam.Brand];
                                      [[Context sharedContext] setVersionId:resultRespond.VersionId];
                                      [[Context sharedContext] setVersion:requestParam.Version];
                                      [[Context sharedContext] setRomId:resultRespond.RomId];
                                      [[Context sharedContext] setRom:requestParam.RomId];
                                      //根据不同的业务跳转到不同的选项页面
                                      if ([[[Context sharedContext] BusinessType] isEqualToString:BusinessTypeRepair]) {
                                          requestParam.InquireType = InquireTypeColor;
                                          requestParam.VersionId = [[Context sharedContext] VersionId];
                                      }else{
                                          requestParam.InquireType = InquireTypeBuyChannel;
                                          requestParam.BrandId = [[Context sharedContext] BrandId];
                                      }
                                      stepsViewController.requestParam = requestParam;
                                      [self.navigationController pushViewController:stepsViewController
                                                                           animated:YES];
                                  }else{
                                      //请求失败，提示用户获取失败
                                      msgBox(NSLocalizedString(@"请求失败，请手动进行选择！", @"请求失败，请手动进行选择！"));
                                  }
                              } failure:^(NSError *error) {
                                  //请求失败，提示用户获取失败
                                  msgBox(NSLocalizedString(@"请求失败，请手动进行选择！", @"请求失败，请手动进行选择！"));
                                  //跳转到获取设备品牌页面
                                  requestParam.InquireType = InquireTypeBrand;
                                  stepsViewController.requestParam = requestParam;
                                  [self.navigationController pushViewController:stepsViewController
                                                                       animated:YES];
                              }];
    }else {
        //跳转到获取设备品牌页面
        requestParam.InquireType = InquireTypeBrand;
        stepsViewController.requestParam = requestParam;
        [self.navigationController pushViewController:stepsViewController
                                             animated:YES];
    }
    
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
