//
//  OrderHeaderView.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/28.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>
@class showWillPayOrder;
@interface OrderHeaderView : UIView
+ (instancetype)headerView;
@property (nonatomic, strong)showWillPayOrder *orderHeader;
@property (weak, nonatomic) IBOutlet UIButton *showButton;
@end
