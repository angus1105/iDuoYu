//
//  ViewController.m
//  iDuoYu
//
//  Created by ChenAngus on 15/4/13.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import "ViewController.h"
@import CoreTelephony;
@interface ViewController ()

@end

@implementation ViewController

UIWindow *_window;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CTTelephonyNetworkInfo *netinfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [netinfo subscriberCellularProvider];
    NSString *carr = @"";
#if TARGET_IPHONE_SIMULATOR
    carr = @"Simulator";
    self.carrierLabel.text = @"Simulator";
#else
    if (carrier.carrierName == nil || carrier.carrierName.length <= 0)
        self.carrierLabel.text = @"N/A";
#endif
    self.carrierLabel.text = [carrier carrierName];
    
    NSLog(@"carrierName = %@", carr);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)alertViewTest:(id)sender {

}


@end
