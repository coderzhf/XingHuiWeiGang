//
//  OrderRefundView.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/24.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>
@class showWillPayOrder;
@interface OrderRefundView : UIView
+ (instancetype)orderRefundView;
- (void)showRefundViewToView;
@property (nonatomic, strong) showWillPayOrder *order;
@end
