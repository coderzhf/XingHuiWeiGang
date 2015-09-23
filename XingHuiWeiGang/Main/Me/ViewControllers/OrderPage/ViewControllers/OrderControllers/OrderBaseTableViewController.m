//
//  OrderBaseTableViewController.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/19.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "OrderBaseTableViewController.h"
#import "BaseTableViewCell.h"
#import "OrderHeaderView.h"
#import "OrderWillPayBottomView.h"
@interface OrderBaseTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation OrderBaseTableViewController
- (NSMutableArray *)markArray {
    if (!_markArray) {
        _markArray = [NSMutableArray array];
    }
    return _markArray;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self loadData];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    //self.tableView.rowHeight=100;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    self.tableView.showsVerticalScrollIndicator=NO;
    self.tableView.backgroundColor = [UIColor colorWithRed:(245 / 255.0) green:(245 / 255.0) blue:(245 / 255.0) alpha:1];
    [self.view addSubview:self.tableView];
  //  [self loadData];
}
- (void) loadData {
    
}
- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    for (int i=0; i<dataArray.count; i++) {
        BOOL isShow = NO;
        [self.markArray addObject:[NSNumber numberWithBool:isShow]];
        
    }
    [self.tableView registerClass:self.cellClass forCellReuseIdentifier:[self.cellClass description]];

    [self.tableView reloadData];
}
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (!self.dataArray.count) {
        return 0;
    }
    NSArray *rowNums = [self.dataArray[section] valueForKeyPath:@"dishesInfoList"];
    return rowNums.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self.cellClass description] forIndexPath:indexPath];
    if ([self.markArray[indexPath.section] boolValue]) {
        cell.hidden = NO;
        cell.model = [self.dataArray[indexPath.section] valueForKeyPath:@"dishesInfoList"][indexPath.row];
    }else {
        cell.hidden = YES;
    }

    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    OrderHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[OrderHeaderView description]];
    if (!headerView) {
        headerView = [OrderHeaderView headerView];
    }
    headerView.orderHeader = self.dataArray[section];
    headerView.showButton.tag = section;
    [headerView.showButton addTarget:self action:@selector(showButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (![self.markArray[section] boolValue]) {
        return nil;
    }
    OrderWillPayBottomView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[OrderWillPayBottomView description]];
    if (!footerView) {
        footerView = [OrderWillPayBottomView bottomView];
    }
    footerView.orderFooter = self.dataArray[section];
    if (self.orderStatus == OrderStatusWillPay) {
        footerView.QRcodeButton.tag = section;
        footerView.cancelButton.tag = section;
        footerView.payButton.tag = section;
        
        footerView.QRcodeButton.hidden = NO;
        footerView.cancelButton.hidden = NO;
        footerView.payButton.hidden = NO;
        
        [footerView.QRcodeButton addTarget:self action:@selector(QRcodeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [footerView.cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [footerView.payButton addTarget:self action:@selector(payButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }else if (self.orderStatus == OrderStatusDidPay) {
        footerView.applyRefundButton.tag = section;
        footerView.applyRefundButton.hidden = NO;
        [footerView.applyRefundButton addTarget:self action:@selector(applyRefundButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }else if (self.orderStatus == OrderStatusDidFinished) {
        
        footerView.adviceButton.tag = section;
        footerView.adviceButton.hidden = NO;
        [footerView.adviceButton addTarget:self action:@selector(adviceButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 32;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([self.markArray[section] boolValue]) {
        return 70;
    }else {
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.markArray[indexPath.section] boolValue]) {
        return 100;
    }else {
        return 0;
    }
}
#pragma mark - action
//点击查看
- (void)showButtonClick:(UIButton *)btn {
    if (![self.markArray[btn.tag] boolValue]) {
        [self.markArray replaceObjectAtIndex:btn.tag withObject:[NSNumber numberWithBool:YES]];
    }else {
        [self.markArray replaceObjectAtIndex:btn.tag withObject:[NSNumber numberWithBool:NO]];
    }
    [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:btn.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)QRcodeButtonClick:(UIButton *)btn {
   
    
}
- (void)cancelButtonClick:(UIButton *)btn {
    

}
- (void)payButtonClick:(UIButton *)btn {
    
    
}
- (void)applyRefundButtonClick:(UIButton *)btn {
    
}
- (void)adviceButtonClick:(UIButton *)btn {
    
    
}
@end
