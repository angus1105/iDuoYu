//
//  AppDelegate.m
//  iDuoYu
//
//  Created by ChenAngus on 15/4/13.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import "AppDelegate.h"
#import <AFNetworking/UIKit+AFNetworking.h>
#import <AFNetworking/AFNetworkReachabilityManager.h>
#import <Toast/UIView+Toast.h>
#import <NSObject+ObjectMap.h>
#import <GBDeviceInfo.h>
#import "Company.h"
#import "CompanyList.h"

@interface AppDelegate ()

@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"jsonCompanyListTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    CompanyList *companyList = [[CompanyList alloc] initWithJSONData:jsonData];
    
    for (Company *company in companyList.Companys) {
        NSLog(@"CompanyName = %@", company.CompanyName);
        NSLog(@"CompanyAddress = %@", company.CompanyAddress);
    }
    
    NSLog(@"jsonString = %@", [companyList JSONString]);
    NSLog(@"pysical memory = %@", [[GBDeviceInfo deviceInfo] modelString]);

    return YES;
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
