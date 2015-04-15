//
//  ChooseAlert.h
//  iDuoYu
//
//  Created by ChenAngus on 15/4/15.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ChooseAlertProtocol;

IB_DESIGNABLE
@interface ChooseAlert : UIView
/**
 机型图片
 */
@property (strong, nonatomic) IBOutlet UIImageView *modelImageView;

/**
 机型描述. e.g. iPhone 6 Plus - 中国移动
 */
@property (strong, nonatomic) IBOutlet UILabel *modelDescriptionLabel;

/**
 存储容量. e.g. 16 GB
 */
@property (strong, nonatomic) IBOutlet UILabel *ramLabel;

@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable BOOL masksToBounds;

@property (weak, nonatomic) id <ChooseAlertProtocol> chooseAlertDelegate;

/**
 利用ChooseAlert.xib初始化一个对话框。
 注意，不要使用 XXX xxx = [[XXX alloc] initXXX] 的方式初始化
 */
+ (id)newChooseAlert;

/**
 显示对话框
 */
- (void)show;
/**
 隐藏对话框
 */
- (void)hide;

@end

@protocol ChooseAlertProtocol <NSObject>

- (void)chooseAlert:(ChooseAlert *)alert didSelectAtIndex:(NSInteger)index;

@end