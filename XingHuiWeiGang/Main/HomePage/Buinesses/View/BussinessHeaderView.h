//
//  BussinessHeaderView.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/14.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BussinessHeaderView : UIView
+(instancetype)headerView;
@property (weak, nonatomic) IBOutlet UIButton *titlebutton;
@property (weak, nonatomic) IBOutlet UIButton *showButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
