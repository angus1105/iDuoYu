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

@interface TopViewController ()
@property (strong, nonatomic) IBOutlet YFGIFImageView *gifImageView;
@property (strong, nonatomic) IBOutlet UIView *loadMoreBackgroundView;
@property (strong, nonatomic) RequestParam *requestParam;

@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSData *gifData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"banner" ofType:@"gif"]];
    
    self.gifImageView.gifData = gifData;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.view addGestureRecognizer:self.slidingViewController.panGesture];
    [self.gifImageView startGIF];
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

- (IBAction)buttonTouchDown:(id)sender {
    UIButton *button = (UIButton *)sender;
    [button setBackgroundColor:[UIColor lightGrayColor]];
}

- (IBAction)buttonTouchUpInside:(id)sender {
    UIButton *button = (UIButton *)sender;
    [button setBackgroundColor:[UIColor whiteColor]];
    
    ChooseAlert *alert = [ChooseAlert newChooseAlert];
    alert.tag = button.tag;
    alert.chooseAlertDelegate = self;
    [alert show];
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

- (IBAction)buttonTouchCancel:(id)sender {
    UIButton *button = (UIButton *)sender;
    [button setBackgroundColor:[UIColor whiteColor]];
}

- (IBAction)engineerNearByTouchDown:(id)sender {
    self.loadMoreBackgroundView.backgroundColor = [UIColor lightGrayColor];
}

- (IBAction)engineerNearByTouchUpInside:(id)sender {
    [self.loadMoreBackgroundView setBackgroundColor: UIColorMake255(230, 230, 230, 1.f)];
}

- (IBAction)engineerNearByTouchCancel:(id)sender {
    [self.loadMoreBackgroundView setBackgroundColor: UIColorMake255(230, 230, 230, 1.f)];
}

@end
