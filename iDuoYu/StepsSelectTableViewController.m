//
//  StepsSelectTableViewController.m
//  iDuoYu
//
//  Created by ChenAngus on 15/4/19.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import "StepsSelectTableViewController.h"
#import "CellWithImage.h"

@interface StepsSelectTableViewController ()

@end

@implementation StepsSelectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.items = [NSArray arrayWithObjects:@"iPhone",@"iPad", @"iPod", @"Sumsung", nil];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"stepCell";
    CellWithImage *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier
                                                            forIndexPath:indexPath];
    
    cell.titleLabel.text = [self.items objectAtIndex:[indexPath row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
