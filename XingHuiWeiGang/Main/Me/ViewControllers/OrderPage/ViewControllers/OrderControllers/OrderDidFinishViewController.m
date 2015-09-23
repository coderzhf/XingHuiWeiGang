//
//  OrderDidFinishViewController.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/28.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "OrderDidFinishViewController.h"
#import "EvaluationViewController.h"
#import "OrderDidfinishedCell.h"
#import "OrderTool.h"
@interface OrderDidFinishViewController ()

@end

@implementation OrderDidFinishViewController

- (void)viewDidLoad {
    self.cellClass=[OrderDidfinishedCell class];
    self.orderStatus = OrderStatusDidFinished;
    [super viewDidLoad];
}

- (void)loadData {
    showMyOrderParam *param = [[showMyOrderParam alloc]init];
    param.userId = @27;
    param.status = [NSNumber numberWithInteger:OrderStatusDidFinished];
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
- (void)adviceButtonClick:(UIButton *)btn {
    
    EvaluationViewController *evaluation = [[EvaluationViewController alloc]init];
    showWillPayOrder *order = self.dataArray[btn.tag];
    evaluation.order = order;
    [self.navigationController pushViewController:evaluation animated:YES];
}

@end
