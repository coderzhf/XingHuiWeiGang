//
//  OrderDidRefundViewController.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/28.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "OrderDidRefundViewController.h"
#import "OrderDidfinishedCell.h"
#import "OrderTool.h"
@interface OrderDidRefundViewController ()

@end

@implementation OrderDidRefundViewController

- (void)viewDidLoad {
    self.cellClass=[OrderDidfinishedCell class];
    self.orderStatus = OrderStatusDidRefund;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)loadData {
    showMyOrderParam *param = [[showMyOrderParam alloc]init];
    param.userId = @27;
    param.status =[NSNumber numberWithInteger:OrderStatusDidRefund];
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

@end
