//
//  ChooseAlert.m
//  iDuoYu
//
//  Created by ChenAngus on 15/4/15.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import "ChooseAlert.h"

@implementation ChooseAlert

UIWindow *_backgroundWindow;

+ (id)newChooseAlert {
    
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"ChooseAlert"
                                                  owner:nil
                                                options:nil];
    
    if (nibs.count > 0) {
        return [nibs objectAtIndex:0];
    }
    
    return nil;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}

- (void)setMasksToBounds:(BOOL)masksToBounds {
    self.layer.masksToBounds = masksToBounds;
}

- (IBAction)buttonClicked:(id)sender {
    if ([self.chooseAlertDelegate respondsToSelector:@selector(chooseAlert:didSelectAtIndex:)]) {
        [self.chooseAlertDelegate chooseAlert:self
                             didSelectAtIndex:[sender tag]];
    }else {
        [self hide];
    }
}

- (void)show {
    _backgroundWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _backgroundWindow.windowLevel = UIWindowLevelAlert;
    _backgroundWindow.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    _backgroundWindow.hidden = NO;

    self.frame = CGRectMake(30, 110, [[UIScreen mainScreen] bounds].size.width-60, [[UIScreen mainScreen] bounds].size.height-110-20);
    [_backgroundWindow addSubview:self];
    
    UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] init];
    [gesture addTarget:self
                action:@selector(hide)];
    [_backgroundWindow addGestureRecognizer:gesture];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         _backgroundWindow.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
                     }];
}

- (void)hide {
    _backgroundWindow.alpha = 0.6;
    [UIView animateWithDuration:0.3
                     animations:^{
                         _backgroundWindow.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
                         _backgroundWindow.alpha = 0;
                     } completion:^(BOOL finished) {
                         _backgroundWindow.hidden = YES;
                         _backgroundWindow = nil;
                     }];
}



@end
