//
//  OrderWillPayViewController.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/28.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//
extern NSString * const DeleteDishNotification;
#import "OrderWillPayViewController.h"
#import "OrderWillPayCell.h"
#import "OrderQRcodeView.h"
#import "OrderTool.h"
#import "orderDishes.h"
#import "MBProgressHUD+MJ.h"
@interface OrderWillPayViewController ()
@property (nonatomic, assign) OrderType ordertype;

@end

@implementation OrderWillPayViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    self.cellClass=[OrderWillPayCell class];
    self.orderStatus = OrderStatusWillPay;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadData) name:DeleteDishNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setOrdertypeNotification:) name:OrderTypeNotification object:nil];

}
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)loadData {
    showMyOrderParam *param = [[showMyOrderParam alloc]init];
    param.userId = @27;
    param.status =[NSNumber numberWithInteger:OrderStatusWillPay];
    param.orderType = [NSNumber numberWithInteger:self.ordertype] ;
    
    __weak typeof(self) Weakself=self;
    [OrderTool showMyOrderWithParam:param success:^(id json) {
        if ([json[@"code"] integerValue]) {
            return ;
        }
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in json[@"list"]) {
            showWillPayOrder *orderResult = [showWillPayOrder objectWithKeyValues:dict];
            [temp addObject:orderResult];
        }
        Weakself.dataArray = temp;
    } failure:^(NSError *error) {
        
    }];
}
- (void)setOrdertypeNotification:(NSNotification *)note {
    
    _ordertype = [note.userInfo[@"OrderType"] integerValue];
}


#pragma mark - action
- (void)deleteDish:(NSNotification *)note {
#warning deletedish
    orderDishes *dish =note.userInfo[@"orderDishesId"];
    NSInteger selctedRow = [note.userInfo[@"row"]integerValue];
    showWillPayOrder *order =self.dataArray[selctedRow];
    NSMutableArray *dishesArray = [ NSMutableArray arrayWithArray:order.dishesInfoList];
    [dishesArray removeObject:dish];
    order.dishesInfoList = dishesArray;
  //  [self.tableView reloadData];
  // [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:selctedRow] withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)QRcodeButtonClick:(UIButton *)btn {
    showWillPayOrder *order = self.dataArray[btn.tag];
    OrderQRcodeView *QRcodeView = [OrderQRcodeView QRcodeView];
    [QRcodeView showQRcodeViewWithOrderSn:[NSString stringWithFormat:@"%@",order.orderSn]];

}
- (void)cancelButtonClick:(UIButton *)btn {
    
    showWillPayOrder *order = self.dataArray[btn.tag];
    updateOrderParam *param = [[updateOrderParam alloc]init];
    param.orderId = order.orderId;
    __weak typeof(self) Weakself=self;
    [OrderTool updateOrderWithParam:param success:^(id json) {
        if ([json[@"code"] integerValue]) {
            return ;
        }
        [MBProgressHUD showSuccess:@"取消成功"];
        [Weakself.dataArray removeObjectAtIndex:btn.tag];
        [Weakself.markArray removeObjectAtIndex:btn.tag];
        
        [Weakself.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
- (void)payButtonClick:(UIButton *)btn {
    
    
}
@end
