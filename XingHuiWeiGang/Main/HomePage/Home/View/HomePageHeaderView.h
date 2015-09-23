//
//  HomePageHeaderView.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/10.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeSegmentView.h"
@interface HomePageHeaderView : UIView
+(instancetype)headerView;
@property (weak, nonatomic) IBOutlet UIButton *dishButton;
@property (weak, nonatomic) IBOutlet UIButton *businessButton;
@property (weak, nonatomic) IBOutlet UIButton *salesButton;
@property (weak, nonatomic) IBOutlet UIButton *discountButton;
@property (weak, nonatomic) IBOutlet UIButton *pickButton;
@property (weak, nonatomic) IBOutlet HomeSegmentView *segementView;


@end
