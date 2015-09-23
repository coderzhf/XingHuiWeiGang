//
//  OrderQRcodeView.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/20.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderQRcodeView : UIView
+ (instancetype)QRcodeView;
- (void)showQRcodeViewWithOrderSn:(NSString *)OrderSn;
@end
