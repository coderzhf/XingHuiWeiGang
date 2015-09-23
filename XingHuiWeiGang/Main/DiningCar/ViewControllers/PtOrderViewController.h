//
//  PtOrderViewController.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/4.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PtOrderViewController : UIViewController
@property(nonatomic,copy) void (^willPayBlock)(NSString *);
@end
