//
//  StepsSelectTableViewController.m
//  iDuoYu
//
//  Created by ChenAngus on 15/4/19.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import "StepsSelectTableViewController.h"
#import "CellWithImage.h"
#import "CellNormal.h"
#import "SolutionCell.h"
#import "OrderService.h"
#import "Context.h"
#import <AFNetworking/UIKit+AFNetworking.h>
#import "DeviceParam.h"
#import "Constants.h"

@interface StepsSelectTableViewController ()

@end

@implementation StepsSelectTableViewController
- (void)dealloc{
    //返回按钮所做的操作
    if ([[[Context sharedContext] BusinessType] isEqualToString:BusinessTypeRepair]) {
        if ([[[(StepsSelectTableViewController *)_parentController requestParam] InquireType] isEqualToString:InquireTypeBrand]) {
        }else if([[[(StepsSelectTableViewController *)_parentController requestParam] InquireType] isEqualToString:InquireTypeVersion]) {
            [[(StepsSelectTableViewController *)_parentController requestParam] setInquireType:InquireTypeBrand];
        }else if([[[(StepsSelectTableViewController *)_parentController requestParam] InquireType] isEqualToString:InquireTypeColor]) {
            [[(StepsSelectTableViewController *)_parentController requestParam] setInquireType:InquireTypeVersion];
        }else if([[[(StepsSelectTableViewController *)_parentController requestParam] InquireType] isEqualToString:InquireTypeFault]) {
            [[(StepsSelectTableViewController *)_parentController requestParam] setInquireType:InquireTypeColor];
        }else if([[[(StepsSelectTableViewController *)_parentController requestParam] InquireType] isEqualToString:InquireTypeFaultDetail]) {
            [[(StepsSelectTableViewController *)_parentController requestParam] setInquireType:InquireTypeFault];
        }else if([[[(StepsSelectTableViewController *)_parentController requestParam] InquireType] isEqualToString:InquireTypeSolution]) {
            [[(StepsSelectTableViewController *)_parentController requestParam] setInquireType:InquireTypeFaultDetail];
        }
    }else{
        if ([[[(StepsSelectTableViewController *)_parentController requestParam] InquireType] isEqualToString:InquireTypeBrand]) {
        }else if([[[(StepsSelectTableViewController *)_parentController requestParam] InquireType] isEqualToString:InquireTypeVersion]) {
            [[(StepsSelectTableViewController *)_parentController requestParam] setInquireType:InquireTypeBrand];
        }else if([[[(StepsSelectTableViewController *)_parentController requestParam] InquireType] isEqualToString:InquireTypeRom]) {
            [[(StepsSelectTableViewController *)_parentController requestParam] setInquireType:InquireTypeVersion];
        }else if([[[(StepsSelectTableViewController *)_parentController requestParam] InquireType] isEqualToString:InquireTypeBuyChannel]) {
            [[(StepsSelectTableViewController *)_parentController requestParam] setInquireType:InquireTypeRom];
        }else if([[[(StepsSelectTableViewController *)_parentController requestParam] InquireType] isEqualToString:InquireTypeColor]) {
            [[(StepsSelectTableViewController *)_parentController requestParam] setInquireType:InquireTypeBuyChannel];
        }else if([[[(StepsSelectTableViewController *)_parentController requestParam] InquireType] isEqualToString:InquireTypeSolution]) {
            [[(StepsSelectTableViewController *)_parentController requestParam] setInquireType:InquireTypeColor];
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *titleName = @"";
    if ([self.requestParam.InquireType isEqualToString:InquireTypeBrand]) {
        self.title = NSLocalizedString(@"类型", @"类型");
        titleName = NSLocalizedString(@"请选择您的类型", @"请选择您的类型");
    }else if([self.requestParam.InquireType isEqualToString:InquireTypeVersion]) {
        self.title = NSLocalizedString(@"机型", @"机型");
        titleName = NSLocalizedString(@"请选择您的机型", @"请选择您的机型");
    }else if([self.requestParam.InquireType isEqualToString:InquireTypeColor]) {
        self.title = NSLocalizedString(@"颜色", @"颜色");
        titleName = NSLocalizedString(@"请选择您的颜色", @"请选择您的颜色");
    }else if([self.requestParam.InquireType isEqualToString:InquireTypeFault]) {
        self.title = NSLocalizedString(@"故障", @"故障");
        titleName = NSLocalizedString(@"请选择您的故障", @"请选择您的故障");
    }else if([self.requestParam.InquireType isEqualToString:InquireTypeFaultDetail]) {
        self.title = NSLocalizedString(@"详细故障", @"详细故障");
        titleName = NSLocalizedString(@"请选择您的详细故障", @"请选择您的详细故障");
    }else if([self.requestParam.InquireType isEqualToString:InquireTypeSolution]) {
        if ([self.requestParam.BusinessType isEqualToString:BusinessTypeRepair]) {
            self.title = NSLocalizedString(@"维修方案", @"维修方案");
            titleName = NSLocalizedString(@"请选择维修方案", @"请选择维修方案");
        }else{
            self.title = NSLocalizedString(@"新旧程度", @"新旧程度");
            titleName = NSLocalizedString(@"请选择设备新旧程度", @"请选择设备新旧程度");
        }
    }else if([self.requestParam.InquireType isEqualToString:InquireTypeRom]) {
        self.title = NSLocalizedString(@"容量", @"容量");
        titleName = NSLocalizedString(@"请选择您的容量", @"请选择您的容量");
    }else if([self.requestParam.InquireType isEqualToString:InquireTypeBuyChannel]) {
        self.title = NSLocalizedString(@"购买渠道", @"购买渠道");
        titleName = NSLocalizedString(@"请选择您的购买渠道", @"请选择您的购买渠道");
    }
    self.subTitle.text = titleName;
    [OrderService getDeviceParamList:self.requestParam
                             success:^(DeviceParams *deviceParams) {
                                 self.deviceParams = deviceParams;
                                 [self.tableView reloadData];
                             } failure:^(NSError *error) {
                                 //请求失败，提示用户获取失败
                                 msgBox(NSLocalizedString(@"请求失败，请稍候重试！", @"请求失败，请稍候重试！"));
                                 [self.navigationController popViewControllerAnimated:YES];
                             }];
    UIView *footerSubView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    UIView *footerLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, footerSubView.frame.size.width, 1)];
    footerLineView.backgroundColor = UIColorMake255(227,227,227,1.0);
    [footerSubView addSubview:footerLineView];
    UIButton *goBackToHomeButtom = [UIButton buttonWithType:UIButtonTypeCustom];
    [goBackToHomeButtom setFrame:CGRectMake(20, 20, self.view.frame.size.width-40, 40)];
    [goBackToHomeButtom setBackgroundColor:UIColorMake255(0,158,186,1.0)];
    [goBackToHomeButtom setTitle:NSLocalizedString(@"返回到首页", @"返回到首页") forState:UIControlStateNormal];
    [goBackToHomeButtom addTarget:self action:@selector(gotoHome:) forControlEvents:UIControlEventTouchUpInside];
    goBackToHomeButtom.clipsToBounds = YES;
    [footerSubView addSubview:goBackToHomeButtom];
    //去掉多余空cell
    self.tableView.tableFooterView = footerSubView;
    [self.tableView registerNib:[UINib nibWithNibName:@"SolutionCell"
                                               bundle:nil]
         forCellReuseIdentifier:@"solutionCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)gotoHome:(id)sender {
    UIActionSheet *goBackToHomeSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"您确定返回首页？", @"您确定返回首页？")
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[self.deviceParams ReturnCount] integerValue];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DeviceParam *deviceParam = [self.deviceParams.DeviceParams objectAtIndex:indexPath.row];
    if ([self.requestParam.InquireType isEqualToString:InquireTypeBrand] ||
        [self.requestParam.InquireType isEqualToString:InquireTypeFault]) {
        static NSString *reuseIdentifier = @"cellWithImage";
        CellWithImage *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier
                                                              forIndexPath:indexPath];
        
        cell.titleLabel.text = deviceParam.ParamName;
        [cell.leftImageView setImageWithURL:[NSURL URLWithString:deviceParam.ParamUrl]
                           placeholderImage:[UIImage imageNamed:@"iconiPhone.png"]];
        
        return cell;
    }else if([self.requestParam.InquireType isEqualToString:InquireTypeVersion] ||
             [self.requestParam.InquireType isEqualToString:InquireTypeColor]||
             [self.requestParam.InquireType isEqualToString:InquireTypeFaultDetail]||
             [self.requestParam.InquireType isEqualToString:InquireTypeRom]||
             [self.requestParam.InquireType isEqualToString:InquireTypeBuyChannel]) {
        static NSString *reuseIdentifier = @"cellNormal";
        CellNormal *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier
                                                              forIndexPath:indexPath];
        cell.titleLabel.text = deviceParam.ParamName;
        
        return cell;
    }else if([self.requestParam.InquireType isEqualToString:InquireTypeSolution]) {
        //解决方案页面
        static NSString *reuseIdentifier = @"solutionCell";
        SolutionCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (cell == nil) {
            cell = [[SolutionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        }
        cell.titleLabel.text = deviceParam.ParamName;
        [cell.leftImageView setImageWithURL:[NSURL URLWithString:deviceParam.ParamUrl]
                           placeholderImage:[UIImage imageNamed:@"iconiPhone.png"]];
        cell.descriptionView.text = deviceParam.Description;
        cell.selectButton.backgroundColor = UIColorMake255(120,200,110,1.0);
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //维修流程：1选择类型（有图） -> 2选择机型 ->  3选择颜色 -> 4选择故障（有图） -> 5选择详细故障 -> 6选择方案（有图） -> 7接受服务 -> 8填写地址 -> 9完成订单显示详细页面。
    //换钱流程：1选择类型（有图） -> 2选择机型 -> 3选择容量 -> 4选择渠道 -> 5选择颜色 -> 6选择方案（有图） -> 7接受服务 -> 8填写地址 -> 9完成订单显示详细页面。
    DeviceParam *deviceParam = [self.deviceParams.DeviceParams objectAtIndex:indexPath.row];
    if ([[[Context sharedContext] BusinessType] isEqualToString:BusinessTypeRepair]) {
        if ([self.requestParam.InquireType isEqualToString:InquireTypeBrand]) {
            [[Context sharedContext] setBrandId:deviceParam.ParamId];
            [[Context sharedContext] setBrand:deviceParam.ParamName];
            self.requestParam.InquireType = InquireTypeVersion;
            self.requestParam.BrandId = deviceParam.ParamId;
        }else if([self.requestParam.InquireType isEqualToString:InquireTypeVersion]) {
            [[Context sharedContext] setVersionId:deviceParam.ParamId];
            [[Context sharedContext] setVersion:deviceParam.ParamName];
            self.requestParam.InquireType = InquireTypeColor;
            self.requestParam.VersionId = deviceParam.ParamId;
        }else if([self.requestParam.InquireType isEqualToString:InquireTypeColor]) {
            [[Context sharedContext] setColorId:deviceParam.ParamId];
            [[Context sharedContext] setColor:deviceParam.ParamName];
            self.requestParam.InquireType = InquireTypeFault;
        }else if([self.requestParam.InquireType isEqualToString:InquireTypeFault]) {
            [[Context sharedContext] setFaultId:deviceParam.ParamId];
            [[Context sharedContext] setFault:deviceParam.ParamName];
            self.requestParam.InquireType = InquireTypeFaultDetail;
            self.requestParam.FaultId = deviceParam.ParamId;
        }else if([self.requestParam.InquireType isEqualToString:InquireTypeFaultDetail]) {
            [[Context sharedContext] setFaultDetailId:deviceParam.ParamId];
            [[Context sharedContext] setFaultDetail:deviceParam.ParamName];
            self.requestParam.InquireType = InquireTypeSolution;
            self.requestParam.BrandId = [[Context sharedContext] BrandId];
            self.requestParam.VersionId = [[Context sharedContext] VersionId];
            self.requestParam.ColorId = [[Context sharedContext] ColorId];
            self.requestParam.FaultId = [[Context sharedContext] FaultId];
            self.requestParam.FaultDetailId = [[Context sharedContext] FaultDetailId];
        }else if([self.requestParam.InquireType isEqualToString:InquireTypeSolution]) {
            [[Context sharedContext] setSolutionId:deviceParam.ParamId];
            [[Context sharedContext] setSolution:deviceParam.ParamName];
            [[Context sharedContext] setSolutionURL:deviceParam.ParamUrl];
            [[Context sharedContext] setSolutionDescription:deviceParam.description];
            [[Context sharedContext] setFee:deviceParam.Fee];
        }
    }else{
        if ([self.requestParam.InquireType isEqualToString:InquireTypeBrand]) {
            [[Context sharedContext] setBrandId:deviceParam.ParamId];
            [[Context sharedContext] setBrand:deviceParam.ParamName];
            self.requestParam.InquireType = InquireTypeVersion;
            self.requestParam.BrandId = deviceParam.ParamId;
        }else if([self.requestParam.InquireType isEqualToString:InquireTypeVersion]) {
            [[Context sharedContext] setVersionId:deviceParam.ParamId];
            [[Context sharedContext] setVersion:deviceParam.ParamName];
            self.requestParam.InquireType = InquireTypeRom;
            self.requestParam.VersionId = deviceParam.ParamId;
        }else if([self.requestParam.InquireType isEqualToString:InquireTypeRom]) {
            [[Context sharedContext] setRomId:deviceParam.ParamId];
            [[Context sharedContext] setRom:deviceParam.ParamName];
            self.requestParam.InquireType = InquireTypeBuyChannel;
            self.requestParam.BrandId = [[Context sharedContext] BrandId];
        }else if([self.requestParam.InquireType isEqualToString:InquireTypeBuyChannel]) {
            [[Context sharedContext] setBuyChannelId:deviceParam.ParamId];
            [[Context sharedContext] setBuyChannel:deviceParam.ParamName];
            self.requestParam.InquireType = InquireTypeColor;
            self.requestParam.VersionId = [[Context sharedContext] VersionId];
        }else if([self.requestParam.InquireType isEqualToString:InquireTypeColor]) {
            [[Context sharedContext] setColorId:deviceParam.ParamId];
            [[Context sharedContext] setColor:deviceParam.ParamName];
            self.requestParam.InquireType = InquireTypeSolution;
            self.requestParam.BrandId = [[Context sharedContext] BrandId];
            self.requestParam.VersionId = [[Context sharedContext] VersionId];
            self.requestParam.ColorId = [[Context sharedContext] ColorId];
            self.requestParam.RomId = [[Context sharedContext] RomId];
            self.requestParam.BuyChannelId = [[Context sharedContext] BuyChannelId];
        }else if([self.requestParam.InquireType isEqualToString:InquireTypeSolution]) {
            self.requestParam.InquireType = InquireTypeFee;
            [[Context sharedContext] setSolutionId:deviceParam.ParamId];
            [[Context sharedContext] setSolution:deviceParam.ParamName];
            [[Context sharedContext] setSolutionURL:deviceParam.ParamUrl];
            [[Context sharedContext] setSolutionDescription:deviceParam.description];
            [[Context sharedContext] setFee:deviceParam.Fee];
        }
    }
    if ([self.requestParam.InquireType isEqualToString:InquireTypeFee]) {
        //TODO 跳转到显示费用页面
    }else{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        StepsSelectTableViewController *stepsViewController = [storyboard instantiateViewControllerWithIdentifier:@"stepsSelect"];
        stepsViewController.requestParam = self.requestParam;
        stepsViewController.parentController = self;
        [self.navigationController pushViewController:stepsViewController
                                             animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.requestParam.InquireType isEqualToString:InquireTypeSolution]) {
        return 200;
    }else{
        return 100;
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
