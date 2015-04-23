//
//  WebRelatedViewController.h
//  iDuoYu
//
//  Created by ChenAngus on 15/4/23.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const WebRelatedStoryBoardID;

/**
 `WebRelatedViewController` 显示一个web页面的viewController，此viewController的storyBoardID为WebRelated，可以使用UIStoryBoard的相关方法获取此实例
    得到此实例后建议设置此viewController的title，viewController.title = @"..."，
    然后调用
    [viewController setWebPageURL:[NSURL urlWithString:@"www.xxx.com..."]];
    或
    [viewController setWebPageFileName:@"xxx" ofType:@"xxx"];
 TODO 添加 url支持
 */

@interface WebRelatedViewController : UIViewController

/**
 设置此viewController所要显示的web页面
 @param url 要显示的html文件的URL
 */
- (void)setWebPageURL:(NSURL *)url;

/**
 设置此viewController要显示的本地html文件，此方法将会文件名转换成url，然后调用setWebPageURL:
 @param fileName 文件名
 @param extension 扩展名
 */
- (void)setWebPageFileName:(NSString *)fileName ofType:(NSString *)extension;


+ (NSString *)storyboardID;
@end
