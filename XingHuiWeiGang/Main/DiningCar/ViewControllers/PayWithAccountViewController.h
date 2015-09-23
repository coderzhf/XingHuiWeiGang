//
//  PayWithAccountViewController.h
//  XingHuiWeiGang
//
//  Created by zx on 15/8/26.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "showOrderResult.h"

@interface PayWithAccountViewController : UIViewController
@property(nonatomic,strong)showOrderResult *OrderResult;
@property(nonatomic,assign)BOOL isAppointment;

@end
