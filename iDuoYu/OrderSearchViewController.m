//
//  OrderSearchViewController.m
//  iDuoYu
//
//  Created by ChenAngus on 15/4/21.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import "OrderSearchViewController.h"
#import "ECSlidingViewController.h"
#import "OrderDetailCell.h"
#import "OrderService.h"
#import "Order.h"
#import "Utils.h"

@interface OrderSearchViewController ()
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray *orderList;

@end

@implementation OrderSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.orderList = [NSMutableArray array];
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

- (void)searchOrder {
    [self.searchBar resignFirstResponder];
    RequestParam *requestParam = [[RequestParam alloc] init];
    requestParam.CustomerMobileNumber = self.searchBar.text;

    [self.orderList removeAllObjects];
    
    if ([self.searchBar.text isEmpty]) {
        self.searchBar.text = @"";
        [self.tableView reloadData];
        return;
    }
    
    [OrderService getOrderList:requestParam
                       success:^(Orders *orders) {
                           [self.orderList addObjectsFromArray:orders.Orders];
                           [self.tableView reloadData];
                       } failure:^(NSError *error) {
                           
                       }];
}

#pragma mark - UISearchBar Delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    UIToolbar *toolbarSearch = [[UIToolbar alloc] init];
    
    UIBarButtonItem *searchBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"搜索", @"搜索")
                                                                            style:UIBarButtonItemStyleBordered target:self
                                                                           action:@selector(searchOrder)];
    NSArray *barButtonItems = @[[[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"取消", @"取消")
                                                                style:UIBarButtonItemStyleBordered target:self action:@selector(searchBarCancelButtonClicked)],
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                searchBarButtonItem];
    [toolbarSearch setItems:barButtonItems];
    [toolbarSearch sizeToFit];
    searchBar.inputAccessoryView = toolbarSearch;
    return YES;
}

- (void)searchBarCancelButtonClicked{
    [self.searchBar resignFirstResponder];
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.orderList.count == 0) {
        return self.view.frame.size.height-44-44;
    }else {
        return 160.f;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.orderList.count == 0) {
        return 1;
    }else {
        return [self.orderList count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.orderList.count == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"emptyCell"
                                                                forIndexPath:indexPath];
        return cell;
    }else {
    
        OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderDetailCell" forIndexPath:indexPath];
        Order *order = [self.orderList objectAtIndexedSubscript:[indexPath row]];
        cell.orderNumberLabel.text = order.OrderSN;
        cell.orderStatusLabel.text = order.OrderStatus;
        cell.modelLabel.text = order.Content;
        cell.priceLabel.text = order.Fee;
        cell.businessTypeLabel.text = order.BusinessType;
        return cell;
    }
}

@end
