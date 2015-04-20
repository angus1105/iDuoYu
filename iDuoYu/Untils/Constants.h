//
//  Constants.h
//  AppStore
//
//  Created by Ke Yuan on 10-10-14.
//  Copyright 2010 k.cn. All rights reserved.
//

#import "Common.h"
#import "Context.h"

#define kNSString 0
#define kNSInteger 1
#define kNSFloat 2
#define kByte 3
#define kNSMutableArray 4
#define kBOOL 5
#define kDate 6
#define kObject 7
#define kChar 8
#define kNSDouble 9

#define IS_ABOVE_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)

#define IS_ABOVE_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)

#define kScreenHeight [Context sharedContext].screenHeight
#define kScreenWitch 320

#define kTabBar 50
#define kTabBarAndPage 65
#define kNavigationBar ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? 64 : 44)
#define kSearchBar 44
#define kToolBarHeight 44
#define kStatusBarHeight ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? 0 : 20)

#define kTimeOut 60

#define HOST @"http://localhost/~chenangus/yii/kscrm/index.php?r=MailProjects/checkMailNotice"  //接口地址

#define kIsSimulationData 1 //是否使用测试数据 1:使用模拟数据 0:使用正式数据
#define DBG 0  //是否打印调试  1:打印调试  0:关闭打印调试

#define UIColorMake255(r, g, b, a) [UIColor colorWithRed:(r)/255.0f\
                                            green:(g)/255.0f\
                                            blue:(b)/255.0f\
                                            alpha:(a)]





