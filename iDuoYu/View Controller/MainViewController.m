//
//  MainViewController.m
//  iDuoYu
//
//  Created by ky01 on 15/4/15.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import "MainViewController.h"
#import "YFGIFImageView.h"
#import "UIImageView+PlayGIF.h"
#import "Constants.h"

@interface MainViewController ()
@property (nonatomic, strong) NSArray *mainItems;
@end

@implementation MainViewController
@synthesize mainItems;

- (void)awakeFromNib
{
    self.mainItems = [NSArray arrayWithObjects:@"设备换钱", @"设备维修", nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat gifHeight = self.view.frame.size.width*215/320;
    UIView *mainTableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, gifHeight)];
    mainTableHeaderView.backgroundColor = [UIColor whiteColor];
    
    //gif动图
    NSData *gifData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"banner.gif" ofType:nil]];
    YFGIFImageView *gifView = [[YFGIFImageView alloc] initWithFrame:CGRectMake(0, 0, mainTableHeaderView.frame.size.width, mainTableHeaderView.frame.size.height)];
    gifView.backgroundColor = [UIColor whiteColor];
    gifView.gifData = gifData;
    [mainTableHeaderView addSubview:gifView];
    [gifView startGIF];
    
    UIView *locationBgView = [[UIView alloc] initWithFrame:CGRectMake(40, 20, self.view.frame.size.width-40*2, 80)];
    locationBgView.backgroundColor = UIColorMake255(30, 90, 130, 0.5);
    locationBgView.layer.cornerRadius = 10.f;
    [mainTableHeaderView addSubview:locationBgView];
    
    UIImageView *bannerBg01 = [[UIImageView alloc] initWithFrame:CGRectMake(4, 4, 32, 32)];
    bannerBg01.image = [UIImage imageNamed:@"MainBanner_01.png"];
    [locationBgView addSubview:bannerBg01];
    
    self.locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 160, 40)];
    self.locationLabel.text = @"北京";
    self.locationLabel.textAlignment = NSTextAlignmentLeft;
    self.locationLabel.textColor = [UIColor whiteColor];
    self.locationLabel.font = [UIFont systemFontOfSize:16.0f];
    [locationBgView addSubview:self.locationLabel];
    
    UIImageView *bannerBg02 = [[UIImageView alloc] initWithFrame:CGRectMake(4, 44, 32, 32)];
    bannerBg02.image = [UIImage imageNamed:@"MainBanner_02.png"];
    [locationBgView addSubview:bannerBg02];
    
    self.personLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, 160, 40)];
    self.personLabel.text = @"5位工程师可为您服务";
    self.personLabel.textAlignment = NSTextAlignmentLeft;
    self.personLabel.textColor = [UIColor whiteColor];
    self.personLabel.font = [UIFont systemFontOfSize:16.0f];
    [locationBgView addSubview:self.personLabel];
    
    self.tableView.tableHeaderView = mainTableHeaderView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.mainItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"MainCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (indexPath.row%2==0) {
        cell.backgroundColor = [UIColor whiteColor];
    }else{
        cell.backgroundColor = UIColorMake255(235, 235, 235, 1);
    }
    cell.textLabel.text = [self.mainItems objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
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
