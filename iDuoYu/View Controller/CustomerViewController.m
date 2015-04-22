//
//  CustomerViewController.m
//  iDuoYu
//
//  Created by ky01 on 15/4/22.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import "CustomerViewController.h"
#import "Common.h"
#import "Context.h"
#import "RequestParam.h"
#import "OrderService.h"
#import "Constants.h"

@interface CustomerViewController ()

@end

@implementation CustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorMake255(247, 247, 247, 1.0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)showServiceTypeAction:(id)sender{
    UIActionSheet *selectServiceTypeSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"请选择服务方式", @"请选则服务方式")
                                                                   delegate:self
                                                          cancelButtonTitle:NSLocalizedString(@"取消", @"取消")
                                                     destructiveButtonTitle:nil
                                                          otherButtonTitles:NSLocalizedString(@"上门", @"上门"),NSLocalizedString(@"邮寄", @"邮寄"),nil];
    selectServiceTypeSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [selectServiceTypeSheet showInView:[[UIApplication sharedApplication] keyWindow]];
}

#pragma mark UIActionSheetDelegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        self.serviceTypeTextField.text = NSLocalizedString(@"上门", @"上门");
    }else if (buttonIndex == 1){
        self.serviceTypeTextField.text = NSLocalizedString(@"邮寄", @"邮寄");
    }
}

- (IBAction)submitAction:(id)sender{
    if (isStringEmpty(self.customerNameTextField.text)) {
        msgBox(NSLocalizedString(@"联系人姓名不能为空", nil));
        [self.customerNameTextField becomeFirstResponder];
    }else if (isStringEmpty(self.customerMobileNumberTextField.text)) {
        msgBox(NSLocalizedString(@"联系人电话不能为空", nil));
        [self.customerMobileNumberTextField becomeFirstResponder];
    }else if (regularPhoneNumber(self.customerMobileNumberTextField.text)==nil) {
        msgBox(NSLocalizedString(@"联系人电话无效", nil));
        [self.customerMobileNumberTextField becomeFirstResponder];
    }else if (isStringEmpty(self.customerAddressTextField.text)){
        msgBox(NSLocalizedString(@"联系人地址不能为空", nil));
        [self.customerAddressTextField becomeFirstResponder];
    }else if (isStringEmpty(self.serviceTypeTextField.text)){
        msgBox(NSLocalizedString(@"服务方式不能为空", nil));
    }else{
        [[Context sharedContext] setCustomerName:self.customerNameTextField.text];
        [[Context sharedContext] setCustomerMobileNumber:self.customerMobileNumberTextField.text];
        [[Context sharedContext] setCustomerAddress:self.customerAddressTextField.text];
        [[Context sharedContext] setServiceType:self.serviceTypeTextField.text];
        RequestParam *requestParam = [[RequestParam alloc] init];
        requestParam.BusinessType = [[Context sharedContext] BusinessType];
        requestParam.BrandId = [[Context sharedContext] BrandId];
        requestParam.Brand = [[Context sharedContext] Brand];
        requestParam.VersionId = [[Context sharedContext] VersionId];
        requestParam.Version = [[Context sharedContext] Version];
        requestParam.ColorId = [[Context sharedContext] ColorId];
        requestParam.Color = [[Context sharedContext] Color];
        requestParam.FaultId = [[Context sharedContext] FaultId];
        requestParam.Fault = [[Context sharedContext] Fault];
        requestParam.FaultDetailId = [[Context sharedContext] FaultDetailId];
        requestParam.FaultDetail = [[Context sharedContext] FaultDetail];
        requestParam.SolutionId = [[Context sharedContext] SolutionId];
        requestParam.Solution = [[Context sharedContext] Solution];
        requestParam.Fee = [[Context sharedContext] Fee];
        requestParam.RomId = [[Context sharedContext] RomId];
        requestParam.Rom = [[Context sharedContext] Rom];
        requestParam.BuyChannelId = [[Context sharedContext] BuyChannelId];
        requestParam.BuyChannel = [[Context sharedContext] BuyChannel];
        requestParam.CustomerName = [[Context sharedContext] CustomerName];
        requestParam.CustomerMobileNumber = [[Context sharedContext] CustomerMobileNumber];
        requestParam.CustomerAddress = [[Context sharedContext] CustomerAddress];
        requestParam.ServiceType = [[Context sharedContext] ServiceType];
        [OrderService submitOrder:requestParam
                          success:^(ResultRespond *resultRespond) {
                              if ([resultRespond.Result isEqualToString:kSuccess]) {
                                  //请求成功将订单号写入单例中
                                  [[Context sharedContext] setOrderSN:resultRespond.OrderSN];
                                  //TODO:进入完成订单后的页面
                              }else{
                                  //请求失败，提示用户获取失败
                                  msgBox(NSLocalizedString(@"请求失败，请手动进行选择！", @"请求失败，请手动进行选择！"));
                              }
                        } failure:^(NSError *error) {
                            //请求失败，提示用户获取失败
                            msgBox(NSLocalizedString(@"请求失败，请稍后重试！", @"请求失败，请稍后重试！"));
                        }];
    }
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
