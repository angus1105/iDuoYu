//
//  WebRelatedViewController.m
//  iDuoYu
//
//  Created by ChenAngus on 15/4/23.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import "WebRelatedViewController.h"
#import "ECSlidingViewController.h"

@interface WebRelatedViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebRelatedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSData *htmlData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"faq" ofType:@"html"]];
    NSString *htmlString = [[NSString alloc] initWithData:htmlData
                                                 encoding:NSUTF8StringEncoding];
    [self.webView loadHTMLString:htmlString
                         baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"faq" ofType:@"html"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.view removeGestureRecognizer:self.slidingViewController.panGesture];
}

- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}


@end
