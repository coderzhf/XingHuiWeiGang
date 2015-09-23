//
//  TotalBottomView.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/27.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface TotalBottomView : UIView
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *totalOptionButton;
@property (weak, nonatomic) IBOutlet UIButton *bookButton;
@property (weak, nonatomic) IBOutlet UIButton *PtOrderButton;
@property (weak, nonatomic) IBOutlet UIButton *packButton;
@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable UIColor *groundColor;
+ (instancetype)bottomView;
@end

