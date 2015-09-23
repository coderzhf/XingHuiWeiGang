//
//  OrderBottomView.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/28.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>
@class showWillPayOrder;
@interface OrderWillPayBottomView : UIView
+ (instancetype)bottomView;
@property (nonatomic, strong)showWillPayOrder *orderFooter;
@property (weak, nonatomic) IBOutlet UIButton *QRcodeButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (weak, nonatomic) IBOutlet UIButton *applyRefundButton;
@property (weak, nonatomic) IBOutlet UIButton *adviceButton;
@end
