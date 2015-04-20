//
//  ViewController.m
//  iDuoYu
//
//  Created by ChenAngus on 15/4/13.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import "ViewController.h"
#import "ChooseAlert.h"
#import <GBDeviceInfo.h>

@import CoreTelephony;
@interface ViewController  ()

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)alertViewTest:(id)sender {
//    ChooseAlert *alertView = [ChooseAlert newChooseAlert];
//    alertView.modelDescriptionLabel.text = [NSString stringWithFormat:@"%@ - %@", [[GBDeviceInfo deviceInfo] modelString], [ViewController carrierName]];
//    alertView.ramLabel.text = [NSString stringWithFormat:@"%3.0f GB", [[ViewController totalDiskSpace] floatValue]/1000/1000/1000];
//    alertView.chooseAlertDelegate = self;
//    [alertView show];
    
}

- (void)chooseAlert:(ChooseAlert *)alert didSelectAtIndex:(NSInteger)index {
    NSLog(@"index = %ld", (long)index);
    [alert hide];
}

@end
