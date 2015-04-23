//
//  TopViewController.m
//  iDuoYu
//
//  Created by ChenAngus on 15/4/20.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import "TopViewController.h"
#import "Constants.h"
#import <YFGIFImageView.h>
#import "RequestParam.h"
#import "StepsSelectTableViewController.h"
#import "OrderService.h"
#import "LocationHelper.h"
#import "Engineer.h"
#import "EngineerCell.h"
#import <AFNetworking/UIKit+AFNetworking.h>
#import "LoadMoreViewInTopVC.h"

@interface TopViewController ()
@property (strong, nonatomic) IBOutlet YFGIFImageView *gifImageView;
@property (strong, nonatomic) RequestParam *requestParam;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *engineerAmountLabel;
@property (strong, nonatomic) IBOutlet UIView *locationBackgroundView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *engineerLists;

@property (strong, nonatomic) LoadMoreViewInTopVC *loadMoreView;
@end

@implementation TopViewController
BOOL engineerListIsShown;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.locationBackgroundView.layer.cornerRadius = 10;
    NSData *gifData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"banner" ofType:@"gif"]];
    
    self.gifImageView.gifData = gifData;
    
    [LocationHelper locateCurrentCity:^(NSDictionary *addressInfo, NSError *error) {
        if (error) {
            self.locationLabel.text = NSLocalizedString(@"北京", @"北京");
        }else {
            self.locationLabel.text = [addressInfo objectForKey:@"State"];
            //获取此城市中工程师总数
            [self.engineerLists removeAllObjects];
            RequestParam *requestParam = [RequestParam new];
            requestParam.City = [addressInfo objectForKey:@"State"];
            [OrderService getEngineerList:requestParam
                                  success:^(Engineers *engineers) {
                                      [self.engineerLists addObjectsFromArray:engineers.Engineers];
                                  } failure:^(NSError *error) {
                                      NSLog(@"error = %@", error);
                                  }];
        }
    }];
    
    float loadMoreY = 20+44+self.gifImageView.bounds.size.height;
    float tableViewY = loadMoreY+44;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-tableViewY)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.allowsSelection = NO;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerNib:[UINib nibWithNibName:@"EngineerCell"
                                               bundle:nil]
         forCellReuseIdentifier:@"engineerCell"];
    [self.view addSubview:_tableView];
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicatorView.hidesWhenStopped = YES;
    [self.loadMoreBackgroundView addSubview:self.activityIndicatorView];
    self.activityIndicatorView.center = CGPointMake(_loadMoreBackgroundView.frame.size.width/3,
                                                    _loadMoreBackgroundView.frame.size.height/2);
    
    //消息监听，push到OrderSuccessViewController页面
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"pushToOrderSuccessViewController"
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pushToOrderSuccessViewController:)
                                                 name:@"pushToOrderSuccessViewController"
                                               object:nil];
}

- (void)dealloc{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"pushToOrderSuccessViewController"
                                                  object:nil];
}

- (void)pushToOrderSuccessViewController:(id)sender{
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.view addGestureRecognizer:self.slidingViewController.panGesture];
    [self.gifImageView startGIF];
    self.loadMoreView.frame = CGRectMake(0,
                                         self.view.frame.size.height-44,
                                         self.view.frame.size.width,
                                         44);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.view removeGestureRecognizer:self.slidingViewController.panGesture];
    [self.gifImageView stopGIF];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}


- (IBAction)buttonTouchUpInside:(id)sender {
    UIButton *button = (UIButton *)sender;
    [button setBackgroundColor:[UIColor whiteColor]];
    
    if (button.tag == 0) {
        [[Context sharedContext] setBusinessType:BusinessTypeRepair];
    }else if (button.tag == 1) {
        [[Context sharedContext] setBusinessType:BusinessTypeSell];
    }
    
    ChooseAlert *alert = [ChooseAlert newChooseAlert];
    alert.tag = button.tag;
    alert.chooseAlertDelegate = self;
    [alert show];
}

- (NSMutableArray *)engineerLists {
    if (_engineerLists == nil) {
        _engineerLists = [NSMutableArray array];
    }
    
    return _engineerLists;
}

- (void)showEngineerList {
    [self.loadMoreView.activityIndicator stopAnimating];
    // 刷新表格
    [self.tableView reloadData];
    engineerListIsShown = YES;
    
    float loadMoreY = 20+44+self.gifImageView.bounds.size.height;
    float tableViewY = loadMoreY+44;
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(M_PI);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.loadMoreView.frame = CGRectMake(0,
                                                                        loadMoreY,
                                                                        self.view.frame.size.width,
                                                                        44);
                         self.tableView.frame = CGRectMake(0,
                                                           tableViewY,
                                                           self.view.frame.size.width,
                                                           self.view.frame.size.height-tableViewY);
                         self.loadMoreView.rightIndicatorImageView.transform = endAngle;
                     }];
    
}

- (void)hideEngineerList {
    [self.loadMoreView.activityIndicator  stopAnimating];
    engineerListIsShown = NO;
    float loadMoreY = 20+44+self.gifImageView.bounds.size.height;
    float tableViewY = loadMoreY+44;
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(-M_PI*2);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.loadMoreView.frame = CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44);
                         self.tableView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-tableViewY);
                         self.loadMoreView.rightIndicatorImageView.transform = endAngle;
                     }];
}

- (IBAction)engineerNearByTouchUpInside:(id)sender {
    [self.loadMoreView setBackgroundColor: UIColorMake255(230, 230, 230, 1.f)];
    
    if (engineerListIsShown) {
        [self hideEngineerList];
    }else {
        
        if (self.engineerLists.count > 0) {
            [self showEngineerList];
            return;
        }
        
        [self.loadMoreView.activityIndicator  startAnimating];
        [self.engineerLists removeAllObjects];
        
        RequestParam *requestParam = [RequestParam new];
        requestParam.City = self.locationLabel.text;
        [OrderService getEngineerList:requestParam
                              success:^(Engineers *engineers) {
                                  [self.engineerLists addObjectsFromArray:engineers.Engineers];
                                  [self showEngineerList];
                              } failure:^(NSError *error) {
                                  NSLog(@"error = %@", error);
                              }];
    }
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.engineerLists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Engineer *engineer = [self.engineerLists objectAtIndex:indexPath.row];
    
    static NSString *reuseIdentifier = @"engineerCell";
    EngineerCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier
                                                         forIndexPath:indexPath];
    [cell.avatarImageView setImageWithURL:[NSURL URLWithString:engineer.EngineerUrl]
                         placeholderImage:nil];
    cell.nameLabel.text = engineer.EngineerName;
    cell.achievementLabel.text = engineer.RepairAmount;
    cell.descLabel.text = engineer.EngineerDescription;
    return cell;
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
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

#pragma mark -- UIButton Touch Event
- (IBAction)buttonTouchDown:(id)sender {
    UIButton *button = (UIButton *)sender;
    [button setBackgroundColor:[UIColor lightGrayColor]];
}

- (IBAction)buttonTouchCancel:(id)sender {
    UIButton *button = (UIButton *)sender;
    [button setBackgroundColor:[UIColor whiteColor]];
}

@end
