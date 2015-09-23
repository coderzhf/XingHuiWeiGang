//
//  DinnerCarSectionHeaderView.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/23.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "DinnerCarSectionHeaderView.h"

@implementation DinnerCarSectionHeaderView

+ (instancetype)headerView {
    return [[[NSBundle mainBundle]loadNibNamed:@"DinnerCarSectionHeaderView" owner:self options:nil]firstObject];
}

@end
