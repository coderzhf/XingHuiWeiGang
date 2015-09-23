//
//  OrderHeaderView.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/28.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "OrderHeaderView.h"
#import "showWillPayOrder.h"
@interface OrderHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *issueTime;
@property (weak, nonatomic) IBOutlet UILabel *orderSn;

@end
@implementation OrderHeaderView

+ (instancetype)headerView {
    return [[[NSBundle mainBundle]loadNibNamed:@"OrderHeaderView" owner:self options:nil]firstObject];
}
- (void)setOrderHeader:(showWillPayOrder *)orderHeader {
    _orderHeader = orderHeader;
    self.issueTime.text = orderHeader.issueTime;
    self.orderSn.text = [NSString stringWithFormat:@"%@",orderHeader.orderSn];
}
@end
