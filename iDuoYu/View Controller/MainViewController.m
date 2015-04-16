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
    
    self.tableView.tableHeaderView = mainTableHeaderView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.mainItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"SampleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
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
