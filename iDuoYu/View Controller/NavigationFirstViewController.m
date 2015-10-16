//
//  NavigationFirstViewController.m
//  iDuoYu
//
//  Created by ky01 on 15/4/16.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import "NavigationFirstViewController.h"

@interface NavigationFirstViewController ()

@end

@implementation NavigationFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Menu" bundle:nil];
        self.slidingViewController.underLeftViewController  = [storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    
//    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
