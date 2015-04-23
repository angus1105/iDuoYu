//
//  WebRelatedViewController.m
//  iDuoYu
//
//  Created by ChenAngus on 15/4/23.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import "WebRelatedViewController.h"
#import "ECSlidingViewController.h"
#import <AFNetworking/UIKit+AFNetworking.h>

NSString *const WebRelatedStoryBoardID = @"WebRelated";

@interface WebRelatedViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSURL *pageURL;
@property (strong, nonatomic) IBOutlet UIProgressView *progressView;
@end

@implementation WebRelatedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.progressView.hidden = YES;
    if (self.pageURL) {
//        [self.webView loadRequest:[NSURLRequest requestWithURL:self.pageURL]];
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.pageURL]
                         progress:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
                             self.progressView.hidden = NO;
                             self.progressView.progress = (float)totalBytesWritten/(float)totalBytesExpectedToWrite;
                         } success:^NSString *(NSHTTPURLResponse *response, NSString *HTML) {
                             self.progressView.hidden = YES;
                             return HTML;
                         } failure:^(NSError *error) {
                             self.progressView.hidden = YES;
                             NSLog(@"error = %@", error);
                             //load 404
                         }];
    }
}

- (void)setWebPageURL:(NSURL *)url {
    self.pageURL = url;
}

- (void)setWebPageFileName:(NSString *)fileName ofType:(NSString *)extension {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName
                                                     ofType:extension];
    NSURL *url = [NSURL fileURLWithPath:path];
    [self setWebPageURL:url];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //如果self是navigationController的rootViewController，则添加左滑手势
    if ([self.navigationController.viewControllers firstObject] == self) {
        [self.navigationController.view addGestureRecognizer:self.slidingViewController.panGesture];
    }else {
        self.navigationItem.leftBarButtonItem = nil;
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //如果self是navigationController的rootViewController，则删除左滑手势
    if ([self.navigationController.viewControllers firstObject] == self) {
        [self.navigationController.view removeGestureRecognizer:self.slidingViewController.panGesture];
    }
    
}

- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

+ (NSString *)storyboardID {
    return WebRelatedStoryBoardID;
}

@end
