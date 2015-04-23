//
//  CustomerViewController.h
//  iDuoYu
//
//  Created by ky01 on 15/4/22.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerViewController : UIViewController<UIActionSheetDelegate, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *customerNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *customerMobileNumberTextField;
@property (strong, nonatomic) IBOutlet UITextField *customerAddressTextField;
@property (strong, nonatomic) IBOutlet UITextField *serviceTypeTextField;
@property (strong, nonatomic) IBOutlet UIButton *serviceTypeButton;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;

- (IBAction)showServiceTypeAction:(id)sender;

- (IBAction)submitAction:(id)sender;

@end
