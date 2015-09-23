//
//  DiscountViewController.h
//  XingHuiWeiGang
//
//  Created by zx on 15/8/6.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "BaseViewController.h"
@class ShakeDiscountModel;
@interface DiscountViewController : BaseViewController

@property (nonatomic ,assign) BOOL isAll;

@property (nonatomic ,strong) ShakeDiscountModel *shakeDiscountModel;
@end
