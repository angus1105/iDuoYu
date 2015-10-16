//
//  CustomerViewController.h
//  iDuoYu
//
//  Created by ky01 on 15/4/22.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerViewController : UITableViewController<UIActionSheetDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITextField *customerNameTextField;
@property (strong, nonatomic) UITextField *customerMobileNumberTextField;
@property (strong, nonatomic) UITextField *customerAddressTextField;
@property (strong, nonatomic) UITextField *serviceTypeTextField;

- (IBAction)showServiceTypeAction:(id)sender;

- (IBAction)submitAction:(id)sender;

@end
