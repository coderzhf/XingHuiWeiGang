//
//  OrderDetailViewController.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/29.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "addOrderResult.h"
@interface OrderDetailViewController : UIViewController
@property(nonatomic,strong)addOrderResult *result;
@property (nonatomic, assign) BOOL isPack;
@property (nonatomic, assign) BOOL isWaiting;
@end
