//
//  OrderDidPayViewController.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/28.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "OrderDidPayViewController.h"
#import "OrderDidfinishedCell.h"
#import "OrderRefundView.h"
#import "MBProgressHUD+MJ.h"
#import "OrderTool.h"
@interface OrderDidPayViewController ()
@property (nonatomic, assign) OrderType ordertype;

@end

@implementation OrderDidPayViewController

- (void)viewDidLoad {
    self.cellClass=[OrderDidfinishedCell class];
    self.orderStatus = OrderStatusDidPay;
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setOrdertypeNotification:) name:OrderTypeNotification object:nil];
    
}
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)loadData {
    showMyOrderParam *param = [[showMyOrderParam alloc]init];
    param.userId = @27;
    param.status =[NSNumber numberWithInteger:OrderStatusDidPay];
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
- (void)applyRefundButtonClick:(UIButton *)btn {
    showWillPayOrder *order = self.dataArray[btn.tag];
    OrderRefundView *refundView = [OrderRefundView orderRefundView];
    refundView.order = order;
    [refundView showRefundViewToView];
   
}
- (void)setOrdertypeNotification:(NSNotification *)note {
    
    _ordertype = [note.userInfo[@"OrderType"] integerValue];
}


@end
