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
    
    switch (alert.tag) {
        case 0:
            //Repair
            self.requestParam.BusinessType = BusinessTypeRepair;
            if (index == 0) {
                //选取本机
            }else {
                //选择其他机型
            }
            break;
            
        case 1:
            //Sell
            self.requestParam.BusinessType = BusinessTypeSell;
            if (index == 0) {
                //选取本机
            }else {
                //选择其他机型
            }
        default:
            break;
    }
    
    [self.navigationController pushViewController:stepsViewController
                                         animated:YES];
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
